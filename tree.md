# 專案結構

```
echat-history/
├── messaging-schema.md                  # 訊息對話儲存結構設計文件
├── messaging-db-setup.plan.md           # DB 建置實作計畫
├── tree.md                              # 專案資料夾結構
└── sql/
    ├── postgresql/
    │   ├── 001-schema.sql               # PostgreSQL DDL（ENUM、資料表、約束、索引）
    │   └── 002-seed-data.sql            # PostgreSQL 測試資料（100 筆對話）
    └── mssql/
        ├── 001-schema.sql               # MSSQL DDL（CHECK 約束、資料表、索引）
        └── 002-seed-data.sql            # MSSQL 測試資料（100 筆對話）
```
