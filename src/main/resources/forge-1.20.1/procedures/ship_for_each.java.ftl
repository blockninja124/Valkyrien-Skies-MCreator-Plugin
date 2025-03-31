{
    if (world instanceof ServerLevel) {
        for (Ship shipiterator : VSGameUtilsKt.getAllShips((ServerLevel) world)) {
            ${statement$foreach}
        }
    }
}
