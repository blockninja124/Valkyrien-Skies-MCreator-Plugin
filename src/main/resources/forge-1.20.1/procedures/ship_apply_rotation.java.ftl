{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship});

        forceInducer.addRotation(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.${field$mode});
    }
}