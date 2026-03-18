package ${package}.ships.teleportation.impl;

public class EntityCollector {

    private final ServerLevel oldLevel;
    private final Map<Entity, Vec3> entityStorage = new HashMap<>();

    private int entityCollectRange = 48;

    public EntityCollector(ServerLevel oldLevel) {
        this.oldLevel = oldLevel;
    }

    public EntityCollector(ServerLevel oldLevel, int entityCollectRange) {
        this.oldLevel = oldLevel;
        this.entityCollectRange = entityCollectRange;
    }

    public Map<Entity, Vec3> collect(
            List<ServerShip> ships,
            Vector3dc origin,
            Vector3dc newPos,
            Quaterniondc rotation
    ) {
        ships.forEach(ship -> addEntitiesForShip(ship, origin, newPos, rotation));

        return entityStorage;
    }

    private void addEntitiesForShip(ServerShip ship, Vector3dc origin, Vector3dc newPos, Quaterniondc rotation) {
        AABBd worldAABB = new AABBd(ship.getWorldAABB());
        AABBic shipAABB = ship.getShipAABB();

        if (shipAABB != null) {
            AABBd shipAABBd = new AABBd(shipAABB.minX(), shipAABB.minY(), shipAABB.minZ(), shipAABB.maxX(), shipAABB.maxY(), shipAABB.maxZ());

            oldLevel.getEntities(
                    (Entity) null,
                    VectorConversionsMCKt.toMinecraft(shipAABBd).inflate(entityCollectRange),
                    entity -> !entityStorage.containsKey(entity)
            ).forEach(entity -> addEntity(entity, origin, newPos, rotation));

            worldAABB.union(shipAABBd.transform(ship.getPrevTickTransform().getShipToWorld()));
        }

        oldLevel.getEntities(
                (Entity) null,
                VectorConversionsMCKt.toMinecraft(worldAABB).inflate(entityCollectRange/6.0),
                entity -> !entityStorage.containsKey(entity)
        ).forEach(entity ->
            addEntity(entity, origin, newPos, rotation)
        );
    }

    private void addEntity(Entity entity, Vector3dc origin, Vector3dc newPos, Quaterniondc rotation) {
        Entity root = entity.getRootVehicle();
        if (entityStorage.containsKey(root)) {
            return;
        }
        Vec3 pos = root.position();
        if (!VSGameUtilsKt.isBlockInShipyard(oldLevel, pos)) {
            Vector3d relPos = VectorConversionsMCKt.toJOML(pos).sub(origin);
            rotation.transform(relPos);
            relPos.add(newPos);
            pos = VectorConversionsMCKt.toMinecraft(relPos);
        }
        entityStorage.put(root, pos);
    }
}
