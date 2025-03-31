{
    if (${input$ship} instanceof ServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((ServerShip) ${input$ship});

        forceInducer.addRotation(VectorConversionsMCKt.toJOML(${input$vec}.scale(${input$strength})), ForceMode.${field$mode});
    }
}