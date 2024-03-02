yt-transcript() {
  # yt-dlp has a native way to download subtitle files
  # yt-dlp --write-auto-sub --write-sub --sub-lang "en,en-us,en-GB,automatic-caption-en" --skip-download $@
  # Available formats
  # vtt, ttml, srv3, srv2, srv1, json3

  # I opted to use JSON + curl to avoid writing any files
  local JSON=$(yt-dlp -j --quiet $@)
  local TITLE=$(jq -r '.title' <<< $JSON)
  echo $TITLE
  local TRANSCRIPT_URL=$(jq -r '.automatic_captions.en[] | select(.ext=="json3") | .url' <<< $JSON)
  curl $TRANSCRIPT_URL | jq -r '.events | map(if (.segs) then .segs[].utf8 else ("") end) | join("")'
}
