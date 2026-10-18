PRAGMA foreign_keys = ON;

-- Personas que pueden llevarse libros prestados
CREATE TABLE IF NOT EXISTS Lectores (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Codigo TEXT NOT NULL UNIQUE,
    Nombre TEXT NOT NULL,
    Correo TEXT NOT NULL UNIQUE,
    Telefono TEXT NOT NULL
);

-- Catalogo de libros; Ejemplares es la cantidad total de copias fisicas
CREATE TABLE IF NOT EXISTS Libros (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Codigo TEXT NOT NULL UNIQUE,
    Titulo TEXT NOT NULL,
    Autor TEXT NOT NULL,
    Ejemplares INTEGER NOT NULL CHECK (Ejemplares > 0)
);

-- Relacion lector-libro. FechaDevolucion NULL significa que el ejemplar sigue prestado.
CREATE TABLE IF NOT EXISTS Prestamos (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    LectorId INTEGER NOT NULL,
    LibroId INTEGER NOT NULL,
    FechaPrestamo TEXT NOT NULL,
    FechaLimite TEXT NOT NULL,
    FechaDevolucion TEXT NULL,
    CHECK (date(FechaLimite) >= date(FechaPrestamo)),
    CHECK (FechaDevolucion IS NULL OR date(FechaDevolucion) >= date(FechaPrestamo)),
    FOREIGN KEY (LectorId) REFERENCES Lectores(Id) ON DELETE CASCADE,
    FOREIGN KEY (LibroId) REFERENCES Libros(Id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS IX_Prestamos_LectorId
    ON Prestamos(LectorId);

CREATE INDEX IF NOT EXISTS IX_Prestamos_LibroId
    ON Prestamos(LibroId);
