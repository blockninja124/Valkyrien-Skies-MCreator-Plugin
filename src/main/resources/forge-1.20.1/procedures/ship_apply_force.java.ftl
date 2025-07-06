{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips forceInducer = ForceInducedShips.getOrCreate((ServerShip) tempShip);

        ForceData data = new ForceData(VectorConversionsMCKt.toJOML(${input$vec}), ${input$strength}, ForceMode.GLOBAL, ForceDirectionMode.${field$dirmode});

        forceInducer.addForce(new BlockPos(0, 0, 0), data);
    }
}