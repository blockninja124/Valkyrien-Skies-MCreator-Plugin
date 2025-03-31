{
    if (${input$ship} instanceof ServerShip) {
        ((ServerShip) ${input$ship}).setSlug(${input$str});
    }
}