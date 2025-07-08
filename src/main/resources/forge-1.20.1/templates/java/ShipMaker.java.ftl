package ${package}.ships;

public class ShipMaker {

    public static Ship assembleShip(ServerLevel level, BlockPos pos, double scale) {
        if (!level.getBlockState(pos).isAir()) {

            ServerShip parentShip = VSGameUtilsKt.getShipManagingPos(level, pos);

			ServerShip serverShip = VSGameUtilsKt.getShipObjectWorld(level).createNewShipAtBlock(VectorConversionsMCKt.toJOML(pos), false, scale, VSGameUtilsKt.getDimensionId(level));
			Vector3i centerVec = new Vector3i();
			serverShip.getChunkClaim().getCenterBlockCoordinates(VSGameUtilsKt.getYRange(level), centerVec);
			BlockPos centerPos = VectorConversionsMCKt.toBlockPos(centerVec);

			// Move the block from the world to a ship
			RelocationUtilKt.relocateBlock(level, pos, centerPos, true, serverShip, Rotation.NONE);

			// Compute the ship transform
			var newShipPosInWorld =
					parentShip.getShipToWorld().transformPosition(VectorConversionsMCKt.toJOMLD(pos).add(0.5, 0.5, 0.5));
			var newShipPosInShipyard = VectorConversionsMCKt.toJOMLD(pos).add(0.5, 0.5, 0.5);
			var newShipRotation = parentShip.getTransform().getShipToWorldRotation();
			var newShipScaling = parentShip.getTransform().getShipToWorldScaling().mul(scale, new Vector3d());

			var newKinematics = BodyKinematicsFactory.INSTANCE.create(
					new Vector3d(),
					new Vector3d(),
					newShipPosInWorld,
					newShipRotation,
					newShipScaling,
					newShipPosInShipyard
			);
			((org.valkyrienskies.core.impl.game.ships.ShipDataCommon) parentShip).setKinematics(newKinematics);

            return serverShip;
        } else {
            return null;
        }
	}
}