<#-- @formatter:off -->
{
    if (${input$ship} instanceof VsiLoadedServerShip vsiShip) {
        vsiShip.getDragController().setWindDirection(VectorConversionsMCKt.toJOML(${input$dir}));
    }
}
<#-- @formatter:on -->
