<#include "macros.ftl">

<@withSupplier "Vec3" '
<#-- @formatter:off -->
    Ship ship = ${input$var};
    Vec3 oldVec = ${input$var2};

    // Ship is null, no transforming needed
    if (ship == null) {
        return oldVec;
    }

    Vector3d newVec = VectorConversionsMCKt.toJOML(oldVec);

    // Transform
    newVec = ship.get${field$direction}().transformPosition(newVec);

    // Back to Vec3
    return VectorConversionsMCKt.toMinecraft(newVec);
<#-- @formatter:on -->
'/>
