const buscar = document.getElementById("buscar");
const editar = document.getElementById("editar");


buscar.addEventListener("click", function() {
    const apiURL = "http://localhost:8080"; 
    const id = document.getElementById("id").value;
    
    

    function fetchData() {
        fetch(apiURL + '/'+id)
            .then(response => response.json())
            .then(data => {
                console.log(data)
                if (id == data.id) {
                    document.getElementById("titulo").value = data.title;
                    document.getElementById("anio_lanzamiento").value = data.release_year;
                    document.getElementById("duracion").value = data.length;
                    document.getElementById("rating").value = data.rating;
                    document.getElementById("descripcion").value = data.description;
                    
                    
                    const features = data.special_features.split(',');
                    document.getElementById("trailer").checked = features.includes("trailer");
                    document.getElementById("comentarios").checked = features.includes("comentarios");
                    document.getElementById("escenas_eliminadas").checked = features.includes("escenas_eliminadas");
                    document.getElementById("detras_de_escenas").checked = features.includes("detras_de_escenas");
                }
            })
            .catch(error => console.error('Error al obtener los datos:', error));
    }

    fetchData(); 
});
/*
editar.addEventListener("click", function() {
    const apiURL = "http://localhost:8080"; 
    const id = document.getElementById("id").value;
    const title = document.getElementById("titulo").value;
    const release_year = document.getElementById("anio_lanzamiento").value;
    const length = document.getElementById("duracion").value;
    const rating = document.getElementById("rating").value;
    const description = document.getElementById("descripcion").value;

    const special_features = [];
    if (document.getElementById("trailer").checked) special_features.push("trailer");
    if (document.getElementById("comentarios").checked) special_features.push("comentarios");
    if (document.getElementById("escenas_eliminadas").checked) special_features.push("escenas_eliminadas");
    if (document.getElementById("detras_de_escenas").checked) special_features.push("detras_de_escenas");

    const data = {
        id: id,
        title: title,
        release_year: release_year,
        length: length,
        rating: rating,
        description: description,
        special_features: special_features.join(',')
    };

    function fetchData() {
        fetch(apiURL) {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

    fetchData(); // Llamar a la función fetchData
});
*/