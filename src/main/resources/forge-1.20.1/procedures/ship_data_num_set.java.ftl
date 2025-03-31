{
    if (${input$ship} instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) ${input$ship}).addNumData(${input$dataName}, ${input$dataValue});
    }
}