USE redHatDataGridVideo;

# Actores
DELIMITER $$
CREATE TRIGGER `log_actor_delete`
    AFTER DELETE
    ON `actor`
    FOR EACH ROW INSERT INTO log_actor (actor_id, action, first_name, last_name, last_update)
                 VALUES (OLD.actor_id, 'DELETE', OLD.first_name, OLD.last_name, OLD.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_actor_insert`
    AFTER INSERT
    ON `actor`
    FOR EACH ROW INSERT INTO log_actor (actor_id, action, first_name, last_name, last_update)
                 VALUES (NEW.actor_id, 'INSERT', NEW.first_name, NEW.last_name, NEW.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_actor_update`
    AFTER UPDATE
    ON `actor`
    FOR EACH ROW INSERT INTO log_actor (actor_id, action, first_name, last_name, last_update)
                 VALUES (NEW.actor_id, 'UPDATE', NEW.first_name, NEW.last_name, NEW.last_update)
$$
DELIMITER ;

# Clientes
DELIMITER $$
CREATE TRIGGER `customer_create_date`
    BEFORE INSERT
    ON `customer`
    FOR EACH ROW SET NEW.create_date = NOW()
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_customer_delete`
    AFTER DELETE
    ON `customer`
    FOR EACH ROW INSERT INTO log_customer (customer_id, action, store_id, first_name, last_name, email, address_id,
                                           active,
                                           create_date, last_update)
                 VALUES (OLD.customer_id, 'DELETE', OLD.store_id, OLD.first_name, OLD.last_name, OLD.email,
                         OLD.address_id,
                         OLD.active, OLD.create_date, OLD.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_customer_insert`
    AFTER INSERT
    ON `customer`
    FOR EACH ROW INSERT INTO log_customer (customer_id, action, store_id, first_name, last_name, email, address_id,
                                           active,
                                           create_date, last_update)
                 VALUES (NEW.customer_id, 'INSERT', NEW.store_id, NEW.first_name, NEW.last_name, NEW.email,
                         NEW.address_id,
                         NEW.active, NEW.create_date, NEW.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_customer_update`
    AFTER UPDATE
    ON `customer`
    FOR EACH ROW INSERT INTO log_customer (customer_id, action, store_id, first_name, last_name, email, address_id,
                                           active,
                                           create_date, last_update)
                 VALUES (NEW.customer_id, 'UPDATE', NEW.store_id, NEW.first_name, NEW.last_name, NEW.email,
                         NEW.address_id,
                         NEW.active, NEW.create_date, NEW.last_update)
$$
DELIMITER ;

# Películas
DELIMITER $$
CREATE TRIGGER `del_film`
    AFTER DELETE
    ON `film`
    FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `ins_film`
    AFTER INSERT
    ON `film`
    FOR EACH ROW
BEGIN
    INSERT INTO film_text (film_id, title, description)
    VALUES (new.film_id, new.title, new.description);
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_film_delete`
    AFTER DELETE
    ON `film`
    FOR EACH ROW INSERT INTO log_film (film_id, action, title, description, release_year, language_id,
                                       original_language_id,
                                       rental_duration, rental_rate, length, replacement_cost, rating, special_features,
                                       last_update)
                 VALUES (OLD.film_id, 'DELETE', OLD.title, OLD.description, OLD.release_year, OLD.language_id,
                         OLD.original_language_id, OLD.rental_duration, OLD.rental_rate, OLD.length,
                         OLD.replacement_cost,
                         OLD.rating, OLD.special_features, OLD.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_film_insert`
    AFTER INSERT
    ON `film`
    FOR EACH ROW INSERT INTO log_film (film_id, action, title, description, release_year, language_id,
                                       original_language_id,
                                       rental_duration, rental_rate, length, replacement_cost, rating, special_features,
                                       last_update)
                 VALUES (NEW.film_id, 'INSERT', NEW.title, NEW.description, NEW.release_year, NEW.language_id,
                         NEW.original_language_id, NEW.rental_duration, NEW.rental_rate, NEW.length,
                         NEW.replacement_cost,
                         NEW.rating, NEW.special_features, NEW.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_film_update`
    AFTER UPDATE
    ON `film`
    FOR EACH ROW INSERT INTO log_film (film_id, action, title, description, release_year, language_id,
                                       original_language_id,
                                       rental_duration, rental_rate, length, replacement_cost, rating, special_features,
                                       last_update)
                 VALUES (NEW.film_id, 'UPDATE', NEW.title, NEW.description, NEW.release_year, NEW.language_id,
                         NEW.original_language_id, NEW.rental_duration, NEW.rental_rate, NEW.length,
                         NEW.replacement_cost,
                         NEW.rating, NEW.special_features, NEW.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `upd_film`
    AFTER UPDATE
    ON `film`
    FOR EACH ROW
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
        SET title=new.title,
            description=new.description,
            film_id=new.film_id
        WHERE film_id = old.film_id;
    END IF;
END
$$
DELIMITER ;

# Inventarios
DELIMITER $$
CREATE TRIGGER `log_inventory_delete`
    AFTER DELETE
    ON `inventory`
    FOR EACH ROW INSERT INTO log_inventory (inventory_id, action, film_id, store_id, last_update)
                 VALUES (OLD.inventory_id, 'DELETE', OLD.film_id, OLD.store_id, OLD.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_inventory_insert`
    AFTER INSERT
    ON `inventory`
    FOR EACH ROW INSERT INTO log_inventory (inventory_id, action, film_id, store_id, last_update)
                 VALUES (NEW.inventory_id, 'INSERT', NEW.film_id, NEW.store_id, NEW.last_update)
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `log_inventory_update`
    AFTER UPDATE
    ON `inventory`
    FOR EACH ROW INSERT INTO log_inventory (inventory_id, action, film_id, store_id, last_update)
                 VALUES (NEW.inventory_id, 'UPDATE', NEW.film_id, NEW.store_id, NEW.last_update)
$$
DELIMITER ;

# Pagos
DELIMITER $$
CREATE TRIGGER `payment_date`
    BEFORE INSERT
    ON `payment`
    FOR EACH ROW SET NEW.payment_date = NOW()
$$
DELIMITER ;

# Alquileres
DELIMITER $$
CREATE TRIGGER `rental_date`
    BEFORE INSERT
    ON `rental`
    FOR EACH ROW SET NEW.rental_date = NOW()
$$
DELIMITER ;