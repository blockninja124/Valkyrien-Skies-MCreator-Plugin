package ${package}.ships;

public class JointUtil {

    public static VSJoint makeFixedJoint(@Nullable Long bodyId1, @Nullable Long bodyId2, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB) {
        Quaterniondc rotationAQuat = eulerXYZToQuaternion(rotationA.x(), rotationA.y(), rotationA.z());
        Quaterniondc rotationBQuat = eulerXYZToQuaternion(rotationB.x(), rotationB.y(), rotationB.z());

        VSJointPose poseA = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionA),
                rotationAQuat
        );

        VSJointPose poseB = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionB),
                rotationBQuat
        );

        return new VSFixedJoint(bodyId1, poseA, bodyId2, poseB, null, 1.0E-10);
    }

    public static VSJoint makeFixedJoint(@Nullable Ship shipA, @Nullable Ship shipB, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB) {
        Long bodyId1 = shipA != null ? shipA.getId() : null;
        Long bodyId2 = shipB != null ? shipB.getId() : null;

        return makeFixedJoint(bodyId1, bodyId2, rotationA, rotationB, positionA, positionB);
    }

    public static VSJoint makeDistanceJoint(@Nullable Ship shipA, @Nullable Ship shipB, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB, @Nullable Number minDistance, @Nullable Number maxDistance) {
        Long bodyId1 = shipA != null ? shipA.getId() : null;
        Long bodyId2 = shipB != null ? shipB.getId() : null;

        return makeDistanceJoint(bodyId1, bodyId2, rotationA, rotationB, positionA, positionB, minDistance, maxDistance);

    }

    public static VSJoint makeDistanceJoint(@Nullable Long bodyId1, @Nullable Long bodyId2, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB, @Nullable Number minDistance, @Nullable Number maxDistance) {
        Quaterniondc rotationAQuat = eulerXYZToQuaternion(rotationA.x(), rotationA.y(), rotationA.z());
        Quaterniondc rotationBQuat = eulerXYZToQuaternion(rotationB.x(), rotationB.y(), rotationB.z());

        VSJointPose poseA = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionA),
                rotationAQuat
        );

        VSJointPose poseB = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionB),
                rotationBQuat
        );

        Float minDist = minDistance != null ? minDistance.floatValue() : null;
        Float maxDist = maxDistance != null ? maxDistance.floatValue() : null;

        return new VSDistanceJoint(bodyId1, poseA, bodyId2, poseB, null, VSJoint.DEFAULT_COMPLIANCE, minDist, maxDist, null, null, null);
    }

    public static VSJoint makeRevoluteJoint(@Nullable Ship shipA, @Nullable Ship shipB, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB, @Nullable Number lowerLimit, @Nullable Number upperLimit) {
        Long bodyId1 = shipA != null ? shipA.getId() : null;
        Long bodyId2 = shipB != null ? shipB.getId() : null;
        return makeRevoluteJoint(bodyId1, bodyId2, rotationA, rotationB, positionA, positionB, lowerLimit, upperLimit);
    }

    public static VSJoint makeRevoluteJoint(@Nullable Long bodyId1, @Nullable Long bodyId2, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB, @Nullable Number lowerLimit, @Nullable Number upperLimit) {
        Quaterniondc rotationAQuat = eulerXYZToQuaternion(rotationA.x(), rotationA.y(), rotationA.z());
        Quaterniondc rotationBQuat = eulerXYZToQuaternion(rotationB.x(), rotationB.y(), rotationB.z());

        VSJointPose poseA = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionA),
                rotationAQuat
        );

        VSJointPose poseB = new VSJointPose(
                VectorConversionsMCKt.toJOML(positionB),
                rotationBQuat
        );

        VSD6Joint.AngularLimitPair limits = new VSD6Joint.AngularLimitPair(
                lowerLimit != null ? lowerLimit.floatValue() : Float.NEGATIVE_INFINITY,
                upperLimit != null ? upperLimit.floatValue() : Float.POSITIVE_INFINITY,
                null,
                null,
                null,
                null
        );

        VSRevoluteJoint.VSRevoluteDriveVelocity driveVelocity = new VSRevoluteJoint.VSRevoluteDriveVelocity(0.0F, false);

        return new VSRevoluteJoint(bodyId1, poseA, bodyId2, poseB, null, VSJoint.DEFAULT_COMPLIANCE, limits, driveVelocity, null, null, true);
    }

    public static void addJoint(Level level, VSJoint joint, Consumer<Integer> idCallback) {

        //VSGameUtilsKt.getShipObjectWorld((ServerLevel) level).getAerodynamicUtils().updateGravityForDimension();
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        gtpa.addJoint(joint, 0, idCallback);

        /*if(!level.isClientSide()) {
            BlockPos _bp = BlockPos.ZERO;
            BlockEntity _blockEntity = level.getBlockEntity(_bp);
            BlockState _bs = level.getBlockState(_bp);
            if(_blockEntity != null)
                _blockEntity.getPersistentData().put.putString(${input$tagName}, ${input$tagValue});

            if(world instanceof Level _level)
                _level.sendBlockUpdated(_bp, _bs, _bs, 3);
        }*/
    }

    public static CompoundTag jointToTag(VSJoint joint) {
        CompoundTag tag = new CompoundTag();
        tag.putString("type", joint.getJointType().name());
        if (joint.getShipId0() != null) {
            tag.putLong("shipId0", joint.getShipId0());
        }
        if (joint.getShipId1() != null) {
            tag.putLong("shipId1", joint.getShipId1());
        }

        tag.put("rot0", quatToTag(joint.getPose0().getRot()));
        tag.put("rot1", quatToTag(joint.getPose1().getRot()));
        tag.put("pos0", vecToTag(joint.getPose0().getPos()));
        tag.put("pos1", vecToTag(joint.getPose1().getPos()));

        if (joint instanceof VSDistanceJoint dJ) {
            if (dJ.getMinDistance() != null) {
                tag.putFloat("lowerLimit", dJ.getMinDistance());
            }
            if (dJ.getMaxDistance() != null) {
                tag.putFloat("upperLimit", dJ.getMaxDistance());
            }
        }

        if (joint instanceof VSRevoluteJoint rJ) {
            if (rJ.getAngularLimitPair() != null) {
                if (Float.isFinite(rJ.getAngularLimitPair().getLowerLimit())) {
                    tag.putFloat("lowerLimit", rJ.getAngularLimitPair().getLowerLimit());
                }
                if (Float.isFinite(rJ.getAngularLimitPair().getUpperLimit())) {
                    tag.putFloat("upperLimit", rJ.getAngularLimitPair().getUpperLimit());
                }
            }
        }

        return tag;
    }

    public static @Nullable VSJoint jointFromTag(CompoundTag tag) {
        Long shipId0 = tag.contains("shipId0", 99) ? tag.getLong("shipId0") : null;
        Long shipId1 = tag.contains("shipId1", 99) ? tag.getLong("shipId1") : null;

        Quaterniondc rot0 = quatFromTag(tag.getCompound("rot0"));
        Quaterniondc rot1 = quatFromTag(tag.getCompound("rot1"));

        Vector3dc pos0 = vecFromTag(tag.getCompound("pos0"));
        Vector3dc pos1 = vecFromTag(tag.getCompound("pos1"));

        if (rot0 == null || rot1 == null || pos0 == null || pos1 == null) {
            // Oh dear (we got passed a non-joint compound tag)
            return null;
        }

        boolean isDistance = tag.getString("type").equals("DISTANCE");
        boolean isRevolute = tag.getString("type").equals("REVOLUTE");
        boolean isFixed = tag.getString("type").equals("FIXED");

        if (isDistance || isRevolute) {
            Float minDistance = tag.contains("lowerLimit", 99) ? tag.getFloat("lowerLimit") : null;
            Float maxDistance = tag.contains("upperLimit", 99) ? tag.getFloat("upperLimit") : null;

            if (isDistance) {
                return makeDistanceJoint(
                        shipId0,
                        shipId1,
                        VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot0)),
                        VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot1)),
                        VectorConversionsMCKt.toMinecraft(pos0),
                        VectorConversionsMCKt.toMinecraft(pos1),
                        minDistance,
                        maxDistance
                );
            } else {
                // isRevolute
                return makeRevoluteJoint(
                        shipId0,
                        shipId1,
                        VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot0)),
                        VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot1)),
                        VectorConversionsMCKt.toMinecraft(pos0),
                        VectorConversionsMCKt.toMinecraft(pos1),
                        minDistance,
                        maxDistance
                );
            }
        }

        if (isFixed) {
            return makeFixedJoint(
                    shipId0,
                    shipId1,
                    VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot0)),
                    VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot1)),
                    VectorConversionsMCKt.toMinecraft(pos0),
                    VectorConversionsMCKt.toMinecraft(pos1)
            );
        }

        // Our joint type was invalid
        return null;
    }

    public static CompoundTag vecToTag(Vector3dc vec) {
        CompoundTag tag = new CompoundTag();
        tag.putDouble("x", vec.x());
        tag.putDouble("y", vec.y());
        tag.putDouble("z", vec.z());
        return tag;
    }

    public static @Nullable Vector3dc vecFromTag(CompoundTag tag) {
        if (!tag.contains("x", 99) || !tag.contains("y", 99) || !tag.contains("z", 99)) {
            return null;
            //throw new IllegalArgumentException("Missing x,y,z or w double item in compound tag!");
        }
        return new Vector3d(tag.getDouble("x"), tag.getDouble("y"), tag.getDouble("z"));
    }

    public static CompoundTag quatToTag(Quaterniondc quat) {
        CompoundTag tag = new CompoundTag();
        tag.putDouble("x", quat.x());
        tag.putDouble("y", quat.y());
        tag.putDouble("z", quat.z());
        tag.putDouble("w", quat.w());
        return tag;
    }

    public static @Nullable Quaterniondc quatFromTag(CompoundTag tag) {
        if (!tag.contains("x", 99) || !tag.contains("y", 99) || !tag.contains("z", 99) || !tag.contains("w", 99)) {
            return null;
            //throw new IllegalArgumentException("Missing x,y,z or w double item in compound tag!");
        }
        return new Quaterniond(tag.getDouble("x"), tag.getDouble("y"), tag.getDouble("z"), tag.getDouble("w"));
    }

    public static void removeJointById(Level level, Number id) {
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        gtpa.removeJoint(id.intValue());
    }

    public static @Nullable VSJoint getJointById(Level level, Number id) {
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        return gtpa.getJointById(id.intValue());
    }

    public static void updateJoint(Level level, Number id, VSJoint joint) {
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        gtpa.updateJoint(new VSJointAndId(id.intValue(), joint));
    }

    public static @Nullable LoadedServerShip getShipFromJoint(Level level, VSJoint joint, boolean firstShip) {
        if (joint == null) return null;
        Long id = firstShip ? joint.getShipId0() : joint.getShipId1();
        if (id == null) return null;
        if (level instanceof ServerLevel) {
            return VSGameUtilsKt.getShipObjectWorld((ServerLevel) level).getLoadedShips().getById(id);
        }
        return null;
    }

    public static Vec3 getPosFromJoint(VSJoint joint, boolean firstPos) {
        if (joint == null) return new Vec3(0, 0, 0);

        Vector3dc pos = firstPos ? joint.getPose0().getPos() : joint.getPose1().getPos();

        return VectorConversionsMCKt.toMinecraft(pos);
    }

    public static Vec3 getRotFromJoint(VSJoint joint, boolean firstRot) {
        if (joint == null) return new Vec3(0, 0, 0);

        Quaterniondc rot = firstRot ? joint.getPose0().getRot() : joint.getPose1().getRot();

        return VectorConversionsMCKt.toMinecraft(quaternionToEulerXYZ(rot));
    }

    // ChatGPT slop, seems to work
    private static Quaterniondc eulerXYZToQuaternion(double x, double y, double z) {
        var cx = Math.cos(x * 0.5);
        var sx = Math.sin(x * 0.5);
        var cy = Math.cos(y * 0.5);
        var sy = Math.sin(y * 0.5);
        var cz = Math.cos(z * 0.5);
        var sz = Math.sin(z * 0.5);

        var qw = cx * cy * cz - sx * sy * sz;
        var qx = sx * cy * cz + cx * sy * sz;
        var qy = cx * sy * cz - sx * cy * sz;
        var qz = cx * cy * sz + sx * sy * cz;

        return new Quaterniond(qx, qy, qz, qw);
    }

    private static Vector3d quaternionToEulerXYZ(Quaterniondc quat) {

        // Normalize defensively
        var len = Math.sqrt(quat.x()*quat.x() + quat.y()*quat.y() + quat.z()*quat.z() + quat.w()*quat.w());
        var xq = quat.x() / len;
        var yq = quat.y() / len;
        var zq = quat.z() / len;
        var wq = quat.w() / len;

        var x = Math.atan2(
                2.0 * (wq * xq - yq * zq),
                1.0 - 2.0 * (xq * xq + yq * yq)
        );

        var y = Math.asin(
                Math.max(-1.0, Math.min((2.0 * (wq * yq + xq * zq)), 1.0))
        );

        var z = Math.atan2(
                2.0 * (wq * zq - xq * yq),
                1.0 - 2.0 * (yq * yq + zq * zq)
        );

        return new Vector3d(x, y, z);
    }
}