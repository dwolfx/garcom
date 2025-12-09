# Implementation Plan - B2C UX Improvements

## Goal Description
Improve the User Experience of the "Consagrado" app by:
1.  **Dynamic Home Action**: The main CTA button will intelligently switch between "Ler QR Code" (Scanner) and "Minha Comanda" (Tab) based on whether the user has an open tab.
2.  **Detailed History**: Users can view the full receipt (items, prices, service fee) of past visits.

## User Review Required
> [!NOTE]
> For the history feature, we will continue using mock data as there is no historical order database yet.

## Proposed Changes

### B2C App (Consagrado)

#### [MODIFY] [Home.jsx](file:///c:/Users/dwolf/Sites/garcom/b2c-app/src/pages/Home.jsx)
- **State Logic**: Check `localStorage.getItem('my_table_id')` on mount.
- **Conditional Rendering**:
    - **No Table**: Show "Ler QR Code" -> Navigates to `/scanner`.
    - **Has Table**: Show "Minha Comanda" -> Navigates to `/tab`.
- **Styling**: Ensure both buttons maintain the premium "Neon" look.

#### [MODIFY] [History.jsx](file:///c:/Users/dwolf/Sites/garcom/b2c-app/src/pages/History.jsx)
- **Data Structure**: Update `historyData` to include `items: [{ name, price, quantity }]`.
- **Modal Component**: behaviors for clicking a history item.
- **Receipt View**:
    - Show list of items.
    - Calculate Subtotal.
    - Show Service Fee (10%).
    - Show Total.
- **Visuals**: Glassmorphism modal overlay.

## Verification Plan

### Manual Verification
1.  **Home Button**:
    - Clear local storage/logout -> Verify button says "Ler QR Code".
    - "Scan" a code (simulate) -> Verify button says "Minha Comanda".
2.  **History**:
    - Go to History page.
    - Click on "Bar do Zé".
    - Verify modal opens with "Heineken", "Batata Frita", etc.
    - Verify totals match (Subtotal + 10% = Total).
