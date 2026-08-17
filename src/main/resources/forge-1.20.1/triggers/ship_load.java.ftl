<#include "procedures.java.ftl">
@Mod.EventBusSubscriber(bus = Mod.EventBusSubscriber.Bus.MOD, modid = "${modid}") 
public class ${name}Procedure {
	@SubscribeEvent public static void onCommonSetup(FMLCommonSetupEvent event) {
        VSEvents.ShipLoadEvent.Companion.on((shipLoadEvent) -> {
            <#assign dependenciesCode><#compress>
                <@procedureDependenciesCode dependencies, {
                    "loadedShip": "shipLoadEvent.getShip()",
                    "world": "VSGameUtilsKt.getLevelFromDimensionId(ValkyrienSkiesMod.getCurrentServer(), shipLoadEvent.getShip().getChunkClaimDimension())"
                }/>
            </#compress></#assign>
            execute(<#if dependenciesCode?has_content>${dependenciesCode}</#if>);
        });
	}