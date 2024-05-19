USE redHatDataGridVideo;

# Actores
CREATE TABLE `actor`
(
    `actor_id`    smallint(5) NOT NULL AUTO_INCREMENT,
    `first_name`  varchar(45) NOT NULL,
    `last_name`   varchar(45) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`actor_id`),
    KEY `idx_actor_last_name` (`last_name`)
);

# Direcciones
CREATE TABLE `address`
(
    `address_id`  smallint(5) NOT NULL AUTO_INCREMENT,
    `address`     varchar(50) NOT NULL,
    `address2`    varchar(50)          DEFAULT NULL,
    `district`    varchar(20) NOT NULL,
    `city_id`     smallint(5) NOT NULL,
    `postal_code` varchar(10)          DEFAULT NULL,
    `phone`       varchar(20) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`address_id`),
    KEY `idx_fk_city_id` (`city_id`)
);

# Categorías
CREATE TABLE `category`
(
    `category_id` tinyint(3)  NOT NULL AUTO_INCREMENT,
    `name`        varchar(25) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`category_id`)
);

# Ciudades
CREATE TABLE `city`
(
    `city_id`     smallint(5) NOT NULL AUTO_INCREMENT,
    `city`        varchar(50) NOT NULL,
    `country_id`  smallint(5) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`city_id`),
    KEY `idx_fk_country_id` (`country_id`)
);

# Países
CREATE TABLE `country`
(
    `country_id`  smallint(5) NOT NULL AUTO_INCREMENT,
    `country`     varchar(50) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`country_id`)
);

# Clientes
CREATE TABLE `customer`
(
    `customer_id` smallint(5) NOT NULL AUTO_INCREMENT,
    `store_id`    tinyint(3)  NOT NULL,
    `first_name`  varchar(45) NOT NULL,
    `last_name`   varchar(45) NOT NULL,
    `email`       varchar(50)          DEFAULT NULL,
    `address_id`  smallint(5) NOT NULL,
    `active`      tinyint(1)  NOT NULL DEFAULT 1,
    `create_date` datetime    NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`customer_id`),
    KEY `idx_fk_store_id` (`store_id`),
    KEY `idx_fk_address_id` (`address_id`),
    KEY `idx_last_name` (`last_name`)
);

# Películas
CREATE TABLE `film`
(
    `film_id`              smallint(5)   NOT NULL AUTO_INCREMENT,
    `title`                varchar(128)  NOT NULL,
    `description`          text                                                                 DEFAULT NULL,
    `release_year`         year(4)                                                              DEFAULT NULL,
    `language_id`          tinyint(3)    NOT NULL,
    `original_language_id` tinyint(3)                                                           DEFAULT NULL,
    `rental_duration`      tinyint(3)    NOT NULL                                               DEFAULT 3,
    `rental_rate`          decimal(4, 2) NOT NULL                                               DEFAULT 4.99,
    `length`               smallint(5)                                                          DEFAULT NULL,
    `replacement_cost`     decimal(5, 2) NOT NULL                                               DEFAULT 19.99,
    `rating`               enum ('G','PG','PG-13','R','NC-17')                                  DEFAULT 'G',
    `special_features`     set ('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
    `last_update`          timestamp     NOT NULL                                               DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`film_id`),
    KEY `idx_title` (`title`),
    KEY `idx_fk_language_id` (`language_id`),
    KEY `idx_fk_original_language_id` (`original_language_id`)
);

# Películas por actor
CREATE TABLE `film_actor`
(
    `actor_id`    smallint(5) NOT NULL,
    `film_id`     smallint(5) NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`actor_id`, `film_id`),
    KEY `idx_fk_film_id` (`film_id`)
);

# Películas por categoría
CREATE TABLE `film_category`
(
    `film_id`     smallint(5) NOT NULL,
    `category_id` tinyint(3)  NOT NULL,
    `last_update` timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`film_id`, `category_id`),
    KEY `idx_fk_film_id` (`film_id`)
);

# Información de películas
CREATE TABLE `film_text`
(
    `film_id`     smallint(5)  NOT NULL,
    `title`       varchar(255) NOT NULL,
    `description` text DEFAULT NULL,
    FULLTEXT KEY `idx_title_description` (`title`, `description`)
);

# Inventarios
CREATE TABLE `inventory`
(
    `inventory_id` mediumint(8) NOT NULL AUTO_INCREMENT,
    `film_id`      smallint(5)  NOT NULL,
    `store_id`     tinyint(3)   NOT NULL,
    `last_update`  timestamp    NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`inventory_id`),
    KEY `idx_fk_film_id` (`film_id`),
    KEY `idx_store_id_film_id` (`store_id`, `film_id`)
);

# Idiomas
CREATE TABLE `language`
(
    `language_id` tinyint(3) NOT NULL AUTO_INCREMENT,
    `name`        char(20)   NOT NULL,
    `last_update` timestamp  NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`language_id`)
);

# Pagos
CREATE TABLE `payment`
(
    `payment_id`   smallint(5)   NOT NULL AUTO_INCREMENT,
    `customer_id`  smallint(5)   NOT NULL,
    `staff_id`     tinyint(3)    NOT NULL,
    `rental_id`    int(11)                DEFAULT NULL,
    `amount`       decimal(5, 2) NOT NULL,
    `payment_date` datetime      NOT NULL,
    `last_update`  timestamp     NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`payment_id`),
    KEY `idx_fk_staff_id` (`staff_id`),
    KEY `idx_fk_customer_id` (`customer_id`),
    KEY `fk_payment_rental` (`rental_id`)
);

# Alquileres
CREATE TABLE `rental`
(
    `rental_id`    int(11)      NOT NULL AUTO_INCREMENT,
    `rental_date`  datetime     NOT NULL,
    `inventory_id` mediumint(8) NOT NULL,
    `customer_id`  smallint(5)  NOT NULL,
    `return_date`  datetime              DEFAULT NULL,
    `staff_id`     tinyint(3)   NOT NULL,
    `last_update`  timestamp    NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`rental_id`),
    UNIQUE KEY `rental_date` (`rental_date`, `inventory_id`, `customer_id`),
    KEY `idx_fk_inventory_id` (`inventory_id`),
    KEY `idx_fk_customer_id` (`customer_id`),
    KEY `idx_fk_staff_id` (`staff_id`)
);

# Empleados
CREATE TABLE `staff`
(
    `staff_id`    tinyint(3)  NOT NULL AUTO_INCREMENT,
    `first_name`  varchar(45) NOT NULL,
    `last_name`   varchar(45) NOT NULL,
    `address_id`  smallint(5) NOT NULL,
    `picture`     blob                                                  DEFAULT NULL,
    `email`       varchar(50)                                           DEFAULT NULL,
    `store_id`    tinyint(3)  NOT NULL,
    `active`      tinyint(1)  NOT NULL                                  DEFAULT 1,
    `username`    varchar(16) NOT NULL,
    `password`    varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    `last_update` timestamp   NOT NULL                                  DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`staff_id`),
    KEY `idx_fk_store_id` (`store_id`),
    KEY `idx_fk_address_id` (`address_id`)
);

# Tiendas
CREATE TABLE `store`
(
    `store_id`         tinyint(3)  NOT NULL AUTO_INCREMENT,
    `manager_staff_id` tinyint(3)  NOT NULL,
    `address_id`       smallint(5) NOT NULL,
    `last_update`      timestamp   NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`store_id`),
    UNIQUE KEY `idx_unique_manager` (`manager_staff_id`),
    KEY `idx_fk_address_id` (`address_id`)
);