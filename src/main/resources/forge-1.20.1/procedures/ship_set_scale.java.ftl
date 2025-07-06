<#-- @formatter:off -->
{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip && world instanceof ServerLevel) {
        ValkyrienSkiesMod.vsCore.scaleShip(VSGameUtilsKt.getShipObjectWorld((ServerLevel) world), (ServerShip) tempShip, ${input$scale});
    }
}
<#-- @formatter:on -->