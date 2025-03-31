package ${package}.ships;

public class RotData {

    public final Vector3d rot;
    public volatile ForceMode mode;

    public RotData(Vector3d rot, ForceMode mode) {
        this.rot = rot;
        this.mode = mode;
    }

    public String toString() {
        return "Rotation: " + this.rot + " Mode: " + this.mode;
    }
}