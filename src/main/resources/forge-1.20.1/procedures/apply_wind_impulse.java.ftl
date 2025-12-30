<#-- @formatter:off -->
{
    if (${input$ship} instanceof VsiLoadedServerShip vsiShip) {
        vsiShip.getDragController().applyWindImpulse(VectorConversionsMCKt.toJOML(${input$dir}), ((${input$speed} >= 0) ? ${input$speed} : -${input$speed}));
    }
}
<#-- @formatter:on -->
