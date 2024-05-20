const buscar = document.getElementById("buscar");



buscar.addEventListener("click", function() {
    const apiURL = "http://localhost:8080"; 
    const id = document.getElementById("id").value;
    
    

    function fetchData() {
        fetch(apiURL + '/'+id)
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
                document.getElementById("titulo").value = data.title;
                document.getElementById("descripcion").value = data.description;
                document.getElementById("anio_lanzamiento").value = data.release_year;
                document.getElementById("duracion").value = data.length;
                document.getElementById("duracion_renta").value = data.rental_duration;
                document.getElementById("costo_reemplazo").value = data.replacement_cost;
                document.getElementById("tasa_renta").value = data.rental_rate;
                document.getElementById("rating").value = data.rating;

                const special_features = data.special_features.split(',');
                if (special_features.includes("Trailers")) document.getElementById("trailer").checked = true;
                if (special_features.includes("Commentaries")) document.getElementById("comentarios").checked = true;
                if (special_features.includes("Deleted Scenes")) document.getElementById("escenas_eliminadas").checked = true;
                if (special_features.includes("Behind the Scenes")) document.getElementById("detras_de_escenas").checked = true;
            })
            .catch(error => console.error('Error al obtener los datos:', error));
    }

    fetchData(); 
});

const form = document.getElementById("editform");
form.addEventListener("submit", function(event) {
    event.preventDefault();
    const id = parseInt(document.getElementById("id").value);
    const title = document.getElementById("titulo").value;
    const description = document.getElementById("descripcion").value;
    const releaseYear = parseInt(document.getElementById("anio_lanzamiento").value);
    let languageId = parseInt(document.getElementById("Idlenguaje").value);
    const originalLanguageId = 2; 
    const rentalDuration = parseInt(document.getElementById("duracion_renta").value);
    const rentalRate = document.getElementById("tasa_renta").value;
    const length = parseInt(document.getElementById("duracion").value);
    const replacementCost = document.getElementById("costo_reemplazo").value;
    const rating = document.getElementById("rating").value;
    const specialFeatures = Array.from(document.querySelectorAll('input[name="contenido_especial"]:checked')).map(checkbox => checkbox.value).join(',');
    
    if(isNaN(languageId)){
        languageId= 1;
    }

    console.log(languageId);
    const filmData = {
        film_id: id,
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
        
    };
    console.log(filmData);

    

    fetch("http://localhost:8080", { 
        method: "PUT",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(filmData)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Error en la solicitud.");
        }
        return response.json();
    })
    .then(data => {
        console.log('Éxito:', data);
        alert("Se ha insertado correctamente la película");
    })
    .catch(error => {
        console.error('Error:', error);
        alert("Ha ocurrido un error al intentar insertar la película.");
    });
});
