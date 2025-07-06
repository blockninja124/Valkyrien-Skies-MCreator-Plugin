<#include "macros.ftl">

<@withSupplier "String" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return ForceInducedShips.getOrCreate((ServerShip) ship).getStrData(${input$dataName});
    }
    return "";
'/>
