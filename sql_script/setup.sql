CREATE TABLE sales_transaction (
    id INT NOT NULL IDENTITY(1,1),
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id)
);
GO
INSERT INTO sales_transaction (customer_id, product_id, quantity, price)
VALUES (1, 1, 1, 10.00),
       (1, 2, 1, 20.00),
       (1, 3, 1, 30.00),
       (2, 1, 1, 10.00),
       (2, 2, 1, 20.00),
       (2, 3, 1, 30.00),
       (3, 1, 1, 10.00),
       (3, 2, 1, 20.00),
       (3, 3, 1, 30.00);
GO