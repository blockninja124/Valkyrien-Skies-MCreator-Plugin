(
    (${input$var} != null) ? 
    // Ship isn't null, transform rotation
    // Vector3d to Vec3
    VectorConversionsMCKt.toMinecraft(
        ${input$var}.get${field$direction}().transformDirection(
            // Vec3 to Vector3d
            VectorConversionsMCKt.toJOML(${input$var2})
        )
    )
    // Ship is null, no transforming needed
    : ${input$var2}
)