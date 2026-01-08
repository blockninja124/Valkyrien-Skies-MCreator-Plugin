<#include "mcelements.ftl">
if(!world.isClientSide()) {
	BlockEntity _blockEntity = world.getBlockEntity(${input$pos});
	BlockState _bs = world.getBlockState(${input$pos});
	if(_blockEntity != null && ${input$tagValue} != null)
		_blockEntity.getPersistentData().put(${input$tagName}, JointUtil.jointToTag(${input$tagValue}));

	if(world instanceof Level _level)
		_level.sendBlockUpdated(${input$pos}, _bs, _bs, 3);
}