USE redHatDataGridVideo;

DELIMITER $$
CREATE FUNCTION `f_count_rentals`(`customer_id_param` INT) RETURNS INT(11)
BEGIN
    DECLARE total_rentals INT;

    SELECT COUNT(rental_id)
    INTO total_rentals
    FROM rental
    WHERE customer_id = customer_id_param
      AND return_date IS NOT NULL;

    RETURN total_rentals;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `f_inventory_available`(`store_id_param` INT, `available_param` BOOLEAN) RETURNS INT(11)
BEGIN
    DECLARE total_inventory INT;


    IF available_param THEN
        SELECT COUNT(DISTINCT i.inventory_id)
        INTO total_inventory
        FROM inventory i
                 LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
        WHERE i.store_id = store_id_param
          AND r.inventory_id IS NULL;
    ELSE
        SELECT COUNT(DISTINCT i.inventory_id)
        INTO total_inventory
        FROM inventory i
                 LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
        WHERE i.store_id = store_id_param
          AND r.inventory_id IS NOT NULL;
    END IF;

    RETURN total_inventory;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `f_month_profit`(`month_param` INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_profit DECIMAL(10, 2);
    DECLARE start_date DATE;
    DECLARE end_date DATE;


    SET start_date = DATE(CONCAT(YEAR(CURDATE()), '-', month_param, '-01'));
    SET end_date = LAST_DAY(start_date);

    SELECT SUM(amount)
    INTO total_profit
    FROM payment
    WHERE payment_date BETWEEN start_date AND end_date;

    RETURN total_profit;
END $$
DELIMITER ;