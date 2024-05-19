USE redHatDataGridVideo;

CREATE VIEW vw_pending_rental AS
SELECT `rental`.`rental_date`                                       AS `rental_date`,
       `rental`.`return_date`                                       AS `return_date`,
       `film`.`title`                                               AS `title`,
       `category`.`name`                                            AS `category_name`,
       `address`.`address`                                          AS `store_address_detail`,
       `city`.`city`                                                AS `store_city_name`,
       `country`.`country`                                          AS `store_country_name`,
       concat(`customer`.`first_name`, ' ', `customer`.`last_name`) AS `customer_full_name`,
       `customer`.`email`                                           AS `customer_email`,
       `customer_address`.`address`                                 AS `customer_address`,
       `customer_city`.`city`                                       AS `customer_city_name`,
       `customer_country`.`country`                                 AS `customer_country_name`
FROM (((((((((((((`rental` join `inventory` on (`rental`.`inventory_id` = `inventory`.`inventory_id`)) join `film`
                 on (`inventory`.`film_id` = `film`.`film_id`)) join `film_category`
                on (`film`.`film_id` = `film_category`.`film_id`)) join `category`
               on (`film_category`.`category_id` = `category`.`category_id`)) join `staff`
              on (`rental`.`staff_id` = `staff`.`staff_id`)) join `store`
             on (`staff`.`store_id` = `store`.`store_id`)) join `address`
            on (`store`.`address_id` = `address`.`address_id`)) join `city`
           on (`address`.`city_id` = `city`.`city_id`)) join `country`
          on (`city`.`country_id` = `country`.`country_id`)) join `customer`
         on (`rental`.`customer_id` = `customer`.`customer_id`)) join `address` `customer_address`
        on (`customer`.`address_id` = `customer_address`.`address_id`)) join `city` `customer_city`
       on (`customer_address`.`city_id` = `customer_city`.`city_id`)) join `country` `customer_country`
      on (`customer_city`.`country_id` = `customer_country`.`country_id`))
WHERE `rental`.`return_date` is null
ORDER BY `rental`.`rental_date`;

CREATE VIEW vw_film_list AS
SELECT `film`.`film_id`                                     AS `film_id`,
       `film`.`title`                                       AS `title`,
       `film`.`description`                                 AS `description`,
       `film`.`release_year`                                AS `release_year`,
       `film`.`rental_duration`                             AS `rental_duration`,
       `film`.`rental_rate`                                 AS `rental_rate`,
       `film`.`length`                                      AS `length`,
       `film`.`replacement_cost`                            AS `replacement_cost`,
       `film`.`rating`                                      AS `rating`,
       `film`.`special_features`                            AS `special_features`,
       `film`.`last_update`                                 AS `last_update`,
       `language`.`name`                                    AS `language_name`,
       `category`.`name`                                    AS `category_name`,
       group_concat(concat(`actor`.`first_name`, ' ', `actor`.`last_name`) order by `actor`.`first_name` ASC,
                    `actor`.`last_name` ASC separator ', ') AS `actors`
FROM (((((`film` join `language` on (`film`.`language_id` = `language`.`language_id`)) join `film_category`
         on (`film`.`film_id` = `film_category`.`film_id`)) join `category`
        on (`film_category`.`category_id` = `category`.`category_id`)) join `film_actor`
       on (`film`.`film_id` = `film_actor`.`film_id`)) join `actor` on (`film_actor`.`actor_id` = `actor`.`actor_id`))
GROUP BY `film`.`film_id`, `film`.`title`, `film`.`description`, `film`.`release_year`, `film`.`rental_duration`,
         `film`.`rental_rate`, `film`.`length`, `film`.`replacement_cost`, `film`.`rating`, `film`.`special_features`,
         `film`.`last_update`, `language`.`name`, `category`.`name`
ORDER BY `film`.`film_id`;