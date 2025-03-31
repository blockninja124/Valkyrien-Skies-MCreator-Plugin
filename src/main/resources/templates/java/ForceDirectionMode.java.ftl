package ${package}.ships;

public enum ForceDirectionMode implements StringRepresentable {
    SHIP("ship"),
    WORLD("world");

    private final String name;

    ForceDirectionMode(String name) {
        this.name = name;
    }

    @Override
    public @NotNull String getSerializedName() {
        return this.name;
    }
}