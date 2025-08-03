{
    if (${input$ship} instanceof LoadedServerShip) {
        ForceInducedShips.getOrCreate((LoadedServerShip) ${input$ship}).addNumData(${input$dataName}, ${input$dataValue});
    }
}