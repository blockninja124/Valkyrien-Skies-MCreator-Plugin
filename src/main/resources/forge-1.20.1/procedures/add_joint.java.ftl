if ((${input$joint} != null) && (world instanceof Level level)) {
    JointUtil.addJoint(level, ${input$joint}, (jointid) -> {${statement$callback}});
}