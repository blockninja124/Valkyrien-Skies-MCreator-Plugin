{
    if (world instanceof ServerLevel sl && ${input$ship} instanceof Ship) {
        ServerLevel newLvl = TeleportHandler.dimToLevel(${input$str});
        if (newLvl != null) {
           //new TeleportHandler(newLvl, sl, false).handleTeleport(${input$ship}, VectorConversionsMCKt.toJOML(${input$vec}));
        }
    }
}
