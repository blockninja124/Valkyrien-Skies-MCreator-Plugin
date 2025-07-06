{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) tempShip).addStrData(${input$dataName}, ${input$dataValue});
    }
}

