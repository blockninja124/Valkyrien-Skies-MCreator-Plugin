{
    Ship tempShip = ${input$ship};
    if (world instanceof ServerLevel sl && tempShip != null) {
        new TeleportHandler(sl, sl, false).handleTeleport(tempShip, VectorConversionsMCKt.toJOML(${input$vec}));
    }
}