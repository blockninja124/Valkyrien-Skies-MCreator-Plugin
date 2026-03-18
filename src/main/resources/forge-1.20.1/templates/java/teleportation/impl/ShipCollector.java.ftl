package ${package}.ships.teleportation.impl;

@ApiStatus.Internal
public class ShipCollector {

	private static Map<Long, Set<Integer>> SHIP2CONSTRAINTS = Map.of();
	private static Map<Integer, VSJoint> ID2CONSTRAINT;

	private double ship_collect_range = 10;

	final private TravelDirection direction;
	final private VsiServerShipWorld shipWorld;

	final private Long2ObjectOpenHashMap<TeleportData> ships = new Long2ObjectOpenHashMap<>();
	final private List<ServerShip> collectedShips = new ArrayList<>();
	private double greatestOffset;

	public ShipCollector(
		TravelDirection direction,
		VsiServerShipWorld shipWorld
	) {
		this.direction = direction;
		this.shipWorld = shipWorld;
	}

	public ShipCollector(
    		TravelDirection direction,
    		VsiServerShipWorld shipWorld,
    		double shipCollectRange
    	) {
    		this.direction = direction;
    		this.shipWorld = shipWorld;
    		this.ship_collect_range = shipCollectRange;
    	}

	public static void onPhysTick(PhysTickEvent event) {
		VsiPhysLevel level = (VsiPhysLevel) event.getWorld();
		if (SHIP2CONSTRAINTS.isEmpty()) {
			SHIP2CONSTRAINTS = level.getJointsByShipIds();
			ID2CONSTRAINT = level.getAllJoints();
		}
	}

	public Map<Long, TeleportData> collectConnected(
			long rootShipId,
			Vector3dc origin,
			Vector3dc newPos,
			Quaterniondc rotation
	) {
		return collectConnected(rootShipId, origin, newPos, rotation, null, null);
	}

	public Map<Long, TeleportData> collectConnected(
		long rootShipId,
		Vector3dc origin,
		Vector3dc newPos,
		Quaterniondc rotation,
		Vector3dc velocity,
		Vector3dc omega
	) {
		this.greatestOffset = 0;
		this.collectConnected(rootShipId, origin, newPos, rotation, velocity, omega, this.collectedShips);
		this.collectNearbyShips(this.collectedShips, origin, newPos, rotation);
		this.finish(this.collectedShips, rotation);
		return this.ships;
	}

	public List<ServerShip> getCollectedShips() {
		return this.collectedShips;
	}

	private void collectConnected(long shipId, Vector3dc origin, Vector3dc newPos, Quaterniondc rotation, List<ServerShip> collected) {
		this.collectConnected(shipId, origin, newPos, rotation, null, null, collected);
	}

	private void collectConnected(
		long shipId,
		Vector3dc origin,
		Vector3dc newPos,
		Quaterniondc rotation,
		Vector3dc velocity,
		Vector3dc omega,
		List<ServerShip> collected
	) {
		if (this.ships.containsKey(shipId)) {
			return;
		}
		ServerShip ship = this.getShip(shipId);
		if (!(ship instanceof LoadedServerShip loadedShip)) {
			return;
		}
        Vector3dc pos = loadedShip.getTransform().getPositionInWorld();
		if (velocity == null) {
			velocity = new Vector3d(loadedShip.getVelocity());
		}
		if (omega == null) {
			omega = new Vector3d(loadedShip.getAngularVelocity());
		}
		collected.add(loadedShip);

		Vector3d relPos = pos.sub(origin, new Vector3d());
		Quaterniond newRotation = new Quaterniond(loadedShip.getTransform().getShipToWorldRotation());

		if (this.direction == TravelDirection.PLANET_TO_SPACE) {
			double offset = relPos.y;
			if (offset < this.greatestOffset) {
				this.greatestOffset = offset;
			}
		}

		rotation.transform(relPos);
		velocity = rotation.transform(velocity, new Vector3d());
		newRotation.premul(rotation).normalize();

		if (this.direction == TravelDirection.SPACE_TO_PLANET) {
			double offset = relPos.y;
			if (offset > this.greatestOffset) {
				this.greatestOffset = offset;
			}
		}

		relPos.add(newPos);
		Vector3d velocity0 = new Vector3d(velocity);
		Vector3d omega0 = new Vector3d(omega);

		if (this.direction == TravelDirection.PLANET_TO_SPACE) {
			velocity0.mul(0.0625);
		} else {
			velocity0.mul(2);
		}

		this.ships.put(
			shipId,
			new TeleportData(
				relPos,
				newRotation,
				velocity0,
				omega0
			)
		);

		Set<Integer> constraints = SHIP2CONSTRAINTS.get(shipId);
		if (constraints != null) {

			new HashSet<>(constraints).stream().map(ID2CONSTRAINT::get).forEach((constraint) -> {
				Long id = constraint.getShipId0();
				if (id != null) {
					this.collectConnected(id, origin, newPos, rotation, collected);
				}
				id = constraint.getShipId1();
				if (id != null) {
					this.collectConnected(id, origin, newPos, rotation, collected);
				}
			});
		}
	}

	private void collectNearbyShips(List<ServerShip> collected, Vector3dc origin, Vector3dc newPos, Quaterniondc rotation) {
		QueryableShipData<LoadedServerShip> loadedShips = this.shipWorld.getLoadedShips();

		for (int i = 0; i < collected.size(); i++) {
			AABBdc shipBox = collected.get(i).getWorldAABB();
			AABBd box = new AABBd(
				shipBox.minX() - ship_collect_range, shipBox.minY() - ship_collect_range, shipBox.minZ() - ship_collect_range,
				shipBox.maxX() + ship_collect_range, shipBox.maxY() + ship_collect_range, shipBox.maxZ() + ship_collect_range);
			for (ServerShip ship : loadedShips.getIntersecting(box)) {
				this.collectConnected(ship.getId(), origin, newPos, rotation, collected);
			}
		}
	}

	private void finish(List<ServerShip> collected, Quaterniondc rotation) {
		Vector3d offset = new Vector3d(0, -this.greatestOffset, 0);
		if (this.direction == TravelDirection.PLANET_TO_SPACE) {
			rotation.transform(offset);
		}
		for (ServerShip ship : collected) {
			long id = ship.getId();
			Vector3d shipNewPos = this.ships.get(id).newPos();
			shipNewPos.add(offset);
		}
	}

	private ServerShip getShip(long shipId) {
		ServerShip ship = this.shipWorld.getLoadedShips().getById(shipId);
		if (ship != null) {
			return ship;
		}
		return this.shipWorld.getAllShips().getById(shipId);
	}
}
