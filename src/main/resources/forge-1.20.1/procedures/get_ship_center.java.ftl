((${input$var} != null) ? 
// Crimes against Java...
VectorConversionsMCKt.toMinecraft(
    // Yes a ternary operator in a ternary operator
    (${input$var}.get${field$pos}AABB() != null) ? 
    // AABB can sometimes be null when not loaded yet
    ${input$var}.get${field$pos}AABB().center(new Vector3d(0, 0, 0)) : 
    // Default values to fall back on
    new Vector3d(0, 0, 0)) : new Vec3(0, 0, 0)
)