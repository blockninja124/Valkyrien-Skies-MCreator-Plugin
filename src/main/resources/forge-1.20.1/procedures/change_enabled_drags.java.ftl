<#-- @formatter:off -->
{
    if (${input$ship} instanceof VsiLoadedServerShip vsiShip) {
        vsiShip.getDragController().${field$action}${field$stat}();
    }
}
<#-- @formatter:on -->
