<!-- ai-source: claude -->
# Documenso 簽署服務迭代版本說明表

> 元件角色：平台文件簽署服務（`ktw-documenso` repo，自 documenso 官方 fork 並自建映像；對外經簽署代理 `ktw-sign-proxy`（Caddy）以 `sign.ktwsmart.com` 提供，平台以 `/api/documenso/*` 介接）
>
> 建立日期：2026-10-25　維護者：Claude（遷移線）／Codex
>
> 中央索引：[KTW-SaaS版本權威索引](../../docs/KTW-SaaS版本權威索引.md)　撤離映像清單：[新叢集現役映像清單-20261025](../../docs/撤離/新叢集現役映像清單-20261025.md)

## 元件邊界

本元件只負責電子簽署（文件上傳、簽署流程、簽章 PDF、Webhook 回呼平台）；租戶與權限由平台控制，Documenso 不直接對租戶開放管理介面。產品版號沿用上游 `package.json` 的 `version`（fork 不另編號），KTW 自有變更以「來源 commit＋映像 digest」追溯。

## 迭代版本表

| 元件版本 | 日期 | Source | 狀態 | 主要內容 | 驗證與證據 | 未完成 Gate |
|---|---|---|---|---|---|---|
| 2.13.0（基底 Node 22.23.4） | 2026-10-25 | 分支 `claude/基底鏡像安全修補Node22.23.4-20261025`（基底 main `ae8291ad`）；PR [#2](https://github.com/ktwsmart/ktw-documenso/pull/2)；改 `docker/Dockerfile` 基底 `node:22-alpine3.22`→`node:22.23.4-alpine3.23@sha256:6abbcf5d…`、新增 PR 建置檢查工作流、建立本子表 | 候選（審查中） | HTTP2Shell（CVE-2026-111497）Brotli 解壓缺陷回補：原標籤 alpine3.22 停更致現役 Node 22.22.3；釘精確版本＋digest | PR 建置檢查工作流回讀映像內 `node -v`；合併後 Pod 內 `node -v`＝v22.23.4、sign 登入與文件開啟、Sentry 15 分鐘 | 審查收口；合併時序由遷移會議總調度 |
| 2.13.0 | 2026-10-25 | main `ae8291ad94733c37132d42e047b3b8b56db8e945`（PR #1 撤離部署管線改接新主機，純 workflow 變更）；映像 `ghcr.io/ktwsmart/ktw-documenso@sha256:ce41654866cb6d6386af506964baa9d79d8cc3831db429ce21947d2f695aaa71`（deploy.yml run 40169407317 同源重建） | **已部署**（GCP 新叢集 `ktw-prod`／Deployment `ghcrioktwsmartktw-documensolatest`，2026-10-25 14:41 起） | Zeabur 撤離：切換後第一次以新管線（k3s 路徑）重建部署；程式與 Zeabur 時期 1e37a3c6 同源（i18n locale 修正為最後一次程式變更） | 工作流 digest 綁定與 app 容器斷言通過；sign 登入頁 200；Sentry 無新事件（切換日 runbook 14:41 列） | 中央索引登錄（本表建立即補登）；Node 基底修補（上列候選） |
| 2.13.0 | 2026-06-25 | main `1e37a3c6`（fix(i18n) 語言判定）；Zeabur PREBUILT 服務 6a3ccbc5 | 已退役（Zeabur 2026-10-25 22:00 suspend 前現役） | 2026-06-25 起以 CI→GHCR→Zeabur PREBUILT 部署；KTW 自有修正：i18n locale 判定 | Zeabur 運行紀錄 | — |

## 變更記錄

| 日期時間 | AI／人員 | 變更摘要 |
|---|---|---|
| 2026-10-25 16:05 +0800 | Claude | 建表並補登中央索引（業主 2026-10-24 23:23 裁定「Documenso 補登錄切換後另排」evt-1f375eba；Codex 2026-10-25 HTTP2Shell 修補 PR #2 第二輪審查必修指出未登錄即部署違反 P-0 第 6 條，故於切換後第一個工作日補登）。登錄現役 2.13.0（ae8291ad／ce416548…）與候選基底修補列。 |
