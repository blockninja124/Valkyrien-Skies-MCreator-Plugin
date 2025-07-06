<#include "macros.ftl">

<@withSupplier "String" '
    Ship ship = ${input$var};
    if (ship != null) {
        return ship.getChunkClaimDimension();
    }
    return "null";
'/>
