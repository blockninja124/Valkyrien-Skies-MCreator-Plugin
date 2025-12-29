{
    if (world instanceof ServerLevel sl && ${input$ship} instanceof Ship) {
        //TODO: FIX
        throw new NotImplementedException("Teleport function not working yet on 2.4");
        //new TeleportHandler(sl, sl, false).handleTeleport(${input$ship}, VectorConversionsMCKt.toJOML(${input$vec}));
    }
}