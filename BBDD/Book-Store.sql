-- 1. Crear la base de datos


-- Crear la base de datos llamada OnlineBookstore
CREATE DATABASE OnlineBookstore;
-- 2. Usar la base de datos

-- Seleccionar la base de datos OnlineBookstore para su uso
USE OnlineBookstore;

-- 3. Crear tablas
-- Vamos a crear las siguientes tablas: users, authors, books, genres, book_genres, orders, order_items, reviews, addresses.


-- Tabla de usuarios (users):

-- Crear la tabla users para almacenar la información de los usuarios
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada usuario
    username VARCHAR(50) NOT NULL UNIQUE, -- Nombre de usuario, debe ser único
    password VARCHAR(255) NOT NULL, -- Contraseña del usuario, se recomienda almacenar hashes de las contraseñas
    email VARCHAR(100) NOT NULL UNIQUE, -- Correo electrónico del usuario, debe ser único
    first_name VARCHAR(100), -- Nombre del usuario
    last_name VARCHAR(100), -- Apellido del usuario
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha y hora de creación del usuario
);

-- Tabla de autores (authors):

-- Crear la tabla authors para almacenar la información de los autores
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada autor
    name VARCHAR(100) NOT NULL, -- Nombre del autor
    biography TEXT, -- Biografía del autor
    birthdate DATE, -- Fecha de nacimiento del autor
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha y hora de creación del autor
);

--Tabla de libros (books):

-- Crear la tabla books para almacenar la información de los libros
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada libro
    title VARCHAR(255) NOT NULL, -- Título del libro
    description TEXT, -- Descripción del libro
    publication_year YEAR, -- Año de publicación del libro
    price DECIMAL(10, 2) NOT NULL, -- Precio del libro
    stock INT NOT NULL, -- Cantidad en stock del libro
    author_id INT, -- Identificador del autor del libro
    FOREIGN KEY (author_id) REFERENCES authors(author_id) -- Llave foránea que referencia a la tabla authors
);

--Tabla de géneros (genres):

-- Crear la tabla genres para almacenar los diferentes géneros de libros
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada género
    genre_name VARCHAR(50) NOT NULL -- Nombre del género
);

--Tabla intermedia de géneros de libros (book_genres):

-- Crear la tabla intermedia book_genres para la relación muchos a muchos entre books y genres
CREATE TABLE book_genres (
    book_id INT, -- Identificador del libro
    genre_id INT, -- Identificador del género
    PRIMARY KEY (book_id, genre_id), -- Llave primaria compuesta de book_id y genre_id
    FOREIGN KEY (book_id) REFERENCES books(book_id), -- Llave foránea que referencia a la tabla books
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) -- Llave foránea que referencia a la tabla genres
);

--Tabla de pedidos (orders):

-- Crear la tabla orders para almacenar la información de los pedidos
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada pedido
    user_id INT, -- Identificador del usuario que realizó el pedido
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de realización del pedido
    total DECIMAL(10, 2) NOT NULL, -- Total del pedido
    status VARCHAR(50) NOT NULL, -- Estado del pedido (ej. 'Pending', 'Shipped', 'Delivered')
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Llave foránea que referencia a la tabla users
);

-- Tabla de artículos de pedido (order_items):

-- Crear la tabla order_items para almacenar los artículos de cada pedido
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada artículo de pedido
    order_id INT, -- Identificador del pedido
    book_id INT, -- Identificador del libro
    quantity INT NOT NULL, -- Cantidad del libro en el pedido
    price DECIMAL(10, 2) NOT NULL, -- Precio del libro en el pedido
    FOREIGN KEY (order_id) REFERENCES orders(order_id), -- Llave foránea que referencia a la tabla orders
    FOREIGN KEY (book_id) REFERENCES books(book_id) -- Llave foránea que referencia a la tabla books
);

--Tabla de reseñas (reviews):

-- Crear la tabla reviews para almacenar las reseñas de los libros
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada reseña
    book_id INT, -- Identificador del libro
    user_id INT, -- Identificador del usuario que realizó la reseña
    rating INT CHECK (rating BETWEEN 1 AND 5), -- Calificación del libro (1 a 5)
    comment TEXT, -- Comentario de la reseña
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Fecha y hora de la reseña
    FOREIGN KEY (book_id) REFERENCES books(book_id), -- Llave foránea que referencia a la tabla books
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Llave foránea que referencia a la tabla users
);

--Tabla de direcciones (addresses):

-- Crear la tabla addresses para almacenar las direcciones de los usuarios
CREATE TABLE addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y autoincremental para cada dirección
    user_id INT, -- Identificador del usuario
    street VARCHAR(255) NOT NULL, -- Calle de la dirección
    city VARCHAR(100) NOT NULL, -- Ciudad de la dirección
    state VARCHAR(100) NOT NULL, -- Estado o provincia de la dirección
    postal_code VARCHAR(20) NOT NULL, -- Código postal de la dirección
    country VARCHAR(100) NOT NULL, -- País de la dirección
    FOREIGN KEY (user_id) REFERENCES users(user_id) -- Llave foránea que referencia a la tabla users
);

--4. Alterar una tabla
--Vamos a modificar la tabla books para agregar una nueva columna isbn.

-- Alterar la tabla books para añadir una columna isbn

ALTER TABLE books ADD COLUMN isbn VARCHAR(20); -- Número ISBN del libro, hasta 20 caracteres

--5. Relaciones entre tablas
--Las relaciones ya están definidas en las instrucciones anteriores con las claves foráneas (FOREIGN KEY).

--6. Contenido de las tablas
--Vamos a insertar algunos registros de ejemplo en cada tabla.

--Tabla de usuarios (users):

-- Insertar registros en la tabla users
INSERT INTO users (username, password, email, first_name, last_name) VALUES 
('user1', 'password1', 'user1@example.com', 'John', 'Doe'),
('user2', 'password2', 'user2@example.com', 'Jane', 'Doe');

--Tabla de autores (authors):

-- Insertar registros en la tabla authors
INSERT INTO authors (name, biography, birthdate) VALUES 
('Author One', 'Biography of Author One', '1970-01-01'),
('Author Two', 'Biography of Author Two', '1980-02-02');

--Tabla de libros (books):
-- Insertar registros en la tabla books
INSERT INTO books (title, description, publication_year, price, stock, author_id, isbn) VALUES 
('Book One', 'Description of Book One', 2001, 19.99, 10, 1, '1234567890123'),
('Book Two', 'Description of Book Two', 2002, 29.99, 5, 2, '1234567890124');

--Tabla de géneros (genres):
-- Insertar registros en la tabla genres
INSERT INTO genres (genre_name) VALUES 
('Fiction'), 
('Non-Fiction');

--Tabla intermedia de géneros de libros (book_genres):
-- Insertar registros en la tabla intermedia book_genres
INSERT INTO book_genres (book_id, genre_id) VALUES 
(1, 1),
(2, 2);

--Tabla de pedidos (orders):
-- Insertar registros en la tabla orders
INSERT INTO orders (user_id, total, status) VALUES 
(1, 49.98, 'Pending'),
(2, 29.99, 'Shipped');

--Tabla de artículos de pedido (order_items):
-- Insertar registros en la tabla order_items
INSERT INTO order_items (order_id, book_id, quantity, price) VALUES 
(1, 1, 2, 19.99),
(2, 2, 1, 29.99);

--Tabla de reseñas (reviews):
-- Insertar registros en la tabla reviews
INSERT INTO reviews (book_id, user_id, rating, comment) VALUES 
(1, 1, 5, 'Great book!'),
(2, 2, 4, 'Interesting read.');

--Tabla de direcciones (addresses):
-- Insertar registros en la tabla addresses
INSERT INTO addresses (user_id, street, city, state, postal_code, country) VALUES 
(1, '123 Main St', 'Anytown', 'Anystate', '12345', 'USA'),
(2, '456 Elm St', 'Othertown', 'Otherstate', '67890', 'USA');


--7. Búsquedas simples y complejas
--Realicemos algunas consultas para obtener datos de las tablas.

--Búsquedas simples:

-- Seleccionar todos los libros
SELECT * FROM books;

-- Seleccionar libros por un autor específico
SELECT * FROM books WHERE author_id = 1;

-- Ordenar los libros por precio
SELECT * FROM books ORDER BY price;

-- Limitar los resultados a 5 libros
SELECT * FROM books LIMIT 5;

-- Buscar usuarios por correo electrónico
SELECT * FROM users WHERE email LIKE '%example.com';

-- Seleccionar libros con precio entre 10 y 30
SELECT * FROM books WHERE price BETWEEN 10 AND 30;

-- Buscar autores por nombre
SELECT * FROM authors WHERE name LIKE 'Author%';

-- Seleccionar pedidos pendientes
SELECT * FROM orders WHERE status = 'Pending';

-- Contar el número de libros en stock
SELECT COUNT(*) FROM books WHERE stock > 0;



--Búsquedas complejas:

-- Subconsulta para encontrar libros de autores cuyo nombre empieza con 'Author'
SELECT * FROM books WHERE author_id IN (SELECT author_id FROM authors WHERE name LIKE 'Author%');

-- JOIN para obtener los títulos de los libros y los nombres de los autores
SELECT b.title, a.name 
FROM books b 
JOIN authors a ON b.author_id = a.author_id;

-- Calcular el precio medio de los libros
SELECT AVG(price) FROM books;

-- Agrupar libros por autor y contar cuántos libros tiene cada autor
SELECT author_id, COUNT(*) 
FROM books 
GROUP BY author_id;

-- Filtrar autores que tengan más de un libro
SELECT author_id, COUNT(*) 
FROM books 
GROUP BY author_id 
HAVING COUNT(*) > 1;

-- Combinar JOINs y subconsultas para contar los pedidos realizados por usuarios que hayan comprado libros después del año 2000

SELECT u.username, COUNT(o.order_id) 
FROM users u 
JOIN orders o ON u.user_id = o.user_id 
WHERE o.order_id IN (SELECT oi.order_id FROM order_items oi JOIN books b ON oi.book_id = b.book_id WHERE b.publication_year > 2000)
GROUP BY u.username;

-- 8. Triggers
-- Vamos a crear dos triggers para realizar acciones automáticas en la base de datos.

-- Trigger para validar el stock al actualizar la tabla books:
-- Crear un trigger que valide que el stock no sea negativo al actualizar la tabla books
CREATE TRIGGER validate_stock_update
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    IF NEW.stock < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock cannot be negative';
    END IF;
END;

-- Trigger para registrar un mensaje de log cada vez que se inserte un nuevo pedido:
-- Crear una tabla para almacenar los logs de los pedidos
CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear un trigger que registre un mensaje de log cada vez que se inserte un nuevo pedido
CREATE TRIGGER log_new_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_logs (order_id, log_message) VALUES (NEW.order_id, 'New order created');
END;

-- 9. Transacciones
-- Vamos a implementar una transacción que incluya varias operaciones de manipulación de datos.

-- Iniciar una transacción
START TRANSACTION;

-- Actualizar el stock de un libro
UPDATE books SET stock = stock - 1 WHERE book_id = 1;

-- Insertar un nuevo pedido
INSERT INTO orders (user_id, total, status) VALUES (1, 19.99, 'Pending');

-- Insertar un nuevo artículo de pedido
INSERT INTO order_items (order_id, book_id, quantity, price) VALUES (LAST_INSERT_ID(), 1, 1, 19.99);

-- Confirmar la transacción
COMMIT;

--10. Funciones definidas por el usuario
--Vamos a crear tres funciones y utilizarlas en las operaciones de la base de datos.

--Función para obtener el número de libros por autor:
CREATE FUNCTION get_book_count_by_author(authorId INT) RETURNS INT
BEGIN
    DECLARE book_count INT;
    SELECT COUNT(*) INTO book_count FROM books WHERE author_id = authorId;
    RETURN book_count;
END;

-- Función para obtener el número de pedidos por usuario:
CREATE FUNCTION get_order_count_by_user(userId INT) RETURNS INT
BEGIN
    DECLARE order_count INT;
    SELECT COUNT(*) INTO order_count FROM orders WHERE user_id = userId;
    RETURN order_count;
END;

-- Función para obtener el total de ingresos por género:
CREATE FUNCTION get_total_revenue_by_genre(genreId INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_revenue DECIMAL(10, 2);
    SELECT SUM(oi.price * oi.quantity) INTO total_revenue 
    FROM order_items oi 
    JOIN books b ON oi.book_id = b.book_id 
    JOIN book_genres bg ON b.book_id = bg.book_id 
    WHERE bg.genre_id = genreId;
    RETURN total_revenue;
END;