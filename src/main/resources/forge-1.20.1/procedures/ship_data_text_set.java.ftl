{
    if (${input$ship} instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) ${input$ship}).addStrData(${input$dataName}, ${input$dataValue});
    }
}