{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship});

        ForceData data = new ForceData(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.POSITION, ForceDirectionMode.${field$dirmode});

        forceInducer.addForce(${input$pos}, data);
    }
}