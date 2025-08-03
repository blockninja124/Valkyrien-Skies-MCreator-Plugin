{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship}).addStrData(${input$dataName}, ${input$dataValue});
    }
}