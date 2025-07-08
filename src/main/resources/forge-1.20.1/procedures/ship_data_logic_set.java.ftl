{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship}).addBoolData(${input$dataName}, ${input$dataValue});
    }
}