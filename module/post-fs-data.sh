#!/system/bin/sh

MODDIR="$(dirname "$0")"
INSTALLED_FLAG="$MODDIR/.installed"
TOYBOX_BIN="$MODDIR/system/bin/toybox-ndk"
SYS_DIR="$(dirname "$TOYBOX_BIN")"

if [ ! -f "$INSTALLED_FLAG" ]; then
    APPLETS="$("$TOYBOX_BIN")"
    mv -f "$TOYBOX_BIN" "$SYS_DIR/toybox"

    for APPLET in $APPLETS; do
        TARGET="$SYS_DIR/$APPLET"
        ln -s "$SYS_DIR/toybox" "$TARGET"
    done

    touch "$INSTALLED_FLAG"
fi
