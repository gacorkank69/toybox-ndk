# shellcheck disable=SC1091,SC2181
SKIPUNZIP=1

abort_unsupported_arch() {
	ui_print "*********************************************************"
	ui_print "! Unsupported Architecture: $ARCH."
	ui_print "! Currently, toybox-ndk only supports arm64 architecture."
	ui_print "! If you believe this is a mistake, please report to the maintainer."
	abort "*********************************************************"
}

# extract <zip> <file> <target dir>
extract() {
	zip=$1
	file=$2
	dir=$3

	file_path="$dir/$file"

	unzip -o "$zip" "$file" -d "$dir" >&2
	[ -f "$file_path" ] || abort "$file does not exists"
}

deploy() {
ui_print "- Installing ToyBox-NDK..."
[ "$ARCH" == "arm64" ] || abort_unsupported_arch
mkdir -p $MODPATH/system/bin
extract "$ZIPFILE" "libs/arm64-v8a/toybox" "$TMPDIR"
cp "$TMPDIR"/libs/arm64-v8a/* "$MODPATH/system/bin/toybox-ndk"
rm -rf "$TMPDIR/libs"
}

INSTALLED_FLAG="/data/adb/modules/toybox-ndk/.installed"
OLD_TOYBOX_DIR="$(dirname $INSTALLED_FLAG)"

cleanup_old_toybox() {
    ui_print "- Removing previous installation..."
    rm -rf $OLD_TOYBOX_DIR/system
    rm -f $INSTALLED_FLAG
}

# Extract module files
ui_print "- Extracting module files"
extract "$ZIPFILE" 'module.prop' "$MODPATH"
extract "$ZIPFILE" 'post-fs-data.sh' "$MODPATH"

if [ -e "$INSTALLED_FLAG" ]; then
    cleanup_old_toybox
    deploy
else
    deploy
fi

# remove conflicting module
if [ -d "/data/adb/modules/toybox-ext" ]; then
    ui_print "- Removing conflicting module.."
	touch /data/adb/modules/toybox-ext/remove
fi

# Permission settings
ui_print "- Permission setup"
set_perm_recursive "$MODPATH" 0 0 0755 0755

ui_print "- ToyBox-NDK has been installed successfully."
sleep 0.5
ui_print "- Please reboot right now."
