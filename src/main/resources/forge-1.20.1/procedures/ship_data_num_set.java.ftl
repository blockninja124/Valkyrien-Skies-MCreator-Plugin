{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) tempShip).addNumData(${input$dataName}, ${input$dataValue});
    }
}

