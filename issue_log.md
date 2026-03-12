# Issue Log – Amazon Sales Analysis Project

## 1. Customers table – Country mismatch
**Issue:** Some non-US countries appeared in the `Country` column, but all states and cities correspond to the US.  
**Action Taken:** Validated country-state pairing and corrected all `Country` values to "United States" for consistency.

## 2. Column naming convention
**Issue:** Original CSV columns were in mixed case / CamelCase, which could cause issues in PostgreSQL queries.  
**Action Taken:** Standardized all column names to `snake_case` in pandas before loading into PostgreSQL.

## 3. Duplicate entries
**Issue:** Potential duplicates in `customers` and `products` tables.  
**Action Taken:** Duplicates will be removed in the cleaning step (`df.drop_duplicates(subset=...)`) when creating final clean DataFrames.

## 4. Payment methods
**Issue:** `PaymentMethod` was in a raw string format; could cause inconsistencies.  
**Action Taken:** Ensured column type is string and will keep unique values in a separate reference table.

## 5. Category – Product Name Mismatch
**Issue:** During EDA, inconsistencies were identified between `ProductName` and `Category` fields.
**Action Taken:** A mapping-based correction step was added to the data transformation pipeline to ensure category integrity and consistent aggregation in downstream analysis.


## 6. Processed data saving
**Issue:** Processed CSV files could fail to save if directory didn't exist.  
**Action Taken:** Added a check to create `data/processed` directory if missing. Existing files are overwritten to ensure the latest clean data is saved.

## 7. PostgreSQL loading
**Issue:** Initial load used raw DataFrames, not cleaned ones, causing old column names to persist.  
**Action Taken:** Updated 04 & 05 notebooks to load `clean` DataFrames into PostgreSQL with correct column names.

