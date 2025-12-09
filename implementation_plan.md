# Implementation Plan - Kitchen Display System (KDS)

## Goal Description
Implement a Kitchen Display System (KDS) within the `b2b-app` (Chefia) to allow kitchen staff to view, manage, and update the status of orders in real-time. This closes the loop between the customer placing an order and the kitchen preparing it.

## User Review Required
> [!IMPORTANT]
> This change introduces new order statuses: `preparing` and `ready`. Existing orders will remain `pending` or `delivered`.

## Proposed Changes

### Database
No schema changes required (status is `TEXT`), but logical flow will update:
- `pending`: Default state.
- `preparing`: Kitchen acknowledged and started.
- `ready`: Food is ready to be picked up.
- `delivered`: Customer received it (final state).

### B2B App (Chefia)

#### [NEW] [Kitchen.jsx](file:///c:/Users/dwolf/Sites/garcom/b2b-app/src/pages/Kitchen.jsx)
- **Kanban/Grid View**: Display orders in cards.
- **Columns/Sections**:
    - **A Fazer (Pending)**: New orders. High visibility.
    - **Preparando (Preparing)**: Orders in progress.
    - **Pronto (Ready)**: Waiting for waiter.
- **Card Details**: Table #, Product, Quantity, Timer (time since ordered).
- **Actions**: "Iniciar", "Pronto", "Entregue".

#### [MODIFY] [App.jsx](file:///c:/Users/dwolf/Sites/garcom/b2b-app/src/App.jsx)
- Add route `/kitchen` for the KDS.

#### [MODIFY] [Sidebar.jsx](file:///c:/Users/dwolf/Sites/garcom/b2b-app/src/components/Sidebar.jsx) (if exists) or Dashboard navigation
- Add link to "Cozinha" in the main navigation.

## Verification Plan

### Manual Verification
1.  Open KDS page in `b2b-app`.
2.  Create a new order in `b2c-app` (or manually insert in DB).
3.  Observe order appearing in "A Fazer" instantly (Realtime).
4.  Click "Iniciar" -> Moves to "Preparando".
5.  Click "Pronto" -> Moves to "Pronto".
6.  Verify status updates in database and other views.
