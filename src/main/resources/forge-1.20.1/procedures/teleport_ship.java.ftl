{
    if (world instanceof ServerLevel && ${input$ship} instanceof Ship) {
        //TODO: FIX
        throw new NotImplementedException("Teleport function not working yet on 2.4");
        //new TeleportHandler((ServerLevel) world, (ServerLevel) world, false).handleTeleport(${input$ship}, VectorConversionsMCKt.toJOML(${input$vec}));
    }
}