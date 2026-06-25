# KTW Fork 說明（ktw-documenso）

本 repo 是 [documenso/documenso](https://github.com/documenso/documenso)（AGPL-3.0）的 fork，
供 KTW SaaS 平台自架電子簽章服務使用。依 AGPL，本 fork 的修改一併公開於此 repo。

## 與上游的差異（KTW 修改）
1. **新增繁體中文（台灣）`zh-TW`**：
   - `packages/lib/translations/zh-TW/web.po`：由上游 `zh`（簡體）以 OpenCC `s2twp`（含台灣慣用詞）轉換而來。
   - `packages/lib/constants/locales.ts`：`SUPPORTED_LANGUAGE_CODES` 加入 `'zh-TW'`（型別/schema/lingui locales 自動繼承）。
   - `packages/lib/constants/i18n.ts`：`SUPPORTED_LANGUAGES` 加入 `zh-TW`（顯示名 Chinese (Traditional)）。
   - `scripts/apply-zh-tw.sh`：可重跑的簡轉繁腳本（上游更新翻譯時重套）。

## 維護（跟上游版本）
1. 合併/rebase 上游新版本。
2. 跑 `bash scripts/apply-zh-tw.sh` 重新產生 `zh-TW/web.po`。
3. 確認 `locales.ts` / `i18n.ts` 仍含 `zh-TW`（如上游改了結構需手動對齊）。

## 部署
- 本 fork 部署於 KTW Zeabur `ktw-smart` 專案，**僅內網/Tailscale，不對公網開放**。
- 整合規格見平台 repo：`docs/PLATFORM-DOCUMENSO-INTEGRATION-SPEC.md`。
