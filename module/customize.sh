# shellcheck disable=SC1091,SC2181
SKIPUNZIP=1

make_dir() {
	[ ! -d "$1" ] && mkdir -p "$1"
}

abort_unsupported_arch() {
	ui_print "*********************************************************"
	ui_print "! Unsupported Architecture: $ARCH."
	ui_print "! Currently, toybox-ext only supports arm64 architecture."
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
[ "$ARCH" == "arm64" ] && ARCH_TMP="arm64-v8a" || abort_unsupported_arch
make_dir "$MODPATH/system/bin"
extract "$ZIPFILE" "libs/$ARCH_TMP/toybox" "$TMPDIR"
cp "$TMPDIR"/libs/"$ARCH_TMP"/* "$MODPATH/system/bin/toybox-ext"
rm -rf "$TMPDIR/libs"
}

INSTALLED_FLAG="/data/adb/modules/toybox-ext/.installed"
OLD_TOYBOX_DIR="$(dirname $INSTALLED_FLAG)"

cleanup_old_toybox() {
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

# Permission settings
ui_print "- Permission setup"
set_perm_recursive "$MODPATH" 0 0 0755 0755
