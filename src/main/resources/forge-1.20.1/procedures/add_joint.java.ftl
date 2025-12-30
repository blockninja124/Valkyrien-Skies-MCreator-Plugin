if ((${input$joint} != null) && (world instanceof Level)) {
    JointUtil.addJoint((Level) world, ${input$joint}, (jointid) -> {${statement$callback}});
}