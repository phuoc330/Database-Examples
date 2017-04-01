REM Write a SQL select statement for each of your tables:

SELECT sold_tos_num "Cust. No", sold_tos_name "Name", sold_tos_attention "Attention", sold_tos_street "Street", sold_tos_city "City", sold_tos_state "State", sold_tos_zip_code "Zip Code"
	FROM sold_tos_al_pn;

SELECT *
	FROM inventory_items_al_pn;

SELECT ship_tos_num "Ship To No.", ship_tos_name "Name", ship_tos_attention "Attention", ship_tos_street "Street", ship_tos_city "City", ship_tos_state "St", ship_tos_zip_code "Zip Code", ship_tos_sales_tax_rate "Tax (Historical)", sold_tos_num "Cust. No."
	FROM ship_tos_al_pn;

SELECT invoice_no "Invoice No.", to_char(invoice_date,'MM/DD/YYYY') "Invoice Date", ship_tos_num "Ship to No.", ship_tos_sales_tax_rate "Tax", invoice_order_num "Order No.", to_char(invoice_order_date,'MM/DD/YYYY') "Order Date", invoice_order_salesman_id_num "Salesman ID",
invoice_po_num "PO", invoice_ship_via "Ship Via", invoice_shipping_terms "Shipping Terms", invoice_payment_terms "Payment Terms", invoice_freight_charges "Freight Charges", invoice_amount_prepaid "Amount Prepaid"
         FROM invoices_al_pn;

SELECT *
FROM line_items_al_pn;

REM Data which is sorted on a non-key (not on PK or FK) field  (minimum of 4 queries) :

REM 2 should sort on one field
REM This query alphabetically sorts the consumer’s state in the sold_tos table in an ascending  order. 
	SELECT sold_tos_num, sold_tos_name, sold_tos_state
		FROM sold_tos_al_pn
		ORDER BY sold_tos_state;

REM This query alphabetically sorts the consumer’s name in the sold_tos table in an ascending  order. 
	SELECT sold_tos_num, sold_tos_name, sold_tos_state
		FROM sold_tos_al_pn
		ORDER BY sold_tos_name;

REM 2 should sort on multiple fields
REM This query alphabetically sorts how the order was shipped and the related salesman number in an ascending order.
	SELECT invoice_order_salesman_id_num "Salesman ID#", invoice_ship_via
		FROM invoices_al_pn
		ORDER BY invoice_ship_via, invoice_order_salesman_id_num ;

REM This query alphabetically sorts the date on the invoice and the freight charged in an ascending order.
	SELECT TO_CHAR(invoice_date,'MM/DD/YYYY'), invoice_freight_charges
		FROM invoices_al_pn
		ORDER BY invoice_date, invoice_freight_charges;

REM Data which returns multiple rows, but only  a subset of rows (minimum of 4 queries) :

REM 1 should use AND/OR
REM This query finds items whose description includes the term ‘PUN’ or has a price lower or equal to that of 100.00.
	SELECT item_num, item_description, item_unit_price, item_uom
		FROM inventory_items_al_pn
		WHERE item_description LIKE '%PUN%' OR item_unit_price <= 100.00;

REM 1 should use =
REM This query finds items whose unit of measure are ‘EA’.
	SELECT item_num, item_description, item_unit_price, item_uom
		FROM inventory_items_al_pn
		WHERE item_uom = 'EA';

REM 1 should use LIKE and wildcard characters
REM This query finds items with an item number starting with M.
	SELECT item_num, item_description, item_unit_price, item_uom
		FROM inventory_items_al_pn
		WHERE item_num LIKE 'M%';


REM 1 should be something other than the above listed choices
REM This query finds items whose price is between a maximum of 100.00 and a minimum of 1.00.
	SELECT item_num, item_description, item_unit_price, item_uom
		FROM inventory_items_al_pn
		WHERE item_unit_price BETWEEN 1.00 AND 100.00;

REM Data from multiple tables (minimum of 4 queries)

REM Which customers requested expedited shipping?
	SELECT DISTINCT sold_tos_num, sold_tos_name, invoice_ship_via
		FROM sold_tos_al_pn JOIN ship_tos_al_pn USING (sold_tos_num) 
		JOIN invoices_al_pn USING (ship_tos_num)
		WHERE invoice_ship_via = 'NEXT DAY' OR invoice_ship_via ='2ND DAY'
		ORDER BY sold_tos_num;

REM 1 should use outer join
REM This query displays which item in inventory items has been ordered. Of note are 2 items not yet ordered.
	SELECT inventory_items_al_pn.item_num, line_items_al_pn.invoice_no
		FROM line_items_al_pn, inventory_items_al_pn
		WHERE line_items_al_pn.item_num(+)=inventory_items_al_pn.item_num;

REM 1 should use inner join with at least 4 tables
REM This query joins four tables to display customers from the state of Florida, what they ordered and how much of it did they order. 
	SELECT DISTINCT ship_tos_al_pn.ship_tos_name, line_items_al_pn.invoice_no, line_items_al_pn.item_num, line_items_al_pn.item_qty_ordered, ship_tos_al_pn.ship_tos_state "ST"
		FROM ship_tos_al_pn, invoices_al_pn, inventory_items_al_pn, line_items_al_pn
		WHERE ship_tos_al_pn.ship_tos_num = invoices_al_pn.ship_tos_num
			AND invoices_al_pn.invoice_no = line_items_al_pn.invoice_no
			AND line_items_al_pn.item_num = inventory_items_al_pn.item_num
			AND ship_tos_al_pn.ship_tos_state = 'FL'
		ORDER BY invoice_no;

REM 1 other
REM This “Natural Join” joins the sold to and ship to tables using the sold to number to show which company is shipped to whom.
	SELECT sold_tos_num, sold_tos_name, ship_tos_name, ship_tos_attention 
		FROM sold_tos_al_pn NATURAL JOIN ship_tos_al_pn
		ORDER BY sold_tos_num;

REM Data which is grouped (minimum of 4 queries)

REM 1 should calculate the grand total for each invoice
REM What is the total amount due on each invoice?
	SELECT invoice_no,SUM(item_qty_ordered*item_unit_price) "EXTENDED", TO_CHAR(SUM(item_qty_ordered*item_unit_price*ship_tos_sales_tax_rate),'999.99') "TAX",SUM(invoice_freight_charges)"FREIGHT", TO_CHAR(SUM(item_qty_ordered*item_unit_price+item_qty_ordered*item_unit_price*ship_tos_sales_tax_rate+invoice_freight_charges),'9999.99')"TOTAL"
		FROM line_items_al_pn JOIN invoices_al_pn
		USING (invoice_no)
		GROUP BY invoice_no
		ORDER BY invoice_no;

REM 1 should count the number of invoices or items you have
REM How many different items do we have for sale?
	SELECT COUNT (DISTINCT item_num) "Number of SKU’s"
		FROM inventory_items_al_pn;


REM 1 should use the GROUP BY clause
REM How many places do we ship to in each state?
  	SELECT ship_tos_state "ST" , COUNT(DISTINCT ship_tos_state) "Orders Shipped"
		FROM ship_tos_al_pn
		GROUP BY ship_tos_state
		ORDER BY ship_tos_state;

REM 1 should be something other than the above listed choices
REM Which customer bought the most product (by $)?
	SELECT sold_tos_num, TO_CHAR(SUM(item_qty_ordered*item_unit_price), '9999.99') "TOTAL"
	    FROM line_items_al_pn JOIN invoices_al_pn USING (invoice_no)
        		JOIN ship_tos_al_pn USING (ship_tos_num)
       		JOIN sold_tos_al_pn USING (sold_tos_num)
	    GROUP BY sold_tos_num
	    ORDER BY "TOTAL" DESC;
