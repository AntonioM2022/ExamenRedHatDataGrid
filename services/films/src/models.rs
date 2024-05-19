use serde::{Deserialize, Serialize};
use sqlx::types::Decimal;
use sqlx::FromRow;

#[derive(Debug, Deserialize)]
pub struct NewFilm {
    pub title: String,
    pub description: String,
    pub release_year: i32,
    pub language_id: i32,
    pub original_language_id: i32,
    pub rental_duration: i32,
    pub rental_rate: Decimal,
    pub length: i32,
    pub replacement_cost: Decimal,
    pub rating: String,
    pub special_features: String,
}

#[derive(Debug, Deserialize)]
pub struct FilmUpdate {
    pub film_id: i32,
    pub title: String,
    pub description: String,
    pub release_year: i32,
    pub language_id: i32,
    pub original_language_id: i32,
    pub rental_duration: i8,
    pub rental_rate: Decimal,
    pub length: i16,
    pub replacement_cost: Decimal,
    pub rating: String,
    pub special_features: String,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct Film {
    pub film_id: i32,
    pub title: Option<String>,
    pub description: Option<String>,
    pub release_year: Option<i32>,
    pub rental_duration: Option<i8>,
    pub rental_rate: Decimal,
    pub length: Option<i16>,
    pub replacement_cost: Decimal,
    pub rating: Option<String>,
    pub special_features: Option<String>,
    pub last_update: chrono::DateTime<chrono::Utc>,
    pub language_name: Option<String>,
    pub category_name: Option<String>,
    pub actors: Option<String>,
}
