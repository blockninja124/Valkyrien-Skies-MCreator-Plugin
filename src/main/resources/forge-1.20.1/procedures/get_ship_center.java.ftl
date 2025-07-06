<#include "macros.ftl">

<@withSupplier "Vec3" '
    Ship ship = ${input$var};
    if (ship != null) {
        if (ship.get${field$pos}AABB() != null) {
            return VectorConversionsMCKt.toMinecraft(ship.get${field$pos}AABB().center(new Vector3d(0, 0, 0)));
        }
    }
    return new Vec3(0, 0, 0);
'/>
