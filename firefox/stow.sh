#!/bin/bash
set -euo pipefail

DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
FIREFOX="${HOME}/.mozilla/firefox"

PROFILE=$(awk -F= '/^\[Install/{p=1} p&&/^Default=/{print $2; exit}' $FIREFOX/profiles.ini)

if [ -d $FIREFOX/$PROFILE ]; then
    ln -sf "$DIR/user.js" "$FIREFOX/$PROFILE/user.js"
    echo "Linked user.js in $FIREFOX/$PROFILE."
else
    echo "Could not find profile dir." >&2
    exit 1
fi

echo "Extensions:" && cat $DIR/extensions.txt

