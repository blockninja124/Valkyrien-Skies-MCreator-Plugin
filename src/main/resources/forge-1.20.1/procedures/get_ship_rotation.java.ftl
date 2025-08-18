<#-- @formatter:off -->
(
        (${input$var} != null) ?
            VectorConversionsMCKt.toMinecraft(
                    TeleportHandler.toDegrees(
                            ${input$var}.getTransform()
                                        .getShipToWorldRotation()
                                        .getEulerAnglesXYZ(new Vector3d())
                    )
            ) : new Vec3(0, 0, 0)
)
<#-- @formatter:on -->
