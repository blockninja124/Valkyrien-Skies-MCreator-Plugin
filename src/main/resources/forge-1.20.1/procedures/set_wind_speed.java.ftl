<#-- @formatter:off -->
{
    if (${input$ship} instanceof VsiLoadedServerShip vsiShip) {
        vsiShip.getDragController().setWindSpeed(${input$speed});
    }
}
<#-- @formatter:on -->
