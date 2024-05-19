use actix_cors::Cors;
use crate::routes::{get_film_by_id, get_films, health_check, post_film, update_films};
use actix_web::{middleware, web, App, HttpServer};
use lib::{get_pool, init_logger, load_env};

mod actions;
mod models;
mod routes;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // initialize environment
    load_env();

    // initialize logger
    init_logger();

    let shared_data = web::Data::new(get_pool().await);

    log::info!("starting HTTP server at http://localhost:8080");


    HttpServer::new(move || {
        App::new()
            .app_data(shared_data.clone())
            .wrap(Cors::default().allow_any_origin().allow_any_method().allow_any_header())
            .wrap(middleware::Logger::default())
            .service(health_check)
            .service(get_films)
            .service(get_film_by_id)
            .service(post_film)
            .service(update_films)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}
