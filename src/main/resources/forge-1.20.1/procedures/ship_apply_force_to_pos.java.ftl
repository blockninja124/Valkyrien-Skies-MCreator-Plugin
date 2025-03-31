{
    if (${input$ship} instanceof ServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((ServerShip) ${input$ship});

        ForceData data = new ForceData(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.POSITION, ForceDirectionMode.${field$dirmode});

        forceInducer.addForce(${input$pos}, data);
    }
}