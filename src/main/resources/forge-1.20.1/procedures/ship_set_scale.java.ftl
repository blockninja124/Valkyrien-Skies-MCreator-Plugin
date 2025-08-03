<#-- @formatter:off -->
{
    if (${input$ship} instanceof LoadedServerShip && world instanceof ServerLevel) {
        ValkyrienSkiesMod.vsCore.scaleShip(VSGameUtilsKt.getShipObjectWorld((ServerLevel) world), (LoadedServerShip) ${input$ship}, ${input$scale});
    }
}
<#-- @formatter:on -->