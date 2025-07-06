<#include "macros.ftl">

<@withSupplier "Vec3" '
    Ship ship = ${input$ship};
    if (ship instanceof ServerShip) {
        return VectorConversionsMCKt.toMinecraft(((ServerShip) ship).getInertiaData().getCenterOfMassInShip());
    }
    return new Vec3(0, 0, 0);
'/>
