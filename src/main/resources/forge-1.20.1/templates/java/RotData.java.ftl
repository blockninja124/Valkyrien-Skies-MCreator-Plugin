package ${package}.ships;

public class RotData {

    public final Vector3d rot;
    public final double throttle;
    public volatile ForceMode mode;

    public RotData(Vector3d rot, double throttle, ForceMode mode) {
        this.rot = rot;
        this.throttle = throttle;
        this.mode = mode;
    }

    public String toString() {
        return "Rotation: " + this.rot + " Throttle: " + this.throttle + " Mode: " + this.mode;
    }
}