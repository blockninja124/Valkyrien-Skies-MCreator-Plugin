<#include "macros.ftl">

<@withSupplier "Boolean" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return ForceInducedShips.getOrCreate((ServerShip) ship).getBoolData(${input$dataName});
    }
    return false;
'/>
