{
    if (${input$ship} instanceof ServerShip) {
        ((ServerShip) ${input$ship}).setStatic(${input$bool});
    }
}