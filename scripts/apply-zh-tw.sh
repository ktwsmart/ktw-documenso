#!/bin/bash
# KTW fork：把上游簡體翻譯 zh 轉成台灣繁體 zh-TW（OpenCC s2twp，含台灣慣用詞）。
# 上游更新翻譯後重跑本腳本即可同步 zh-TW。需先安裝 opencc（brew install opencc / apt install opencc）。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
T="$ROOT/packages/lib/translations"

command -v opencc >/dev/null 2>&1 || { echo "需要 opencc，請先安裝（brew install opencc）"; exit 1; }
CFG=$(ls /opt/homebrew/share/opencc/s2twp.json /usr/share/opencc/s2twp.json /usr/local/share/opencc/s2twp.json 2>/dev/null | head -1)
CFG=${CFG:-s2twp.json}

mkdir -p "$T/zh-TW"
opencc -c "$CFG" -i "$T/zh/web.po" -o "$T/zh-TW/web.po"
# 修 .po 標頭：標成 zh-TW
perl -i -pe 's/^"Language: zh\\n"/"Language: zh-TW\\n"/; s/^"Language-Team: Chinese Simplified\\n"/"Language-Team: Chinese (Traditional)\\n"/; s/^"X-Crowdin-Language: zh-CN\\n"/"X-Crowdin-Language: zh-TW\\n"/' "$T/zh-TW/web.po"
echo "zh-TW 轉換完成：$(grep -c '^msgid' "$T/zh-TW/web.po") 條 → $T/zh-TW/web.po"
echo "提醒：別忘了 packages/lib/constants/locales.ts 的 SUPPORTED_LANGUAGE_CODES 與 i18n.ts 的 SUPPORTED_LANGUAGES 要含 'zh-TW'。"
