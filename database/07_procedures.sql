USE redHatDataGridVideo;

# Activar creación de procedimientos almacenados
set global log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE PROCEDURE sp_manage_customer(IN `p_store_id` TINYINT(3),
                                    IN `p_first_name` VARCHAR(45),
                                    IN `p_last_name` VARCHAR(45), IN `p_email` VARCHAR(50),
                                    IN `p_address` VARCHAR(50), IN `p_address2` VARCHAR(50),
                                    IN `p_district` VARCHAR(20), IN `p_city_id` SMALLINT(5),
                                    IN `p_postal_code` VARCHAR(10),
                                    IN `p_phone` VARCHAR(20), IN `p_active` TINYINT(1),
                                    IN `p_create_date` DATETIME)
BEGIN
    DECLARE v_address_id SMALLINT(5);
    SELECT address_id
    INTO v_address_id
    FROM address
    WHERE address = p_address
      AND address2 = p_address2
      AND district = p_district
      AND city_id = p_city_id
      AND postal_code = p_postal_code
      AND phone = p_phone;

    IF v_address_id IS NULL THEN
        INSERT INTO address (address, address2, district, city_id, postal_code, phone, last_update)
        VALUES (p_address, p_address2, p_district, p_city_id, p_postal_code, p_phone, NOW());
        SET v_address_id = LAST_INSERT_ID();
    END IF;

    INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
    VALUES (p_store_id, p_first_name, p_last_name, p_email, v_address_id, p_active, p_create_date);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insert_film(
    IN p_title VARCHAR(128),
    IN p_description TEXT,
    IN p_release_year YEAR(4),
    IN p_language_id TINYINT(3),
    IN p_original_language_id TINYINT(3),
    IN p_rental_duration TINYINT(3),
    IN p_rental_rate DECIMAL(4, 2),
    IN p_length SMALLINT(5),
    IN p_replacement_cost DECIMAL(5, 2),
    IN p_rating ENUM ('G','PG','PG-13','R','NC-17'),
    IN p_special_features SET ('Trailers','Commentaries','Deleted Scenes','Behind the Scenes')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            -- Manejo de excepción: revertir la transacción en caso de error
            ROLLBACK;
            -- Lanzar un mensaje de error
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Ha ocurrido un error en la inserción de la película.';
        END;

    -- Iniciar la transacción
    START TRANSACTION;

    -- Intentar la inserción
    INSERT INTO film (title, description, release_year, language_id, original_language_id,
                      rental_duration, rental_rate, length, replacement_cost, rating, special_features)
    VALUES (p_title, p_description, p_release_year, p_language_id,
            p_original_language_id, p_rental_duration, p_rental_rate,
            p_length, p_replacement_cost, p_rating, p_special_features);

    -- Confirmar la transacción
    COMMIT;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_update_film(
    IN p_film_id INT,
    IN p_title VARCHAR(128),
    IN p_description TEXT,
    IN p_release_year YEAR(4),
    IN p_language_id TINYINT(3),
    IN p_original_language_id TINYINT(3),
    IN p_rental_duration TINYINT(3),
    IN p_rental_rate DECIMAL(4, 2),
    IN p_length SMALLINT(5),
    IN p_replacement_cost DECIMAL(5, 2),
    IN p_rating ENUM ('G','PG','PG-13','R','NC-17'),
    IN p_special_features SET ('Trailers','Commentaries','Deleted Scenes','Behind the Scenes')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN

            ROLLBACK;

            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Ha ocurrido un error en la actualización de la película.';
        END;
    START TRANSACTION;
    UPDATE film
    SET title                = p_title,
        description          = p_description,
        release_year         = p_release_year,
        language_id          = p_language_id,
        original_language_id = p_original_language_id,
        rental_duration      = p_rental_duration,
        rental_rate          = p_rental_rate,
        length               = p_length,
        replacement_cost     = p_replacement_cost,
        rating               = p_rating,
        special_features     = p_special_features
    WHERE film_id = p_film_id;
    COMMIT;
END $$
DELIMITER ;