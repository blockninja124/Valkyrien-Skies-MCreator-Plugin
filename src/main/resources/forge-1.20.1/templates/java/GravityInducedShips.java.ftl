package ${package}.ships;

public final class GravityInducedShips implements ShipPhysicsListener {

    private volatile double gravity = 1;

    public GravityInducedShips() {}

    @Override
    public void physTick(@NotNull PhysShip physicShip, @NotNull PhysLevel physLevel) {
        PhysShipImpl physShip = (PhysShipImpl) physicShip;

        double shipGravity = (1 - this.gravity) * 10 * physShip.getMass();
        physShip.applyInvariantForce(new Vector3d(0, shipGravity, 0));
    }

    public void setGravity(Number newGrav) {
        gravity = newGrav.doubleValue();
    }

    public Number getGravity() {
        return gravity;
    }


    public static GravityInducedShips getOrCreate(LoadedServerShip ship) {
        GravityInducedShips attachment = ship.getAttachment(GravityInducedShips.class);
        if (attachment == null) {
            attachment = new GravityInducedShips();
            ship.setAttachment(GravityInducedShips.class, attachment);
        }
        return attachment;
    }

    public static GravityInducedShips get(Level level, BlockPos pos) {
        if (level instanceof ServerLevel serverLevel) {
            LoadedServerShip ship = VSGameUtilsKt.getLoadedShipManagingPos(serverLevel, pos);

            return ship != null ? getOrCreate(ship) : null;
        }
        return null;
    }
}
