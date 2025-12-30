if ((${input$jointid} != null) && (world instanceof Level level)) {
    JointUtil.removeJointById(level, ${input$jointid});
}