document.addEventListener("DOMContentLoaded", function() {
    const apiURL = "localhost:8080"; 
    const actualizarButton = document.getElementById("actualizar");

    function fetchData() {
        fetch(apiURL)
            .then(response => response.json())
            .then(data => {
                clearTable();
                insertFilmData(data);
            })
            .catch(error => console.error('Error al obtener los datos:', error));
    }

    function insertFilmData(film) {
        const table = document.querySelector("table");
        const row = document.createElement("tr");

        const fields = [
            film.film_id,
            film.title,
            film.description,
            film.release_year,
            film.rental_duration,
            film.rental_rate,
            film.length,
            film.replacement_cost,
            film.rating,
            film.special_features,
            film.last_update,
            film.language_name,
            film.category_name,
            film.actors
        ];

        fields.forEach(field => {
            const cell = document.createElement("td");
            cell.textContent = field;
            row.appendChild(cell);
        });

        table.appendChild(row);
    }

    function clearTable() {
        const table = document.querySelector("table");
        const rows = table.querySelectorAll("tr");
        rows.forEach((row, index) => {
            if (index !== 0) {
                row.remove();
            }
        });
    }

    actualizarButton.addEventListener("click", fetchData);

    fetchData();
});
