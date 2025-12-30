{
    if (world instanceof ServerLevel) {
        for (LoadedServerShip shipiterator : VSGameUtilsKt.getShipObjectWorld((ServerLevel) world).getLoadedShips()) {
            ${statement$foreach}
        }
    }
}
