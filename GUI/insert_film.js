document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("form");

    form.addEventListener("submit", function(event) {
        event.preventDefault(); 

        const title = document.getElementById("titulo").value;
        const description = document.getElementById("descripcion").value;
        const releaseYear = parseInt(document.getElementById("fecha_lanzamiento").value);
        const languageId = parseInt(document.getElementById("idIdioma").value);
        const originalLanguageId = 2;//Aqui puede ir null 
        const rentalDuration = parseInt(document.getElementById("duracion").value);
        const rentalRate = parseFloat(document.getElementById("tRenta").value).toFixed(2);
        const length = parseInt(document.getElementById("duracion").value);
        const replacementCost = parseFloat(document.getElementById("cRemplazo").value).toFixed(2);
        const rating = document.getElementById("rating").value;
        const specialFeatures = document.getElementById("special_features").value;
        const actors = [1, 2]; // Asumiendo valores fijos para "actors"
        const category = document.getElementById("category").value;

        const filmData = {
            title,
            description,
            release_year: releaseYear,
            language_id: languageId,
            original_language_id: originalLanguageId,
            rental_duration: rentalDuration,
            rental_rate: rentalRate,
            length,
            replacement_cost: replacementCost,
            rating,
            special_features: specialFeatures,
            actors,
            category
        };

        fetch("localhost:8080", { 
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(filmData)
        })
        .then(response => response.json())
        .then(data => {
            console.log('Éxito:', data);
            alert("Se ha insertado correctamente la película");
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });
});
