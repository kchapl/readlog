-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE books (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    author TEXT NOT NULL,
    title TEXT NOT NULL,
    publication_year INT NOT NULL,
    publication_place TEXT NOT NULL,
    isbn TEXT NOT NULL,
    publisher TEXT NOT NULL,
    subtitle TEXT
);
