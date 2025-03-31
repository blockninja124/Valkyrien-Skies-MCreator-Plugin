{
    if (${input$ship} instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) ${input$ship}).addBoolData(${input$dataName}, ${input$dataValue});
    }
}