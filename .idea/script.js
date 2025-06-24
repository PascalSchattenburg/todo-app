document.addEventListener("DOMContentLoaded", () => {
    const todoList = document.getElementById("todo-list");
    const todoForm = document.getElementById("todo-form");
    const todoInput = document.getElementById("todo-input");
    const todoOwner = document.getElementById("todo-owner");

    // Lade ToDos aus todos.json
    fetch("todos.json")
        .then((response) => response.json())
        .then((todos) => {
            renderTodos(todos);
        })
        .catch((error) => {
            console.error("Fehler beim Laden der todos.json:", error);
        });

    function renderTodos(todos) {
        todoList.innerHTML = "";
        todos.forEach((todo) => {
            const li = document.createElement("li");
            li.textContent = `${todo.owner}: ${todo.text}`;
            if (todo.done) {
                li.style.textDecoration = "line-through";
            }
            todoList.appendChild(li);
        });
    }

    // Neues ToDo hinzufügen (nur lokal sichtbar)
    todoForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const newTodo = {
            owner: todoOwner.value,
            text: todoInput.value,
            done: false,
        };

        alert("Neue Aufgabe hinzugefügt – bitte manuell in todos.json eintragen und committen.");

        todoInput.value = "";
    });
});