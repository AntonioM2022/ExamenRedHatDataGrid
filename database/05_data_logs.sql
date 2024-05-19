USE redHatDataGridVideo;
# Clientes
INSERT INTO `log_customer` (`id`, `customer_id`, `action`, `store_id`, `first_name`, `last_name`, `email`, `address_id`,
                            `active`, `create_date`, `last_update`)
VALUES (1, 600, 'INSERT', 2, 'ROCÍO', 'GARDEA', 'rociogardea@gmail.com', 606, 1, '2024-05-06 01:16:35',
        '2024-05-06 01:16:35'),
       (2, 601, 'INSERT', 1, 'JAVIER', 'PRIETO', 'javierprieto@gmail.com', 606, 1, '2024-05-06 01:17:28',
        '2024-05-06 01:17:28');

# Películas
INSERT INTO `log_film` (`id`, `film_id`, `action`, `title`, `description`, `release_year`, `language_id`,
                        `original_language_id`, `rental_duration`, `rental_rate`, `length`, `replacement_cost`,
                        `rating`, `special_features`, `last_update`)
VALUES (1, 1001, 'INSERT', 'HARRY POTTER', 'Descripción mágica', 2001, 1, 1, 6, 4.99, 74, 29.99, 'G', 'Trailers',
        '2024-05-06 01:14:23');
