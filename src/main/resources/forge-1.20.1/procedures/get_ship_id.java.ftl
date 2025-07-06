<#include "macros.ftl">

<@withSupplier "Number" '
    Ship ship = ${input$var};
    if (ship != null) {
        return ship.getId();
    }
    return -1;
'/>
