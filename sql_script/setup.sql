CREATE TABLE sales_transaction (
    id INT NOT NULL IDENTITY(1,1),
    sale_date DATETIME,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
);
GO
INSERT INTO sales_transaction (sale_date, customer_id, product_id, quantity, price)
VALUES (GETDATE(), 1, 1, 1, 10.00),
         (GETDATE(), 1, 2, 1, 20.00),
         (GETDATE(), 1, 3, 1, 30.00),
         (GETDATE(), 2, 1, 1, 10.00),
         (GETDATE(), 2, 2, 1, 20.00),
         (GETDATE(), 2, 3, 1, 30.00),
         (GETDATE(), 3, 1, 1, 10.00),
         (GETDATE(), 3, 2, 1, 20.00),
         (GETDATE(), 3, 3, 1, 30.00);
GO