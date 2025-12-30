package ${package}.ships;

public class JointUtil {

    public static VSJoint makeFixedJoint(@Nullable ServerShip shipA, @Nullable ServerShip shipB, Vec3 rotationA, Vec3 rotationB, Vec3 positionA, Vec3 positionB) {

        // Sussy
        Long bodyId1 = shipA != null ? shipA.getId() : null;
        Long bodyId2 = shipB != null ? shipB.getId() : null;

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

    public static void addJoint(Level level, VSJoint joint, Consumer<Integer> idCallback) {
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        gtpa.addJoint(joint, 0, idCallback);
    }

    public static void removeJointById(Level level, int id) {
        GameToPhysicsAdapter gtpa = ValkyrienSkiesMod.getOrCreateGTPA(VSGameUtilsKt.getDimensionId(level));
        gtpa.removeJoint(id);
    }


    // ChatGPT slop, no idea if it works
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
}