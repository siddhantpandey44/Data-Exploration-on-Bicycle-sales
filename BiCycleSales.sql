-- Bicycle customers distributiON across states 

-- There are states with name 'NSW' and 'New South Wales', 'VIC' and 'Victoria'. Need to merge these fields 

UPDATE [PortfolioProject].[dbo].['Customer Address$'] 
  SET state = 'NSW'
  WHERE state = 'New South Wales'

UPDATE [PortfolioProject].[dbo].['Customer Address$'] 
  SET state = 'VIC'
  WHERE state = 'Victoria'

-- Check if the changes were reflected 

SELECT DISTINCT(state) 
  FROM [PortfolioProject].[dbo].['Customer Address$']



-- Number of customers from different states in Australia 

SELECT ca.state State, COUNT(*) Total_Sales
  FROM [PortfolioProject].[dbo].['Customer Address$'] ca INNER JOIN [PortfolioProject].[dbo].['Customer Demographic$'] cd 
  ON ca.customer_id = cd.customer_id 
  GROUP BY ca.state
  ORDER BY Total_Sales DESC   -- The maximum customers are from NSW - 2138, VIC - 1021 and QLD -837 




-- Gender Distribution of Customers 

-- There are different values for Male and Female Gender such as 'F','Femal' and 'Female' and same is the case for Male and unknown values.
-- Need to categorize all them into M,F and U 

UPDATE [PortfolioProject].[dbo].['Customer Demographic$'] 
  SET gender = 'F' 
  WHERE gender LIKE 'F%'

UPDATE [PortfolioProject].[dbo].['Customer Demographic$'] 
  SET gender = 'M' 
  WHERE gender LIKE 'M%'

-- Need to check distinct values in gender column now 

SELECT DISTINCT(gender)
  FROM [PortfolioProject].[dbo].['Customer Demographic$'] -- Now there are only three categories M,Fand U 

-- Customer Gender distribution 

SELECT gender Gender, COUNT(*) Total_Count 
  FROM [PortfolioProject].[dbo].['Customer Demographic$'] 
  GROUP BY gender 
  ORDER BY Total_Count DESC                             -- Bicycle is more popular among Female customers than Male customers.




  -- Industry vs Customers
SELECT job_industry_category INDUSTRY, COUNT(*) COUNT
  FROM [PortfolioProject].[dbo].['Customer Demographic$']
  GROUP BY job_industry_category
  ORDER BY COUNT DESC                                     -- Most customers are from Manufacturing Industry and then Financial services
														  -- Lowest number of customers belong to Telecommunications industry



  -- Customer vs Wealth segments

SELECT wealth_segment Wealth_Segment, COUNT(*) TOTAL_CUSTOMERS
  FROM [PortfolioProject].[dbo].['Customer Demographic$']
  GROUP BY wealth_segment
  ORDER BY TOTAL_CUSTOMERS DESC                           -- Mass Customer segment have the most customers with 2000 customers and least customers are from affluent Customer segment




-- Customers who own car 

SELECT owns_car Car_owner, COUNT(*) TOTAL_CUSTOMERS
  FROM [PortfolioProject].[dbo].['Customer Demographic$']
  GROUP BY owns_car
  ORDER BY TOTAL_CUSTOMERS DESC                           -- There doesn't seem to be a vast difference in the distribution of customers who own a car or doesn't.




-- On an average how many bike related purchase have been made by bicyle customers in the last three years

SELECT AVG(past_3_years_bike_related_purchases) Bike_Related_purchase
  FROM [PortfolioProject].[dbo].['Customer Demographic$']   
                                                         -- On an average, approximately 49 bike related purchases have been made by the bicycle customers.



-- How many online purchases have been made

SELECT (SELECT COUNT(online_order) 
		FROM [PortfolioProject].[dbo].[Transactions$] 
		WHERE online_order =1)*100 / COUNT(*) PERCENTAGE_ONLINE 
FROM  [PortfolioProject].[dbo].[Transactions$]          -- 50% of all the orders are made online




-- Out of all the cancelled order, how many were made online?

SELECT COUNT(*) 
  FROM  [PortfolioProject].[dbo].[Transactions$] 
  WHERE order_status = 'Cancelled'                      -- There are 172 Cancelled orders

SELECT (SELECT COUNT(*) 
          FROM  [PortfolioProject].[dbo].[Transactions$] 
          WHERE order_status = 'Cancelled' AND online_order = 1)*100 / COUNT(*) CancelledOnlinePercent
  FROM  [PortfolioProject].[dbo].[Transactions$] 
  WHERE order_status = 'Cancelled'                      -- Out of all the cancelled orders, 56% were cancelled online



-- From which state, there are the most cancelled orders

SELECT COUNT(*) Orders, ca.state 
  FROM [PortfolioProject].[dbo].[Transactions$] t 
  INNER JOIN [PortfolioProject].[dbo].['Customer Address$'] ca 
  ON t.customer_id = ca.customer_id 
  WHERE t.order_status = 'Cancelled' 
  GROUP BY ca.state 
  ORDER BY Orders DESC                                   -- The maximum cancelled products are from New South Wales


-- Most Trusted Brand

SELECT brand Brand, COUNT(*) COUNT
  FROM [PortfolioProject].[dbo].[Transactions$] 
  GROUP BY brand
  ORDER BY COUNT DESC                                    -- The most trusted brand is Solex with 4169 orders
														 -- The brand with the least order is Norco Bicycles with 2863 orders


  
