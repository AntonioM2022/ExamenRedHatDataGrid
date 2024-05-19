use actix_web::{get, post, put, web, Responder};
use sqlx::MySqlPool;

///
/// # Obtener películas
///
/// Obtiene las últimas 10 películas de la base de datos.
///
/// # Ejemplo
///
/// ```json
/// [
///     {
///         "film_id": 1,
///         "title": "Film Title",
///         "description": "Film Description",
///         "release_year": 2021,
///         "rental_duration": 1,
///         "rental_rate": "1.0",
///         "length": 50,
///         "replacement_cost": "1.0",
///         "rating": "G",
///         "special_features": "Trailers",
///         "last_update": "2021-01-01 00:00:00",
///         "language_name": "English",
///         "category_name": "Action",
///         "actors": "Actor 1, Actor 2"
///     },
///    ...
/// ]
///
#[get("/")]
pub async fn get_films(data: web::Data<MySqlPool>) -> actix_web::Result<impl Responder> {
    let films = crate::actions::get_films(data.get_ref())
        .await
        .map_err(|e| {
            log::error!("Error: {:?}", e);
            actix_web::Error::from(e)
        })?;
    Ok(actix_web::HttpResponse::Ok().json(films))
}

///
/// # Obtener una película por ID
///
/// Obtiene una película de la base de datos por su ID.
///
///
/// # Ejemplo
///
/// Request: GET /1
///
/// Response:
/// ```json
/// {
///    "film_id": 1,
///     "title": "Film Title",
///     "description": "Film Description",
///     "release_year": 2021,
///     "language_id": 1,
///     "original_language_id": 1,
///     "rental_duration": 1,
///     "rental_rate": 1.0,
///     "length": 1,
///     "replacement_cost": 1.0,
///     "rating": "G",
///     "special_features": "Trailers",
///     "last_update": "2021-01-01 00:00:00"
/// }
/// ```
///
#[get("/{id}")]
pub async fn get_film_by_id(
    data: web::Data<MySqlPool>,
    id: web::Path<i16>,
) -> actix_web::Result<impl Responder> {
    let film = crate::actions::get_film_by_id(data.get_ref(), *id)
        .await
        .map_err(|e| {
            log::error!("Error: {:?}", e);
            actix_web::Error::from(e)
        })?;
    Ok(actix_web::HttpResponse::Ok().json(film))
}

///
/// # Crear una película
///
/// Crea una nueva película en la base de datos.
///
/// # Ejemplo
/// ## Request
/// ```json
/// {
///     "title": "Film Title",
///     "description": "Film Description",
///     "release_year": 2021,
///     "language_id": 1,
///     "original_language_id": 1,
///     "rental_duration": 1,
///     "rental_rate": "1.0",
///     "length": 1,
///     "replacement_cost": "1.0",
///     "rating": "G",
///     "special_features": "Trailers",
/// }
/// ```
/// ## Response
/// ```json
/// {
///    "film_id": 1,
///     "title": "Film Title",
///     "description": "Film Description",
///     "release_year": 2021,
///     "language_id": 1,
///     "original_language_id": 1,
///     "rental_duration": 1,
///     "rental_rate": "1.0",
///     "length": 1,
///     "replacement_cost": "1.0",
///     "rating": "G",
///     "special_features": "Trailers",
///     "last_update": "2021-01-01 00:00:00"
/// }
/// ```
///
#[post("/")]
pub async fn post_film(
    content: web::Json<crate::models::NewFilm>,
    data: web::Data<MySqlPool>,
) -> impl Responder {
    let film = crate::actions::create_film(data.get_ref(), content.into_inner()).await;

    match film {
        Ok(film) => actix_web::HttpResponse::Created().json(film),
        Err(e) => {
            log::error!("Error: {:?}", e);
            actix_web::HttpResponse::InternalServerError().finish()
        }
    }
}

///
/// # Actualizar una película
///
/// Actualiza una película en la base de datos por su ID.
///
/// # Ejemplo
///
/// ```json
/// {
///     "film_id": 1,
///     "title": "Film Title Updated",
///     "description": "Film Description Updated",
///     "release_year": 2021,
///     "language_id": 1,
///     "original_language_id": 1,
///     "rental_duration": 1,
///     "rental_rate": "1.0",
///     "length": 1,
///     "replacement_cost": "1.0",
///     "rating": "G",
///     "special_features": "Trailers",
/// }
/// ```
///
#[put("/")]
pub async fn update_films(
    content: web::Json<crate::models::FilmUpdate>,
    data: web::Data<MySqlPool>,
) -> impl Responder {
    let film = crate::actions::update_film(data.get_ref(), content.into_inner()).await;

    match film {
        Ok(film) => actix_web::HttpResponse::Ok().json(film),
        Err(e) => {
            log::error!("Error: {:?}", e);
            actix_web::HttpResponse::InternalServerError().finish()
        }
    }
}

///
/// # Verificar estado del servicio
///
/// Verifica que el servicio esté en ejecución.
///
/// # Ejemplo
///
/// ```json
/// "I'm alive!"
/// ```
///
#[get("/health")]
pub async fn health_check() -> impl Responder {
    actix_web::HttpResponse::Ok().json("I'm alive!")
}
