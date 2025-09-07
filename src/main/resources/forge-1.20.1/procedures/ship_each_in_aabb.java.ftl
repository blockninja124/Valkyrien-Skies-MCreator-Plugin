{
    <#-- @formatter:off -->
    if (world instanceof ServerLevel) {
        if ((${input$from} != null) && (${input$to} != null)) {
            for (Ship shipiterator : VSGameUtilsKt.getShipsIntersecting((ServerLevel) world, new AABB(${input$from}, ${input$to}))) {
                ${statement$foreach}
            }
        }
    }
    <#-- @formatter:on -->
}
