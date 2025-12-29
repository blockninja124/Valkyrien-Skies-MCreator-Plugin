package ${package}.ships;

@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD, modid = "${modid}")
public class OnShipLoad {
    @SubscribeEvent
    public static void onCommonSetup(FMLCommonSetupEvent event) {
        ValkyrienSkies.api().registerAttachment(ForceInducedShips.class);
        ValkyrienSkies.api().registerAttachment(GravityInducedShips.class);
        ValkyrienSkies.api().registerAttachment(ShipLandingAttachment.class);

        VSEvents.ShipLoadEvent.Companion.on((shipLoadEvent) -> {
            ForceInducedShips.getOrCreate(shipLoadEvent.getShip());
            GravityInducedShips.getOrCreate(shipLoadEvent.getShip());
        });
    }
}