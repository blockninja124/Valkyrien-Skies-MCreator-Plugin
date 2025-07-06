{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ((ServerShip) tempShip).setStatic(${input$bool});
    }
}