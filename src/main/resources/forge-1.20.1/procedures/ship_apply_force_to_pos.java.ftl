{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((ServerShip) tempShip);

        ForceData data = new ForceData(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.POSITION, ForceDirectionMode.${field$dirmode});

        forceInducer.addForce(${input$pos}, data);
    }
}