(
    (${input$var} != null) ? 
    // Ship isn't null, transform position
    // Vector3d to Vec3
    VectorConversionsMCKt.toMinecraft(
        ${input$var}.get${field$direction}().transformPosition(
            // Vec3 to Vector3d
            VectorConversionsMCKt.toJOML(${input$var2})
        )
    )
    // Ship is null, no transforming needed
    : ${input$var2}
)