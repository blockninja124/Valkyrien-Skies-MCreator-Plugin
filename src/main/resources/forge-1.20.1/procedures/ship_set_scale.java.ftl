<#-- @formatter:off -->
{
    if (${input$ship} instanceof ServerShip && world instanceof ServerLevel) {
        ValkyrienSkiesMod.vsCore.scaleShip(VSGameUtilsKt.getShipObjectWorld((ServerLevel) world), (ServerShip) ${input$ship}, ${input$scale});
    }
}
<#-- @formatter:on -->