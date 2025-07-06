<#include "macros.ftl">

<@withSupplier "double" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return ForceInducedShips.getOrCreate((ServerShip) ship).getNumData(${input$dataName}).doubleValue();
    }
    return 0.0D;
'/>
