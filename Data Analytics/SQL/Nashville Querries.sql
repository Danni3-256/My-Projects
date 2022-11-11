SELECT *
FROM [Nashville_db].[dbo].[housing_db]

-- STANDARDIZE DATE FORMAT

SELECT SaleDate, CONVERT(DATE, SaleDate) AS SalesDate
FROM [Nashville_db].[dbo].[housing_db]

UPDATE [Nashville_db].[dbo].[housing_db]
SET SalesDate = CONVERT(DATE, SaleDate)



--ALTER TABLE dbo.housing_db ADD SalesDate DATE
--UPDATE dbo.housing_db
--SET SalesDAte = CONVERT(DATE, SaleDate)

SELECT SalesDAte
FROM [Nashville_db].[dbo].[housing_db]

------------------------------------------------------------------------------------------------------------
-- PROPERTY ADDRESS

SELECT PropertyAddress FROM [Nashville_db].[dbo].[housing_db]
--WHERE PropertyAddress IS NULL

SELECT x.ParcelID, y.ParcelID, x.PropertyAddress, y.PropertyAddress, ISNULL(x.PropertyAddress, y.PropertyAddress)
FROM [Nashville_db].[dbo].[housing_db] x
JOIN [Nashville_db].[dbo].[housing_db] y
	ON x.ParcelID = y.ParcelID
AND x.[UniqueID ] <> y.[UniqueID ]
WHERE x.PropertyAddress IS NULL

UPDATE x
SET PropertyAddress = ISNULL(x.PropertyAddress, y.PropertyAddress)
FROM [Nashville_db].[dbo].[housing_db] x
JOIN [Nashville_db].[dbo].[housing_db] y
	ON x.ParcelID = y.ParcelID
AND x.[UniqueID ] <> y.[UniqueID ]
WHERE x.PropertyAddress IS NULL

---------------------------------------------------------------------------------------------------------
-- SPLITTING PROPERTY ADDRESS INTO INDIVIDUAL COLUMNS

SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM [Nashville_db].[dbo].[housing_db]

ALTER TABLE dbo.housing_db
ADD PropertyAddressSplit NVARCHAR(100)

UPDATE [Nashville_db].[dbo].[housing_db]
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE dbo.housing_db
ADD PropertySplitCity NVARCHAR(100)

UPDATE [Nashville_db].[dbo].[housing_db]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT * FROM [Nashville_db].[dbo].[housing_db]

SELECT DISTINCT PropertySplitCity FROM [Nashville_db].[dbo].[housing_db]

------------------------------------------------------------------------------------------------

-- SPLITTING OWNER address INTO INDIVIDUAL COLUMNS

SELECT OwnerAddress FROM [Nashville_db].[dbo].[housing_db]

SELECT PARSENAME(REPLACE(OwnerAddress,',','.'), 3),  -- PARSENAME Looks For Periods so we replaced the ',' for periods('.')
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM [Nashville_db].[dbo].[housing_db] 

------ UPDATING TABLE ----------------------------------------------------------------------------------

ALTER TABLE [Nashville_db].[dbo].[housing_db]
ADD OwnerSplitAddress NVARCHAR(100)

UPDATE [Nashville_db].[dbo].[housing_db]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE [Nashville_db].[dbo].[housing_db]
ADD OwnerSplitCity NVARCHAR(100)

UPDATE [Nashville_db].[dbo].[housing_db]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

ALTER TABLE [Nashville_db].[dbo].[housing_db]
ADD OwnerSplitState NVARCHAR(100)

UPDATE [Nashville_db].[dbo].[housing_db]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

SELECT * FROM [Nashville_db].[dbo].[housing_db]

---------------------------------------------------------------------------------------------------------------

-------------------CHANGING 'Y' AND 'N' TO YES AND NO IN SOLDASVACANT----------------------

SELECT COUNT(SoldAsVacant)
FROM [Nashville_db].[dbo].[housing_db]
GROUP BY SoldAsVacant

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [Nashville_db].[dbo].[housing_db]
GROUP BY SoldAsVacant
ORDER BY 2

------------ USING THE CASE STATEMENT -- -- - ---------

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM [Nashville_db].[dbo].[housing_db]

------------UPDATING TABLE ----------------------------

UPDATE [Nashville_db].[dbo].[housing_db]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	 WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM [Nashville_db].[dbo].[housing_db]


----------------------------------------------------------------------------------------------------------

------------------ REMOVE DUPLICATES ----------------- - - - - -RANK - - - ROWNUMBER - - - - - 

WITH Row_NumCTE  AS (
SELECT *, ROW_NUMBER() OVER(
		  PARTITION BY ParcelID,
					   PropertyAddress,
					   SalePrice,
					   SaleDate,
					   LegalReference
					   ORDER BY
						UniqueID) Row_Num 
FROM [Nashville_db].[dbo].[housing_db]
 --ORDER BY ParcelID
)

SELECT *
FROM RowNum
WHERE Row_Num > 1;

------------------------------------------------------------------------------------------------------------
------------------REMOVE UNUSED COLUMNS -----------------------

ALTER TABLE [Nashville_db].[dbo].[housing_db]
DROP COLUMN SaleDate, PropertyAddress, OwnerAddress,TaxDistrict, SaleDate

------------------RENAME COLUMNS-------------------------------
--ALTER TABLE TableName
--RENAME COLUMN OldColumnName TO NewColumnName;



------------------SELECT COLUMNS TO USE	-----------------------


SELECT [UniqueID ], ParcelID, LandUse, PropertyAddress,SalesDAte
FROM [Nashville_db].[dbo].[housing_db]