use sqlx::mysql::MySqlPoolOptions;
use sqlx::MySqlPool;
use std::env;

pub fn load_env() {
    dotenvy::dotenv().ok();
}

pub fn init_logger() {
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));
}

pub async fn get_pool() -> MySqlPool {
    log::info!("setting up app from environment");

    let db_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");

    log::info!("initializing database connection");

    match MySqlPoolOptions::new()
        .max_connections(5)
        .connect(&db_url)
        .await
    {
        Ok(pool) => {
            log::info!("database connection established");
            pool
        }
        Err(e) => {
            log::error!("Error: {:?}", e);
            panic!("Error connecting to the database: {:?}", e);
        }
    }
}
