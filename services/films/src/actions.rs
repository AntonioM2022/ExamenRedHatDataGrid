use actix_web::http::StatusCode;
use derive_more::{Display, Error, From};
use sqlx::{MySql, MySqlPool};

use crate::models::{Film, FilmUpdate, NewFilm};

#[derive(Debug, Display, Error, From)]
pub enum PersistenceError {
    //EmptyBankName,
    //EmptyCountry,
    //EmptyBranch,
    //EmptyLocation,
    //EmptyTellerName,
    //EmptyCustomerName,
    MysqlError(sqlx::Error),

    Unknown,
}

impl actix_web::ResponseError for PersistenceError {
    fn status_code(&self) -> StatusCode {
        match self {
            //PersistenceError::EmptyBankName
            //| PersistenceError::EmptyCountry
            //| PersistenceError::EmptyBranch
            //| PersistenceError::EmptyLocation
            //| PersistenceError::EmptyTellerName
            //| PersistenceError::EmptyCustomerName => StatusCode::BAD_REQUEST,
            PersistenceError::MysqlError(_) | PersistenceError::Unknown => {
                StatusCode::INTERNAL_SERVER_ERROR
            }
        }
    }
}

pub async fn get_films(pool: &sqlx::Pool<MySql>) -> Result<Vec<Film>, PersistenceError> {
    let films = sqlx::query_as!(
        Film,
        r#"SELECT * FROM vw_film_list ORDER BY film_id DESC LIMIT 10"#
    )
    .fetch_all(&mut *pool.acquire().await?)
    .await?;

    Ok(films)
}

pub async fn create_film(
    pool: &sqlx::Pool<MySql>,
    new_film: NewFilm,
) -> Result<String, PersistenceError> {
    log::info!("Creating new film: {:?}", new_film);
    let film = sqlx::query(
        r#"
        CALL sp_insert_film(
        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
        )
        "#,
    )
    .bind(new_film.title)
    .bind(new_film.description)
    .bind(new_film.release_year)
    .bind(new_film.language_id)
    .bind(new_film.original_language_id)
    .bind(new_film.rental_duration)
    .bind(new_film.rental_rate)
    .bind(new_film.length)
    .bind(new_film.replacement_cost)
    .bind(new_film.rating)
    .bind(new_film.special_features)
    .execute(&mut *pool.acquire().await?)
    .await
    .map_err(PersistenceError::from)?;

    match film {
        _ => Ok("Film created successfully".parse().unwrap()),
    }
}

pub async fn get_film_by_id(
    pool: &sqlx::Pool<MySql>,
    film_id: i16,
) -> Result<Film, PersistenceError> {
    let film = sqlx::query_as!(
        Film,
        r#"SELECT * FROM vw_film_list WHERE film_id = ?"#,
        film_id
    )
    .fetch_one(&mut *pool.acquire().await?)
    .await?;

    Ok(film)
}

pub async fn update_film(pool: &MySqlPool, film: FilmUpdate) -> Result<String, PersistenceError> {
    log::info!("Updating film: {:?}", film);
    let updated_film = sqlx::query(
        r#"
        CALL sp_update_film( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        "#,
    )
    .bind(film.film_id)
    .bind(film.title)
    .bind(film.description)
    .bind(film.release_year)
    .bind(film.language_id)
    .bind(film.original_language_id)
    .bind(film.rental_duration)
    .bind(film.rental_rate)
    .bind(film.length)
    .bind(film.replacement_cost)
    .bind(film.rating)
    .bind(film.special_features)
    .execute(&mut *pool.acquire().await?)
    .await
    .map_err(PersistenceError::from)?;

    match updated_film {
        _ => Ok("Film updated successfully".parse().unwrap()),
    }
}
