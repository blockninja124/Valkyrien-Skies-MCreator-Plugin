<#include "mcelements.ftl">
<#-- @formatter:off -->
(new Object(){
	public VSJoint getValue(LevelAccessor world, BlockPos pos, String tag) {
		BlockEntity blockEntity=world.getBlockEntity(pos);
		if(blockEntity != null) return JointUtil.jointFromTag(blockEntity.getPersistentData().getCompound(tag));
		return null;
	}
}.getValue(world, ${input$pos}, ${input$tagName}))
<#-- @formatter:on -->