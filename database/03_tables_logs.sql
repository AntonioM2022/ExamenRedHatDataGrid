USE redHatDataGridVideo;

# Actores
CREATE TABLE `log_actor`
(
    `id`          int(11)   NOT NULL AUTO_INCREMENT,
    `actor_id`    int(11)            DEFAULT NULL,
    `action`      varchar(255)       DEFAULT NULL,
    `first_name`  varchar(255)       DEFAULT NULL,
    `last_name`   varchar(255)       DEFAULT NULL,
    `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
);

# Clientes
CREATE TABLE `log_customer`
(
    `id`          int(11)   NOT NULL AUTO_INCREMENT,
    `customer_id` int(11)            DEFAULT NULL,
    `action`      varchar(255)       DEFAULT NULL,
    `store_id`    int(11)            DEFAULT NULL,
    `first_name`  varchar(255)       DEFAULT NULL,
    `last_name`   varchar(255)       DEFAULT NULL,
    `email`       varchar(255)       DEFAULT NULL,
    `address_id`  int(11)            DEFAULT NULL,
    `active`      int(11)            DEFAULT NULL,
    `create_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
);

# Películas
CREATE TABLE `log_film`
(
    `id`                   int(11)   NOT NULL AUTO_INCREMENT,
    `film_id`              int(11)            DEFAULT NULL,
    `action`               varchar(255)       DEFAULT NULL,
    `title`                varchar(255)       DEFAULT NULL,
    `description`          text               DEFAULT NULL,
    `release_year`         int(11)            DEFAULT NULL,
    `language_id`          int(11)            DEFAULT NULL,
    `original_language_id` int(11)            DEFAULT NULL,
    `rental_duration`      int(11)            DEFAULT NULL,
    `rental_rate`          decimal(4, 2)      DEFAULT NULL,
    `length`               int(11)            DEFAULT NULL,
    `replacement_cost`     decimal(5, 2)      DEFAULT NULL,
    `rating`               varchar(255)       DEFAULT NULL,
    `special_features`     text               DEFAULT NULL,
    `last_update`          timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
);

# Inventario
CREATE TABLE `log_inventory`
(
    `id`           int(11)   NOT NULL AUTO_INCREMENT,
    `inventory_id` int(11)            DEFAULT NULL,
    `action`       varchar(255)       DEFAULT NULL,
    `film_id`      int(11)            DEFAULT NULL,
    `store_id`     int(11)            DEFAULT NULL,
    `last_update`  timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`)
);