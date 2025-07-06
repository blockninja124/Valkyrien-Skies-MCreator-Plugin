{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ForceInducedShips.getOrCreate((ServerShip) tempShip).addBoolData(${input$dataName}, ${input$dataValue});
    }
}

