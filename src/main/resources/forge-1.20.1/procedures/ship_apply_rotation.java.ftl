{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((ServerShip) tempShip);

        forceInducer.addRotation(VectorConversionsMCKt.toJOML(${input$vec}.scale(${input$strength})), ForceMode.${field$mode});
    }
}