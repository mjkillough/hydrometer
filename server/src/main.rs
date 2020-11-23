use actix_web::{post, web::Json, App, HttpResponse, HttpServer, Responder};
use serde::Deserialize;

#[derive(Debug, Deserialize)]
struct Measurement {
    angle: f64,
}

#[post("/path")]
async fn index(measurements: Json<Vec<Measurement>>) -> impl Responder {
    println!("Received: {:?}", measurements);
    HttpResponse::Ok().finish()
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().service(index))
        .bind("0.0.0.0:8080")?
        .run()
        .await
}
