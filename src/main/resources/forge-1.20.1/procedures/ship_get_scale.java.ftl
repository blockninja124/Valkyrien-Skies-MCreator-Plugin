<#-- @formatter:off -->
(
    (${input$ship} instanceof ServerShip) ?
        ((ServerShip) ${input$ship}).getTransform().getShipToWorldScaling().x() :
        0
)
<#-- @formatter:on -->