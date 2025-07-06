package ${package}.ships;

public class ShipTickEvent extends Event {
    public final ServerShip ship;
    public final LevelAccessor world;

    public ShipTickEvent(ServerShip ship, LevelAccessor world) {
        this.ship = ship;
        this.world = world;
    }
}
