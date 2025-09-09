{
    if (${input$ship} instanceof LoadedServerShip) {
        ((LoadedServerShip) ${input$ship}).setStatic(${input$bool});
    }
}