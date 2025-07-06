<#include "macros.ftl">

<@withSupplier "Vec3" '
    Ship ship = ${input$var};
    if (ship != null) {
        return VectorConversionsMCKt.toMinecraft(ship.getVelocity());
    }
    return new Vec3(0, 0, 0);
'/>
