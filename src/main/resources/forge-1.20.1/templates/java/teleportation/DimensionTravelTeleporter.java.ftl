package ${package}.ships.teleportation;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class DimensionTravelTeleporter {

    private static final ConcurrentHashMap<Long, Long> shipCooldownExpiry = new ConcurrentHashMap<>();

    public static void teleportShip(
            ServerShip ship,
            TravelDirection direction,
            ServerLevel oldLevel,
            ServerLevel newLevel,
            Vector3dc newPosition,
            Quaterniondc newRotation,
            int entityRange,
            double shipRange
    ) {
        long gameTime = oldLevel.getGameTime();
        if (shouldSkip(ship.getId(), gameTime)) return;

        Vector3dc origin = ship.getTransform().getPositionInWorld();
        VsiServerShipWorld shipWorld = VSGameUtilsKt.getShipObjectWorld(oldLevel);

        ShipCollector collector = new ShipCollector(direction, shipWorld, shipRange);
        Map<Long, TeleportData> ships = collector.collectConnected(ship.getId(), origin, newPosition, newRotation);

        for (Long shipID : ships.keySet()) {
            if (shouldSkip(shipID, gameTime)) return;
        }

        for (Long shipID : ships.keySet()) {
            markShip(shipID, gameTime);
        }

        EntityCollector entityCollector = new EntityCollector(oldLevel, entityRange);
        Map<Entity, Vec3> entities = entityCollector.collect(collector.getCollectedShips(), origin, newPosition, newRotation);

        for (var entry : ships.entrySet()) {
            ShipTeleporter.teleportShip(entry.getKey(), entry.getValue(), newLevel, shipWorld);
        }

        for (var entry : entities.entrySet()) {
            EntityTeleporter.teleportEntityAndPassengers(entry.getKey(), newLevel, entry.getValue(), newRotation);
        }
    }

    private static boolean shouldSkip(long shipId, long currentTick) {
        return currentTick < shipCooldownExpiry.getOrDefault(shipId, 0L);
    }

    private static void markShip(long shipId, long currentTick) {
        shipCooldownExpiry.put(shipId, currentTick + 20);
    }

    public static ServerLevel dimToLevel(final String dimensionString) {
        return ValkyrienSkiesMod.getCurrentServer().getLevel(ResourceKey.create(Registries.DIMENSION, new ResourceLocation(dimensionString)));
    }
}
