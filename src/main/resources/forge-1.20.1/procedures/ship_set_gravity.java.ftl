
<#-- @formatter:off -->
{
    if (${input$ship} instanceof ServerShip) {
        GravityInducedShips.getOrCreate((ServerShip) ${input$ship}).setGravity(${input$val});
    }
}
<#-- @formatter:on -->