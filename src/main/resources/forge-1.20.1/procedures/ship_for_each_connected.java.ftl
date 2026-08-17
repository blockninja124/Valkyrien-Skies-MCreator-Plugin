<#-- @formatter:off -->
{
    for (
    Ship shipiterator : ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId((Level) world))
        .getAllConnectedShips(${input$root}.getId())
        .stream().map(
            (id) -> VSGameUtilsKt.getAllShips((Level) world).getById(id)
        ).toList()
    ) {
        ${statement$foreach}
    }
}
<#-- @formatter:on -->