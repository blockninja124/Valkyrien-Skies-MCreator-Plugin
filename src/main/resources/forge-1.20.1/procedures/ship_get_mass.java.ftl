<#include "macros.ftl">

<@withSupplier "double" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return ((ServerShip) ship).getInertiaData().getMass();
    }
    return 0;
'/>
