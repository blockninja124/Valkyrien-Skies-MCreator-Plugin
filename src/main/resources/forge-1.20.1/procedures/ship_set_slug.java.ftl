{
    Ship tempShip = ${input$ship};
    if (tempShip instanceof ServerShip) {
        ((ServerShip) tempShip).setSlug(${input$str});
    }
}