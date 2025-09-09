package ${package}.ships;

@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD, modid = "${modid}")
public class OnShipLoad {
    @SubscribeEvent
    public static void onCommonSetup(FMLCommonSetupEvent event) {
        VSEvents.ShipLoadEvent.Companion.on((shipLoadEvent) -> {
            ForceInducedShips.getOrCreate(shipLoadEvent.getShip());
            GravityInducedShips.getOrCreate(shipLoadEvent.getShip());
        });

        AttachmentRegistration registration = ValkyrienSkies.api()
            .newAttachmentRegistrationBuilder(ForceInducedShips.class)
            .useLegacySerializer()
            .build();

        ValkyrienSkies.api().registerAttachment(registration);
    }
}