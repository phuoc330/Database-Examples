CREATE TABLE sold_tos_al_pn
(
  sold_tos_num NUMBER(12)
    CONSTRAINT sold_tos_sold_tos_num_PK PRIMARY KEY,
  sold_tos_name VARCHAR2(30)
    CONSTRAINT sold_tos_sold_tos_name_NN NOT NULL,
  sold_tos_attention VARCHAR2(25)
    CONSTRAINT sold_tos_sold_tos_attention_NN NOT NULL,
  sold_tos_street VARCHAR2(20)
    CONSTRAINT sold_tos_sold_tos_street_NN NOT NULL,
  sold_tos_city VARCHAR2(20)
    CONSTRAINT sold_tos_sold_tos_city_nn NOT NULL,
  sold_tos_state CHAR(2)
    CONSTRAINT sold_tos_sold_tos_state_NN NOT NULL,
  sold_tos_zip_code VARCHAR2(10)
    CONSTRAINT sold_tos_sold_tos_zip_code_NN NOT NULL
);

CREATE TABLE inventory_items_al_pn
(
  item_num VARCHAR2(15)
    CONSTRAINT items_sold_item_num_PK PRIMARY KEY,
  item_description VARCHAR2(45)
    CONSTRAINT items_sold_item_desc_NN NOT NULL,
  item_unit_price NUMBER(6,2)
    CONSTRAINT items_sold_item_unit_price_NN NOT NULL,
  item_uom CHAR(2)
    CONSTRAINT items_sold_item_uom_NN NOT NULL
);


CREATE TABLE ship_tos_al_pn
(
  ship_tos_num NUMBER(6)
    CONSTRAINT ship_tos_ship_tos_num_PK PRIMARY KEY,
  ship_tos_name VARCHAR2(30)
    CONSTRAINT ship_tos_ship_tos_name_NN NOT NULL,
  ship_tos_attention VARCHAR2(25)
    CONSTRAINT ship_tos_ship_tos_attention_NN NOT NULL,
  ship_tos_street VARCHAR2(20)
    CONSTRAINT ship_tos_ship_tos_street_NN NOT NULL,
  ship_tos_city VARCHAR2(20)
    CONSTRAINT ship_tos_ship_tos_city_nn NOT NULL,
  ship_tos_state CHAR(2)
    CONSTRAINT ship_tos_ship_tos_state_NN NOT NULL,
  ship_tos_zip_code VARCHAR2(10)
    CONSTRAINT ship_tos_ship_tos_zip_code_NN NOT NULL,
  ship_tos_sales_tax_rate NUMBER (3, 2)
    CONSTRAINT ship_tos_sales_tax_rate_nn NOT NULL,
  sold_tos_num  NUMBER(6)
    CONSTRAINT sold_tos_sold_tos_num_fk
      REFERENCES sold_tos_al_pn (sold_tos_num)
);

CREATE TABLE invoices_al_pn
(
  invoice_no NUMBER(7)
    CONSTRAINT invoices_invoice_no_PK PRIMARY KEY,
  invoice_date DATE
    CONSTRAINT invoices_invoice_date_NN NOT NULL,
  ship_tos_num NUMBER(6)
    CONSTRAINT invoices_ship_tos_num_NN NOT NULL
    CONSTRAINT invoices_ship_tos_num_FK
      REFERENCES ship_tos_al_pn (ship_tos_num),
  ship_tos_sales_tax_rate NUMBER(3,2)
    CONSTRAINT invoices_tax_rate_NN NOT NULL,
  invoice_order_num NUMBER(10)
    CONSTRAINT invoices_invoice_order_num_NN NOT NULL,
  invoice_order_date DATE
    CONSTRAINT invoices_invoice_order_date_NN NOT NULL,
  invoice_order_salesman_id_num  NUMBER(4)
    CONSTRAINT invoices_salesman_id_num_NN NOT NULL,
  invoice_po_num VARCHAR2(15)
    CONSTRAINT invoices_invoice_po_num_NN NOT NULL,
  invoice_ship_via VARCHAR2(20)
    CONSTRAINT invoices_invoice_ship_via_NN NOT NULL,
  invoice_shipping_terms CHAR(1)
    CONSTRAINT invoices_shipping_terms_NN NOT NULL,
  invoice_payment_terms VARCHAR2(20)
    CONSTRAINT invoices_payment_terms_NN NOT NULL,
  invoice_freight_charges NUMBER(6,2)
    CONSTRAINT invoices_freight_charges_NN NOT NULL,
  invoice_amount_prepaid NUMBER(8,2)
    CONSTRAINT invoices_amount_prepaid_NN NOT NULL
);

CREATE TABLE line_items_al_pn
(
  invoice_no NUMBER(7)
    CONSTRAINT line_items_invoice_no_NN NOT NULL
      REFERENCES invoices_al_pn (invoice_no),
  item_num VARCHAR2(15)
    CONSTRAINT line_items_item_num_NN NOT NULL
      REFERENCES inventory_items_al_pn (item_num),
  item_qty_ordered NUMBER(4)
    CONSTRAINT line_items_qty_ordered_NN NOT NULL,
  item_qty_shipped NUMBER(4)
    CONSTRAINT line_items_qty_shipped_NN NOT NULL,
  item_unit_price NUMBER(6,2)
    CONSTRAINT line_items_unit_price_NN NOT NULL,
      CONSTRAINT line_items_num_PK PRIMARY KEY (invoice_no, item_num)
);

DESCRIBE sold_tos_al_pn
DESCRIBE inventory_items_al_pn
DESCRIBE ship_tos_al_pn
DESCRIBE invoices_al_pn
DESCRIBE line_items_al_pn

CREATE SEQUENCE sold_tos_al_pn_sold_num_seq
  START WITH 000000152040
  INCREMENT BY 1
  MAXVALUE 999999999999
  NOCYCLE
  NOCACHE;

CREATE SEQUENCE ship_tos_al_pn_ship_to_num_seq
  START WITH 234567
  INCREMENT BY 1
  MAXVALUE 999999
  NOCYCLE
  NOCACHE;

CREATE SEQUENCE invoices_al_pn_invoice_no_seq
  START WITH 620141
  INCREMENT BY 1
  MAXVALUE 9999999
  NOCYCLE
  NOCACHE;
  
CREATE SEQUENCE invoices_al_pn_order_num_seq
  START WITH 00559192
  INCREMENT BY 1
  MAXVALUE 9999999999
  NOCYCLE
  NOCACHE;
  
COLUMN constraint_name FORMAT A32;
COLUMN column_name FORMAT A20;
COLUMN table_name FORMAT A15;
SELECT constraint_name, column_name,table_name
FROM user_cons_columns
WHERE constraint_name NOT LIKE 'BIN%'
ORDER BY constraint_name;

SELECT sequence_name, increment_by 
FROM user_sequences;
  
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES (sold_tos_al_pn_sold_num_seq.NEXTVAL, 'PIERSON', 'AP', '3408 FANCHER DRIVE', 'DALLAS', 'TX' , '75201');
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES(sold_tos_al_pn_sold_num_seq.nextval,'PRO SOUND','NULL','1375 NE 14 ST','MIAMI','FL','33076');
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES(sold_tos_al_pn_sold_num_seq.nextval,'NEQUE INC','AP','911 RISUS RD','SAPEL','DE','51995');
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES(sold_tos_al_pn_sold_num_seq.NEXTVAL,'PRESENT LUCTUS','NULL','9432 AT RD','PORT HARCOURT','RI','35134');
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES(sold_tos_al_pn_sold_num_seq.NEXTVAL,'SED DICTUM PROIN','NULL','3858 DIS AVE','SACRAMENTO','CA','84557');
INSERT INTO sold_tos_al_pn (sold_tos_num, sold_tos_name, sold_tos_attention, sold_tos_street, sold_tos_city, sold_tos_state, sold_tos_zip_code)
  VALUES(sold_tos_al_pn_sold_num_seq.NEXTVAL,'VEL EST TEMPOR CO','AP','2485 NEQUE ST','WILMINGTON','DE','12520');

INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('PCDIQ', '4 CHANNEL DIRECT BOX', 358.29, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('WD-7', 'REEL SNAKE COMBO', 65.99, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('AESAD', ' AES ANALOG TO DIGITAL', 457.99, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('MC 1000', 'CAT 5E MEDIA CONVERTER', 3599.99, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('AD2', '1/4IN TS PHONE TO RCA', 6.99, 'FT');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('W12GA', '12 GAUGE SPEAKER CABLE', 4.29, 'FT');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('MPB-58', 'MASS PUNCH BLOCK', 146.45, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('MPB-28', 'MINI PUNCH BLOCK', 109.37, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('PZT52', 'ANALOG CONNECTOR', 79.40, 'EA');
INSERT INTO inventory_items_al_pn (item_num, item_description, item_unit_price, item_uom)
  VALUES ('ZYEWS', '2 CHANNEL SPEAKER', 52.67, 'EA');

INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'TRISTIQUE TELLUS LLP','CAROLYN','7926 PRAESENT ST','FRASER-FORT GEORGE','AL','90987','0.06',000000152040);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'QUAM ELEMENTUM INC','AMAYA','6226 ALIQUAM AVENUE','CASTIGLIONE ','GA','27836','0.07',000000152040);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'LAOREET IPSUM LTD','PAKI','2496 LIBERO ST','CASTELVETERE','WA','73480','0.03',000000152041);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'NUNC ULLAM INC','LAURA','3287 RUTRUM STREET','NEW HAVEN','CT','34873','0.04',000000152041);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'INTEGER FOUNDATION','ZANE','9517 VULPUTATE ST','ALMERE','DE','35414','0.06',000000152042);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'LIBERO MAURIS LIMITED','MACY','2575 NEQUE. AVE','DEVON','MA','47019','0.07',000000152043);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'PELLENTESQUE  INSTITUTE','DREW','5440 TRISTIQUE RD','VANCE','RI','80609','0.03',000000152044);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'AUGUE INDUSTRIES','JUSTIN','1294 ALIQUAM RD','CUXHAVEN','ND','76279','0.04',000000152044);
INSERT INTO ship_tos_al_pn (ship_tos_num, ship_tos_name, ship_tos_attention, ship_tos_street, ship_tos_city, ship_tos_state, ship_tos_zip_code, ship_tos_sales_tax_rate, sold_tos_num)
  VALUES(ship_tos_al_pn_ship_to_num_seq.NEXTVAL,'BARON ELECTRONICS','MARK','1835 WINES LANE','MIAMI','FL','33133','0.06',000000152045);

INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'18-JUL-14',234567,0.06,invoices_al_pn_order_num_seq.NEXTVAL,'17-JUL-14',112,'927229-CRC','UPS GROUND','P','NET 30 DAYS',17.64,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'18-JUL-14',234568,0.07,invoices_al_pn_order_num_seq.NEXTVAL,'16-JUL-14',115,'105466-OTC','UPS GROUND','P','NET 30 DAYS',12.34,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'18-JUL-14',234569,0.03,invoices_al_pn_order_num_seq.NEXTVAL,'15-JUL-14',114,'1641-PW','UPS GROUND','P','NET 30 DAYS',16.72,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'18-JUL-14',234570,0.04,invoices_al_pn_order_num_seq.NEXTVAL,'16-JUL-14',113,'65340','UPS GROUND','P','NET 30 DAYS',15.83,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'21-AUG-14',234571,0.06,invoices_al_pn_order_num_seq.NEXTVAL,'19-AUG-14',110,'GEORGE','UPS GROUND','P','NET 30 DAYS',9.99,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'22-AUG-14',234572,0.07,invoices_al_pn_order_num_seq.NEXTVAL,'20-AUG-14',112,'VERBAL','UPS GROUND','P','NET 30 DAYS',3.45,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'23-SEP-14',234573,0.03,invoices_al_pn_order_num_seq.NEXTVAL,'21-SEP-14',115,'67543','NEXT DAY','P','NET 30 DAYS',85,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'23-SEP-14',234574,0.04,invoices_al_pn_order_num_seq.NEXTVAL,'21-SEP-14',114,'987653-ERM','2ND DAY','P','NET 30 DAYS',50,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'15-OCT-14',234575,0.07,invoices_al_pn_order_num_seq.NEXTVAL,'13-OCT-14',113,'103456-AML','UPS GROUND','P','NET 15 DAYS',5.67,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'17-OCT-14',234567,0.06,invoices_al_pn_order_num_seq.NEXTVAL,'15-OCT-14',110,'104567-PN','UPS GROUND','P','COD',15,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'20-OCT-14',234568,0.07,invoices_al_pn_order_num_seq.NEXTVAL,'18-OCT-14',112,'0417-MAL','UPS GROUND','P','NET 30 DAYS',17.89,0);
INSERT INTO invoices_al_pn (invoice_no, invoice_date, ship_tos_num, ship_tos_sales_tax_rate, invoice_order_num, invoice_order_date, invoice_order_salesman_id_num, invoice_po_num, invoice_ship_via, invoice_shipping_terms, invoice_payment_terms, invoice_freight_charges, invoice_amount_prepaid)
  VALUES(invoices_al_pn_invoice_no_seq.NEXTVAL,'25-OCT-14',234569,0.03,invoices_al_pn_order_num_seq.NEXTVAL,'23-OCT-14',115,'1212-DCL','NEXT DAY','P','NET 30 DAYS',85,0);

INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620141, 'PCDIQ', 1, 1, 358.29);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620141, 'MPB-58', 1, 1, 146.45);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620141, 'MPB-28', 1, 1, 109.37);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620142, 'PCDIQ', 2,2, 358.29);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620142, 'WD-7', 1, 1, 65.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620142, 'MC 1000', 1, 1, 3599.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620142, 'AD2', 3, 3, 6.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620142, 'W12GA', 10, 10, 4.29);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620143, 'MC 1000', 1, 1, 3599.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620144, 'AESAD', 1, 1, 457.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620144, 'AD2', 1, 1, 6.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620145, 'WD-7', 1, 1, 65.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620146, 'MPB-28', 1, 1, 109.37);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620146, 'PCDIQ', 2, 2, 358.29);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620147, 'MPB-58', 1, 1, 146.45);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620147, 'AESAD', 1, 1, 457.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620148, 'WD-7', 1, 1, 65.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620148, 'MPB-28', 2, 2, 109.37);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620149, 'PCDIQ', 1, 1, 358.29);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620149,  'MPB-58', 1, 1, 146.45);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620150, 'MC 1000', 1, 1, 3599.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620151, 'AD2', 5, 5, 6.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620151, 'AESAD', 1, 1, 457.99);
INSERT INTO line_items_al_pn (invoice_no, item_num, item_qty_ordered, item_qty_shipped, item_unit_price)
  VALUES (620152, 'WD-7', 1, 1, 65.99);
