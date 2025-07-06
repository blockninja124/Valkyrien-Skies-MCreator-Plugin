<#-- @formatter:off -->

<#include "macros.ftl">

<@withSupplier "Boolean" '
    Ship ship1 = ${input$var};
    Ship ship2 = ${input$var2};
    if (ship1 != null && ship2 != null) {
        return (ship1.getId() == ship2.getId());
    }
    return false;
'/>

<#-- @formatter:on -->