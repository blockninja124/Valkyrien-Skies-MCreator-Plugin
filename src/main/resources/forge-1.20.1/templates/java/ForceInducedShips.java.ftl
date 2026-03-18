package ${package}.ships;

public final class ForceInducedShips implements ShipPhysicsListener {
    @JsonIgnore
    public Stack<com.mojang.datafixers.util.Pair<BlockPos, ForceData>> nextTickForces = new Stack<>();
    @JsonIgnore
    public Stack<RotData> nextTickRotations = new Stack<>();

    // DON'T access these in applyForces, thread issues will ensue!!
    public HashMap<String, Number> numData = new HashMap<>();
    public HashMap<String, Boolean> boolData = new HashMap<>();
    public HashMap<String, String> strData = new HashMap<>();

    public boolean autoScale = true;

    public ForceInducedShips() {}

    @Override
    public void physTick(@NotNull PhysShip physicShip, @NotNull PhysLevel physLevel) {
        PhysShipImpl physShip = (PhysShipImpl) physicShip;

        while(!nextTickRotations.isEmpty()) {
            RotData data = nextTickRotations.pop();

            double scale = data.throttle;

            Vector3d rot = data.rot;

            if (data.mode == ForceMode.GLOBAL) {
                if (autoScale) {
                    scale = scale * Math.pow(physShip.getTransform().getShipToWorldScaling().x(), 5);
                }
                rot = rot.mul(scale);
                physShip.applyInvariantTorque(rot);
            } else {
                rot = rot.mul(scale);
                physShip.applyRotDependentTorque(rot);
            }
        }

        // Hmm while loop seems sus
        while(!nextTickForces.isEmpty()) {

            com.mojang.datafixers.util.Pair<BlockPos, ForceData> pair = nextTickForces.pop();

            BlockPos pos = pair.getFirst();
            ForceData data = pair.getSecond();

            double throttle = data.throttle;
            if (throttle == 0.0) {
                continue;
            }


            Vector3d direction;
            if (data.dirMode == ForceDirectionMode.SHIP) {
                // Transform force direction from ship relative to world relative
                direction = physShip.getTransform().getShipToWorld().transformDirection(data.dir, new Vector3d());
            } else {
                direction = data.dir;
            }

            direction.mul(throttle);

            if (data.mode == ForceMode.GLOBAL) {

                if (autoScale) {
                    throttle = throttle * Math.pow(physShip.getTransform().getShipToWorldScaling().x(), 3);
                }

                physShip.applyInvariantForce(direction);
            } else {

                Vector3d tPos = VectorConversionsMCKt.toJOMLD(pos)
                        .add(0.5, 0.5, 0.5, new Vector3d())
                        .sub(physShip.getTransform().getPositionInShip());

                physShip.applyInvariantForceToPos(direction, tPos);
            }
        }
    }

    public void addForce(BlockPos pos, ForceData data) {
        nextTickForces.push(new com.mojang.datafixers.util.Pair<>(pos, data));
    }

    public void addForce(BlockPos pos, Vector3d dir, double throttle, ForceMode mode, ForceDirectionMode dirMode) {
        nextTickForces.push(new com.mojang.datafixers.util.Pair<>(pos, new ForceData(dir, throttle, mode, dirMode)));
    }

    public void addRotation(RotData data) {
        nextTickRotations.push(data);
    }

    public void addRotation(Vector3d rot, double throttle, ForceMode mode) {
        nextTickRotations.push(new RotData(rot, throttle, mode));
    }


    public void addNumData(String key, Number obj) {
        numData.put(key, obj);
    }

    public void addBoolData(String key, Boolean obj) {
        boolData.put(key, obj);
    }

    public void addStrData(String key, String obj) {
        strData.put(key, obj);
    }

    public Number getNumData(String key) {
        if (numData.containsKey(key)) {
            return numData.get(key);
        }
        return 0;
    }

    public Boolean getBoolData(String key) {
        if (boolData.containsKey(key)) {
            return boolData.get(key);
        }
        return false;
    }

    public String getStrData(String key) {
        if (strData.containsKey(key)) {
            return strData.get(key);
        }
        return "";
    }


    // ----- Force induced ships ----- //

    public static ForceInducedShips getOrCreate(LoadedServerShip ship) {
        ForceInducedShips attachment = ship.getAttachment(ForceInducedShips.class);
        if (attachment == null) {
            attachment = new ForceInducedShips();
            ship.setAttachment(ForceInducedShips.class, attachment);
        }
        return attachment;
    }

    public static ForceInducedShips get(Level level, BlockPos pos) {
        if (level instanceof ServerLevel serverLevel) {
            LoadedServerShip ship = VSGameUtilsKt.getLoadedShipManagingPos(serverLevel, pos);
            return ship != null ? getOrCreate(ship) : null;
        }
        return null;
    }
}
