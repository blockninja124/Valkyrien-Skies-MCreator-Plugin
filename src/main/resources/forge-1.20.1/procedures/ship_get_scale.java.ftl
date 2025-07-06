<#-- @formatter:off -->

<#include "macros.ftl">
(
    <@withSupplier "Number" '
        if (tempShip69 instanceof ServerShip) {
            return ((ServerShip) tempShip69).getTransform().getShipToWorldScaling().x();
        }
        return 0.0D;
    ' 'Ship tempShip69 = ${input$ship};'/>.doubleValue()
)
<#-- @formatter:on -->