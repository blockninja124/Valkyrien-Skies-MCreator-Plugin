{
    if (world instanceof ServerLevel && ${input$ship} instanceof Ship) {
        ServerLevel newLvl = TeleportHandler.dimToLevel(${input$str});
        if (newLvl != null) {
           new TeleportHandler(newLvl, (ServerLevel) world, false).handleTeleport(${input$ship}, VectorConversionsMCKt.toJOML(${input$vec}));
        }
    }
}
