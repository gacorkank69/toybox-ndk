abort() {
    echo "error: $*" >&2
    exit 1
}

send_file() {
    local file="$1"
    local capt="$2"
    local args

    [ -z "$TG_BOT_TOKEN" ] && abort "TG_BOT_TOKEN is not set"
    [ -z "$TG_CHAT_ID" ] && abort "TG_CHAT_ID is not set"

    if [ ! -f "$file" ]; then
        abort "File not found: $file"
    fi

    args=(
        -F document=@"$file"
        -F chat_id="$TG_CHAT_ID"
        -F disable_web_page_preview=true
    )

    if [ -n "$capt" ]; then
        args+=(-F parse_mode=MarkdownV2 -F caption="$capt")
    fi

    if ! curl -s -f "https://api.telegram.org/bot$TG_BOT_TOKEN/sendDocument" \
         "${args[@]}"; then
        abort "Failed to send file to Telegram"
    fi
}

