{
    Ship tempShip = ${input$ship};
    if (world instanceof ServerLevel sl && tempShip != null) {
        ServerLevel newLvl = TeleportHandler.dimToLevel(${input$str});
        if (newLvl != null) {
           new TeleportHandler(newLvl, sl, false).handleTeleport(tempShip, VectorConversionsMCKt.toJOML(${input$vec}));
        }
    }
}
