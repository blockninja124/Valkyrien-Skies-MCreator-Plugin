{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship});

        ForceData data = new ForceData(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.GLOBAL, ForceDirectionMode.${field$dirmode});

        forceInducer.addForce(new BlockPos(0, 0, 0), data);
    }
}