
<#-- @formatter:off -->
{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship}).autoScale = ${input$val};
    }
}
<#-- @formatter:on -->