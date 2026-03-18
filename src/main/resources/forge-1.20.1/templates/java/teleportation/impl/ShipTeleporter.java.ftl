package ${package}.ships.teleportation.impl;

public class ShipTeleporter {

    public static void teleportShip(
            long id,
            TeleportData data,
            ServerLevel newLevel,
            VsiServerShipWorld shipWorld
    ) {
        LoadedServerShip ship = shipWorld.getLoadedShips().getById(id);
        if (ship == null) {
            return;
        }
        ship.setStatic(false);

        ShipTeleportData teleportData = createTeleportData(data, newLevel);
        shipWorld.teleportShip(ship, teleportData);

        applyPostTeleportVelocity(shipWorld, id, ship, data);
    }

    private static ShipTeleportData createTeleportData(
            TeleportData data,
            ServerLevel level
    ) {
        String vsDimName = VSGameUtilsKt.getDimensionId(level);

        return new ShipTeleportDataImpl(
                data.newPos(),
                data.rotation(),
                data.velocity(),
                data.omega(),
                vsDimName,
                1.0,
                null
        );
    }

    private static void applyPostTeleportVelocity(
            VsiServerShipWorld shipWorld,
            long id,
            LoadedServerShip ship,
            TeleportData data
    ) {
        Vector3dc velocity = data.velocity();
        Vector3dc omega = data.omega();

        if (velocity.lengthSquared() == 0 && omega.lengthSquared() == 0) {
            return;
        }

        ship.setTransformProvider(createVelocityTransformProvider(shipWorld, id, velocity, omega));
    }

    private static ServerShipTransformProvider createVelocityTransformProvider(
            VsiServerShipWorld shipWorld,
            long id,
            Vector3dc velocity,
            Vector3dc omega
    ) {
        return (prevTransform, transform) -> {

            LoadedServerShip ship = shipWorld.getLoadedShips().getById(id);
            if (ship == null) {
                return null;
            }

            if (!hasTransformChanged(prevTransform, transform)) {
                if (ship.getVelocity().lengthSquared() == 0 &&
                        ship.getAngularVelocity().lengthSquared() == 0) {

                    return new ServerShipTransformProvider.NextTransformAndVelocityData(
                            transform,
                            velocity,
                            omega
                    );
                }
            } else {
                ship.setTransformProvider(null);
            }

            return null;
        };
    }

    private static boolean hasTransformChanged(
            ShipTransform prevTransform,
            ShipTransform transform
    ) {
        return !prevTransform.getPositionInWorld().equals(transform.getPositionInWorld())
                || !prevTransform.getShipToWorldRotation().equals(transform.getShipToWorldRotation());
    }
}
