{
    if (${input$ship} instanceof LoadedServerShip) {
        ((LoadedServerShip) ${input$ship}).setSlug(${input$str});
    }
}