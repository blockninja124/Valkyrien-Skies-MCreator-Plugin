<#-- @formatter:off -->
(
    (${input$ship} instanceof LoadedServerShip) ?
        ((LoadedServerShip) ${input$ship}).getTransform().getShipToWorldScaling().x() :
        0
)
<#-- @formatter:on -->