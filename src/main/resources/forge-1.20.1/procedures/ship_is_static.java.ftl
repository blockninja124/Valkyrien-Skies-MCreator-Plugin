<#include "macros.ftl">

<@withSupplier "Boolean" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return ((ServerShip) ship).isStatic();
    }
    return false;
'/>

