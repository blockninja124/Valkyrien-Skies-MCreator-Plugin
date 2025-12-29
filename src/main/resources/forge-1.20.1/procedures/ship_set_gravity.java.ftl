
<#-- @formatter:off -->
{
    if (${input$ship} instanceof LoadedServerShip) {
        GravityInducedShips.getOrCreate((LoadedServerShip) ${input$ship}).setGravity(${input$val});
    }
}
<#-- @formatter:on -->