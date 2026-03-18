<#-- @formatter:off -->
{
    if (world instanceof ServerLevel && ${input$ship} instanceof Ship) {
        DimensionTravelTeleporter.teleportShip(
        	    ${input$ship},
        	    TravelDirection.${field$mode},
        	    (ServerLevel) world,
        	    DimensionTravelTeleporter.dimToLevel(${input$str}),
        	    VectorConversionsMCKt.toJOML(${input$vec}),
        	    ${input$ship}.getTransform().getShipToWorldRotation(),
        	    ${input$entity_range},
        	    ${input$ship_range}
        );
    }
}
<#-- @formatter:on -->