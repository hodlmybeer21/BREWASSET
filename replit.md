# BrewAsset — POS Room & Warehouse Management System

## Overview

Full-stack POS Room & Warehouse Management System for a beer distribution company. Three authenticated user roles with distinct dashboards, backed by PostgreSQL with real session-based auth.

## Stack

- **Monorepo tool**: pnpm workspaces
- **Node.js version**: 24
- **Package manager**: pnpm
- **TypeScript version**: 5.9
- **API framework**: Express 5 (port 8080)
- **Frontend**: React + Vite + Tailwind CSS v4 (with dark industrial amber theme)
- **Database**: PostgreSQL + Drizzle ORM
- **Auth**: Session-based (`express-session`) with `crypto` SHA-256 password hashing (NOT bcrypt)
- **API codegen**: Orval (from OpenAPI spec) → React Query hooks
- **UI Components**: Custom `core.tsx` — Button, Card, Input, Select, Textarea, Badge, Modal, FadeIn
- **State**: TanStack Query (React Query) with session cookies (`credentials: "include"`)

## User Roles & Credentials

| Role | Username / Selector | Password |
|------|---------------------|----------|
| Warehouse Staff | `warehouse` | `warehouse123` |
| Marketing Manager | `marketing` | `marketing123` |
| Sales Reps (29) | Individual name from dropdown | `FirstName2026` pattern (duplicates have last initial) |
| Promo Staff | Name dropdown (from `promo_staff` table) | `staff2026` (shared) |

## Structure

```text
artifacts-monorepo/
├── artifacts/
│   ├── api-server/           # Express API server (port 8080)
│   │   └── src/routes/       # auth, inventory, requests, events, transfers, staff, catalog, accounts
│   └── brewasset/            # React + Vite frontend (port = $PORT)
│       └── src/
│           ├── pages/auth/Login.tsx
│           ├── pages/rep/RepView.tsx        # 5 tabs: Request Items, My Requests, Accounts, Transfers, Events
│           ├── pages/warehouse/WarehouseView.tsx  # 5 tabs: Inventory, Receive, Requests, History, Catalog
│           ├── pages/marketing/MarketingView.tsx  # 3 tabs: Calendar, All Events, Staff
│           ├── components/layout/AppLayout.tsx
│           ├── components/ui/core.tsx        # All custom UI components
│           └── lib/constants.ts              # Item types, brands, all 46 reps, customer lists
├── lib/
│   ├── api-spec/openapi.yaml   # OpenAPI 3.1 spec
│   ├── api-client-react/       # Generated React Query hooks (credentials: include baked in)
│   ├── api-zod/                # Generated Zod schemas
│   └── db/src/schema/          # Drizzle schema: users, catalog, inventory, requests, events, transfers, staff, account_assets
├── scripts/src/seed.ts         # Seeds all users, catalog, inventory, promo staff, account assets
└── attached_assets/BrewAsset_POS_WMS_(2)_1773750174913.jsx  # Original design reference
```

## API Routes

All routes mounted under `/api/`:
- `GET/POST /api/auth/login` — session login (sets `req.session.userId`)
- `POST /api/auth/logout` — destroys session
- `GET /api/auth/me` — returns current user (401 if not logged in)
- `GET /api/inventory` — all inventory rows
- `POST /api/inventory/receive` — add stock (also logs to receive_history)
- `GET /api/inventory/history` — receive history
- `GET /api/requests?repUsername=...` — list POS requests
- `POST /api/requests` — create request (deducts from inventory)
- `POST /api/requests/:id/fulfill` — mark loaded
- `POST /api/requests/:id/cancel` — cancel + restore inventory
- `GET /api/events?repUsername=...` — list events
- `POST /api/events` — create event request
- `POST /api/events/:id/approve` — marketing approves event
- `POST /api/events/:id/cancel` — cancel event
- `POST /api/events/:id/staff` — toggle staff assignment (`{ staffName }`)
- `POST /api/events/:id/approve-pos` — approve POS for event
- `GET/POST /api/transfers` — list / create asset transfers
- `GET/POST /api/staff` — promo staff roster
- `GET /api/catalog/items` — catalog with brands
- `POST /api/catalog/items` — add catalog item type
- `DELETE /api/catalog/items/:id` — delete item type
- `POST /api/catalog/brands` — add brand to item
- `DELETE /api/catalog/brands/:id` — delete brand
- `GET /api/accounts?repUsername=...` — account assets for a rep

## Design

- Dark industrial theme: `#0a0a0a` background, `#e8a020` amber primary
- Font: DM Mono (monospace)
- Custom CSS variables in `index.css` (Tailwind v4 `@theme inline`)
- Login page has AI-generated brewery warehouse background image

## Vite Proxy

The Vite dev server proxies `/api` to `http://localhost:8080` so the frontend and API are on the same origin.

## Database Notes

- Password hashing: `crypto.createHash('sha256').update(salt + password)` with random salt (format: `salt:hash`)
- Events store `posItems` and `staffAssigned` as JSON strings in TEXT columns
- Transfers to `"MAIN WAREHOUSE"` are treated as returns (increments warehouse inventory)
- `accountAssetsTable` tracks POS items at each account per rep

## Running Seeds

```bash
cd /home/runner/workspace/scripts && npx tsx ./src/seed.ts
```

## TypeScript Notes

- `composite: true` across all packages; typecheck from root with `pnpm run typecheck`
- Auth password hashing must use Node.js built-in `crypto` — bcrypt has native binding issues in this environment
