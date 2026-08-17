<#-- @formatter:off -->
{
    for (VSJoint jointiterator : JointUtil.getJointsFromShip(world, ${input$ship})) {
        ${statement$foreach}
    }
}
<#-- @formatter:on -->