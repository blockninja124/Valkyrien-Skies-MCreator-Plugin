package ${package}.mixins;

/**@deprecated this is sus we should change it*/
@Deprecated
@Mixin(ShipObjectServerWorld.class)
public interface ServerShipObjectWorldAccessor {
    @Accessor(value = "shipIdToConstraints", remap = false)
    Map<Long, Set<Integer>> getShipIdToConstraints();

    @Accessor(value = "constraints", remap = false)
    Map<Integer, VSConstraint> getConstraints();
}
