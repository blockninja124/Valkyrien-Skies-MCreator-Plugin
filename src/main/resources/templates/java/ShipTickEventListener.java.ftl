package ${package}.ships;

@Mod.EventBusSubscriber
public class ShipTickEventListener {
    @SubscribeEvent(priority = EventPriority.HIGH)
    public static void onServerTick(TickEvent.ServerTickEvent event) {
        for (ServerLevel level: event.getServer().getAllLevels()) {
            for (Ship ship : ShipUtils.getAllLoadedShips(level)) {
                ShipTickEvent event = new ShipTickEvent(ship, level);
                MinecraftForge.EVENT_BUS.post(event);
            }
        }
    }
}
