if ((${input$jointid} != null) && (world instanceof Level)) {
    JointUtil.removeJointById((Level) world, ${input$jointid});
}