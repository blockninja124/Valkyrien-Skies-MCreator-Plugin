<#-- @formatter:off -->
{
    if (world instanceof ServerLevel && ${input$ship} instanceof ServerShip) {
        DimensionTravelTeleporter.teleportShip(
    	    (ServerShip) ${input$ship},
    	    TravelDirection.PLANET_TO_SPACE,
    	    (ServerLevel) world,
    	    (ServerLevel) world,
    	    VectorConversionsMCKt.toJOML(${input$vec}),
    	    ${input$ship}.getTransform().getShipToWorldRotation(),
    	    ${input$entity_range},
    	    ${input$ship_range}
    	);
    }
}
<#-- @formatter:on -->