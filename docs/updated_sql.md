# PocketBase SQL Views

This document outlines SQL views that can be created in PocketBase to optimize reporting and dashboard queries. Views are created in PocketBase Admin UI under Collections > New Collection > View type.

> **Important:** All PocketBase views require an `id` column. Use `(ROW_NUMBER() OVER()) AS id` for aggregated views, or select an existing unique column as `id`.

---

## Collections Reference

Based on `pb_schema.json`, these are the key collections:

| Collection | Key Fields |
|------------|-----------|
| `patients` | id, name, species, breed, sex, branch, isDeleted, created |
| `patientSpecies` | id, name |
| `patientBreeds` | id, name, species |
| `products` | id, name, category, price, quantity, stockThreshold, trackByLot, expiration, branch, isDeleted |
| `productLots` | id, product, quantity, lotNumber, expiration, isDeleted |
| `productCategories` | id, name, parent |
| `sales` | id, totalAmount, paymentMethod, status, branch, cashier, created, isDeleted |
| `saleItems` | id, sale, product, productName, quantity, unitPrice, subtotal |
| `appointmentSchedules` | id, date, status, patient, purpose, branch, isDeleted |
| `treatmentPlans` | id, patient, treatment, status |
| `treatmentPlanItems` | id, plan, expectedDate, status, sequence |
| `messages` | id, status, sendDateTime, patient |

---

## HIGH PRIORITY VIEWS

### 1. vw_inventory_status

**Purpose:** Pre-calculate stock status for all products including lot-tracked items.

**Current Problem:** Dashboard fetches ALL products + ALL productLots, then calculates totals and status in Dart.

```sql
SELECT
  p.id,
  p.name,
  p.trackByLot,
  p.stockThreshold,
  p.price,
  p.category,
  p.branch,
  p.expiration,
  p.quantity,
  COALESCE(lot_totals.total_quantity, 0) AS lot_total_quantity,
  COALESCE(lot_totals.lot_count, 0) AS lot_count,
  COALESCE(lot_totals.expired_lots, 0) AS expired_lots,
  COALESCE(lot_totals.near_expiration_lots, 0) AS near_expiration_lots,
  lot_totals.earliest_expiration,
  p.created,
  p.updated
FROM products p
LEFT JOIN (
  SELECT
    pl.product,
    SUM(pl.quantity) AS total_quantity,
    COUNT(*) AS lot_count,
    MIN(pl.expiration) AS earliest_expiration,
    SUM(pl.expiration < datetime('now')) AS expired_lots,
    SUM(pl.expiration >= datetime('now') AND pl.expiration < datetime('now', '+30 days')) AS near_expiration_lots
  FROM productLots pl
  WHERE pl.isDeleted = false OR pl.isDeleted IS NULL
  GROUP BY pl.product
) lot_totals ON p.id = lot_totals.product
WHERE p.isDeleted = false OR p.isDeleted IS NULL
```

> **Note:** Stock status calculation is done in the app:
> - If `trackByLot = true`, use `lot_total_quantity`, else use `quantity`
> - Compare against `stockThreshold` to determine low_stock/out_of_stock

**Benefits:**
- Eliminates 2 full table scans (products + productLots)
- Pre-calculates lot totals and expiration counts
- Provides all data needed for stock status in single query

---

### 2. vw_sales_daily_summary

**Purpose:** Pre-aggregate sales by day and payment method for reports.

**Current Problem:** Reports fetch all sales, then all saleItems using expensive OR filter, then aggregate in Dart.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  DATE(s.created) AS sale_date,
  s.paymentMethod,
  s.branch,
  COUNT(*) AS transaction_count,
  SUM(s.totalAmount) AS total_revenue,
  AVG(s.totalAmount) AS avg_transaction_value
FROM sales s
WHERE (s.isDeleted = false OR s.isDeleted IS NULL)
  AND s.status = 'completed'
GROUP BY DATE(s.created), s.paymentMethod, s.branch
ORDER BY sale_date DESC
```

**Benefits:**
- Single query for daily sales summary
- No need to fetch individual sale records
- Pre-calculated averages

---

### 3. vw_top_selling_products

**Purpose:** Pre-aggregate product sales for top sellers report.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  si.productName,
  si.product AS product_id,
  s.branch,
  DATE(s.created) AS sale_date,
  SUM(si.quantity) AS total_quantity_sold,
  SUM(si.subtotal) AS total_revenue,
  COUNT(DISTINCT s.id) AS transaction_count
FROM saleItems si
JOIN sales s ON si.sale = s.id
WHERE (s.isDeleted = false OR s.isDeleted IS NULL)
  AND s.status = 'completed'
GROUP BY si.productName, si.product, s.branch, DATE(s.created)
ORDER BY total_revenue DESC
```

**Benefits:**
- Eliminates expensive OR filter on sale IDs
- Pre-aggregates product sales
- Can filter by date range efficiently

---

### 4. vw_dashboard_kpis

**Purpose:** Single view for all dashboard statistics.

**Current Problem:** Dashboard makes 5+ separate queries for each KPI.

> **Note:** PocketBase views require a FROM clause. Use separate simpler views or queries.

**Alternative: vw_todays_appointments**
```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  a.status,
  a.branch,
  COUNT(*) AS count
FROM appointmentSchedules a
WHERE DATE(a.date) = DATE('now')
  AND (a.isDeleted = false OR a.isDeleted IS NULL)
GROUP BY a.status, a.branch
```

**Alternative: vw_todays_sales**
```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  s.branch,
  COUNT(*) AS transaction_count,
  COALESCE(SUM(s.totalAmount), 0) AS total_revenue
FROM sales s
WHERE DATE(s.created) = DATE('now')
  AND s.status = 'completed'
  AND (s.isDeleted = false OR s.isDeleted IS NULL)
GROUP BY s.branch
```

**Alternative: vw_active_patients_count**
```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  p.branch,
  COUNT(*) AS active_count
FROM patients p
WHERE p.isDeleted = false OR p.isDeleted IS NULL
GROUP BY p.branch
```

**Benefits:**
- Simpler views that PocketBase can parse
- Each view returns focused data
- Can be queried in parallel from the app

---

## MEDIUM PRIORITY VIEWS

### 5. vw_patient_statistics

**Purpose:** Pre-aggregate patient counts by species and sex for reports.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  ps.id AS species_id,
  ps.name AS species_name,
  p.sex,
  p.branch,
  COUNT(*) AS patient_count
FROM patients p
LEFT JOIN patientSpecies ps ON p.species = ps.id
WHERE p.isDeleted = false OR p.isDeleted IS NULL
GROUP BY ps.id, ps.name, p.sex, p.branch
```

### 5b. vw_new_patients_by_date

**Purpose:** Count new patient registrations by date.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  DATE(p.created) AS registration_date,
  ps.name AS species_name,
  p.branch,
  COUNT(*) AS patient_count
FROM patients p
LEFT JOIN patientSpecies ps ON p.species = ps.id
WHERE p.isDeleted = false OR p.isDeleted IS NULL
GROUP BY DATE(p.created), ps.name, p.branch
ORDER BY registration_date DESC
```

**Benefits:**
- Single query with grouping vs 2 queries + in-memory grouping
- Filter by date range in app to get "new patients" for any period

---

### 6. vw_appointment_summary

**Purpose:** Pre-aggregate appointment statistics by date and status.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  DATE(date) AS appointment_date,
  status,
  purpose,
  branch,
  COUNT(*) AS appointment_count
FROM appointmentSchedules
WHERE isDeleted = false OR isDeleted IS NULL
GROUP BY DATE(date), status, purpose, branch
ORDER BY appointment_date DESC
```

**Benefits:**
- Pre-aggregated data for charting
- Efficiently filter by date range

---

### 7. vw_lot_quantity_totals

**Purpose:** Denormalize lot totals for product queries.

```sql
SELECT
  pl.product AS id,
  p.branch,
  SUM(pl.quantity) AS total_quantity,
  COUNT(*) AS lot_count,
  MIN(pl.expiration) AS earliest_expiration,
  MAX(pl.expiration) AS latest_expiration
FROM productLots pl
JOIN products p ON pl.product = p.id
WHERE (pl.isDeleted = false OR pl.isDeleted IS NULL)
GROUP BY pl.product, p.branch
```

**Benefits:**
- Eliminates N+1 queries when calculating product quantities
- Use `vw_expired_lots` and `vw_near_expiration_lots` for expiration data

---

### 8. vw_treatment_plan_summary

**Purpose:** Aggregate treatment plan statistics by status and treatment type.

```sql
SELECT
  (ROW_NUMBER() OVER()) AS id,
  tp.status,
  t.name AS treatment_name,
  t.id AS treatment_id,
  t.branch,
  COUNT(*) AS plan_count
FROM treatmentPlans tp
LEFT JOIN patientTreatments t ON tp.treatment = t.id
WHERE tp.isDeleted = false OR tp.isDeleted IS NULL
GROUP BY tp.status, t.name, t.id, t.branch
```

### 8b. vw_overdue_treatment_items

**Purpose:** List overdue treatment plan items.

```sql
SELECT
  tpi.id,
  tpi.plan,
  tpi.expectedDate,
  tpi.status,
  tp.patient,
  t.name AS treatment_name,
  t.branch
FROM treatmentPlanItems tpi
JOIN treatmentPlans tp ON tpi.plan = tp.id
LEFT JOIN patientTreatments t ON tp.treatment = t.id
WHERE (tpi.isDeleted = false OR tpi.isDeleted IS NULL)
  AND (tp.isDeleted = false OR tp.isDeleted IS NULL)
  AND tpi.status IN ('scheduled', 'booked')
  AND tpi.expectedDate < datetime('now')
ORDER BY tpi.expectedDate ASC
```

**Benefits:**
- Eliminates fetching ALL treatment plan items
- Separate focused queries for overdue items

---

## LOW PRIORITY VIEWS (Inventory Alerts)

### 9. vw_low_stock_products

**Purpose:** List products with low stock (non-lot-tracked).

```sql
SELECT
  p.id,
  p.name,
  p.quantity,
  p.stockThreshold,
  p.branch
FROM products p
WHERE (p.isDeleted = false OR p.isDeleted IS NULL)
  AND p.trackByLot = false
  AND p.stockThreshold > 0
  AND p.quantity <= p.stockThreshold
```

### 10. vw_low_stock_lot_products

**Purpose:** List lot-tracked products with low total stock.

```sql
SELECT
  p.id,
  p.name,
  p.stockThreshold,
  p.branch,
  COALESCE(SUM(pl.quantity), 0) AS total_quantity
FROM products p
LEFT JOIN productLots pl ON p.id = pl.product AND (pl.isDeleted = false OR pl.isDeleted IS NULL)
WHERE (p.isDeleted = false OR p.isDeleted IS NULL)
  AND p.trackByLot = true
  AND p.stockThreshold > 0
GROUP BY p.id, p.name, p.stockThreshold, p.branch
HAVING total_quantity <= p.stockThreshold
```

### 11. vw_expired_lots

**Purpose:** List expired product lots.

```sql
SELECT
  pl.id,
  p.id AS product_id,
  p.name AS product_name,
  pl.lotNumber,
  pl.quantity,
  pl.expiration,
  p.branch
FROM productLots pl
JOIN products p ON pl.product = p.id
WHERE (pl.isDeleted = false OR pl.isDeleted IS NULL)
  AND (p.isDeleted = false OR p.isDeleted IS NULL)
  AND pl.expiration IS NOT NULL
  AND pl.expiration < datetime('now')
```

### 12. vw_near_expiration_lots

**Purpose:** List lots expiring within 30 days.

```sql
SELECT
  pl.id,
  p.id AS product_id,
  p.name AS product_name,
  pl.lotNumber,
  pl.quantity,
  pl.expiration,
  p.branch
FROM productLots pl
JOIN products p ON pl.product = p.id
WHERE (pl.isDeleted = false OR pl.isDeleted IS NULL)
  AND (p.isDeleted = false OR p.isDeleted IS NULL)
  AND pl.expiration IS NOT NULL
  AND pl.expiration >= datetime('now')
  AND pl.expiration < datetime('now', '+30 days')
ORDER BY pl.expiration ASC
```

---

### 13. vw_messages_pending

**Purpose:** Quick access to pending messages for dashboard.

```sql
SELECT
  m.id,
  m.phone,
  m.content,
  m.sendDateTime,
  m.patient,
  p.name AS patient_name,
  m.appointment,
  m.branch,
  m.created
FROM messages m
LEFT JOIN patients p ON m.patient = p.id
WHERE m.status = 'pending'
  AND (m.isDeleted = false OR m.isDeleted IS NULL)
ORDER BY m.sendDateTime ASC
```

---

## Implementation in PocketBase

### Creating Views via Admin UI

1. Go to PocketBase Admin UI
2. Navigate to Collections
3. Click "New Collection"
4. Select "View" as the type
5. Enter the view name (e.g., `vw_inventory_status`)
6. Paste the SQL query
7. Configure API rules (listRule, viewRule)
8. Save

### Creating Views via Migration

Create a migration file in `server/pb_migrations/`:

```javascript
// 1737849600_create_inventory_views.js
migrate((app) => {
  const collection = new Collection({
    name: "vw_inventory_status",
    type: "view",
    viewQuery: `
      SELECT
        p.id AS product_id,
        p.name AS product_name,
        -- ... rest of query
      FROM products p
      -- ... rest of query
    `,
    listRule: "@request.auth.id != ''",
    viewRule: "@request.auth.id != ''",
  });

  return app.save(collection);
}, (app) => {
  const collection = app.findCollectionByNameOrId("vw_inventory_status");
  return app.delete(collection);
});
```

---

## Summary Table

| Priority | View Name | Purpose | Branch |
|----------|-----------|---------|--------|
| HIGH | `vw_inventory_status` | Products with lot totals and expiration counts | `p.branch` |
| HIGH | `vw_sales_daily_summary` | Sales aggregated by day/payment method/branch | `s.branch` |
| HIGH | `vw_top_selling_products` | Product sales aggregated by day/branch | `s.branch` |
| HIGH | `vw_todays_appointments` | Today's appointments grouped by status/branch | `a.branch` |
| HIGH | `vw_todays_sales` | Today's sales count and revenue per branch | `s.branch` |
| HIGH | `vw_active_patients_count` | Active patients count per branch | `p.branch` |
| MEDIUM | `vw_patient_statistics` | Patients grouped by species/sex/branch | `p.branch` |
| MEDIUM | `vw_new_patients_by_date` | New patient registrations by date/branch | `p.branch` |
| MEDIUM | `vw_appointment_summary` | Appointments grouped by date/status/purpose/branch | `branch` |
| MEDIUM | `vw_lot_quantity_totals` | Lot totals per product/branch | `p.branch` |
| MEDIUM | `vw_treatment_plan_summary` | Plans grouped by status/treatment/branch | `t.branch` |
| MEDIUM | `vw_overdue_treatment_items` | Overdue treatment plan items with branch | `t.branch` |
| LOW | `vw_low_stock_products` | Non-lot products below threshold | `p.branch` |
| LOW | `vw_low_stock_lot_products` | Lot-tracked products below threshold | `p.branch` |
| LOW | `vw_expired_lots` | Expired product lots | `p.branch` |
| LOW | `vw_near_expiration_lots` | Lots expiring within 30 days | `p.branch` |
| LOW | `vw_messages_pending` | Pending messages for dashboard | `m.branch` |

---

## Notes

1. **ID Column Required:** Every PocketBase view must have an `id` column. Options:
   - Use `(ROW_NUMBER() OVER()) AS id` for aggregated views
   - Use an existing unique column: `pl.id`, `p.id`, etc.
   - Use a composite key with `||`: `(product_id || '_' || lot_id) AS id`

2. **SQLite Functions:** PocketBase uses SQLite. Use `datetime('now')` for current timestamp, `DATE()` for date extraction, `julianday()` for date math.

3. **NULL Handling:** Use `COALESCE()` for null-safe defaults. Check `isDeleted = false OR isDeleted IS NULL` to handle both cases.

4. **No CASE Expressions:** PocketBase has limited support for complex CASE statements in views. Keep logic simple or move it to the app layer.

3. **Performance:** Views are re-computed on each query. For very large datasets, consider:
   - Adding indexes on frequently filtered columns
   - Using materialized views (requires custom implementation)
   - Caching results in the Flutter app

4. **Testing:** After creating views, compare query performance using PocketBase logs or SQLite EXPLAIN.
