DROP TABLE IF EXISTS component_telephone;
DROP TABLE IF EXISTS components;
DROP TABLE IF EXISTS employee_types;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS components;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS telephone_order;
DROP TABLE IF EXISTS telephones;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS employee_telephone;

CREATE TABLE component_telephone (
    id_telephone INTEGER NOT NULL,
    id_component INTEGER NOT NULL,
    piece_count  INTEGER NOT NULL, 
    FOREIGN KEY (id_telephone) REFERENCES telephones (id_telephone),
    FOREIGN KEY (id_component) REFERENCES components (id_component)
);

CREATE TABLE components (
    id_component     INTEGER PRIMARY KEY AUTOINCREMENT,
    name             TEXt NOT NULL,
    price            REAL NOT NULL,
    pieces_available INTEGER NOT NULL
);


CREATE TABLE employee_types (
    id_employee_type     INTEGER PRIMARY KEY AUTOINCREMENT,
    role                 TEXT NOT NULL,
    administrator_rights BOOLEAN NOT NULL CHECK (administrator_rights IN (0, 1))
);


CREATE TABLE employees (
    id_employee          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_user          INTEGER NOT NULL,
    hourly_wage      REAL NOT NULL,
    employee_type_id INTEGER NOT NULL,
    FOREIGN KEY (employee_type_id) REFERENCES employee_types (id_employee_type),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);


CREATE TABLE orders (
    id_order INTEGER PRIMARY KEY AUTOINCREMENT,
    id_user  INTEGER NOT NULL,
    processed BOOLEAN NOT NULL CHECK (processed IN (0, 1)),
    FOREIGN KEY (id_user) REFERENCES users (id_user)
);


CREATE TABLE telephone_order (
    id_order     INTEGER NOT NULL,
    id_telephone INTEGER NOT NULL,
    piece_count  INTEGER NOT NULL,
    FOREIGN KEY (id_order) REFERENCES orders (id_order),
    FOREIGN KEY (id_telephone) REFERENCES telephones (id_telephone)
);

CREATE TABLE telephones (
    id_telephone INTEGER PRIMARY KEY AUTOINCREMENT,
    model        TEXT NOT NULL,
    workload     REAL NOT NULL,
    price_constant  REAL NOT NULL
);


CREATE TABLE users (
    id_user      INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name   TEXT NOT NULL,
    last_name    TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    email        TEXT NOT NULL,
    password     TEXT NOT NULL,
    registration_completed      BOOLEAN NOT NULL CHECK (registration_completed IN (0, 1)),
    blocked      BOOLEAN NOT NULL CHECK (blocked IN (0, 1)),
    UNIQUE (email)
);


CREATE TABLE employee_telephone(
    serial_number   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_employee     INTEGER NOT NULL,
    id_telephone    INTEGER NOT NULL,
    hours_spent     REAL NOT NULL,
    

    FOREIGN KEY (id_employee) REFERENCES employees (id_employee),
    FOREIGN KEY (id_telephone) REFERENCES telephones (id_telephone)
);

--- Mock data

--- Inserting users (all the users have password "password"
INSERT INTO users (first_name, last_name, phone_number, email, password, registration_completed, blocked) VALUES
            ("Zakaznik1", "Nas", "545123122", "ahoj@mail.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 0, 0),
            ("Zakaznik2", "Vaa", "523123122", "ahoj2@mail.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 1, 1),
            ("Zamestnanec1", "Nasw", "545123232", "zamestnanec1@firma.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 1, 0),
            ("Zamestnanec2", "Vaas", "787723232", "zamestnanec2@firma.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 1, 0),
            ("Admin1", "Nasa", "515123122", "admin1@firma.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 1, 0),
            ("CEO", "Vaad", "545123132", "CEO@firma.com", "55863a2db485cd281fa934bfff935bb3f689dd8775d3b9f3df95456867c02966", 1, 0);

--- Inserting employee types
INSERT INTO employee_types (role, administrator_rights) VALUES
            ("Assembler", 0),
            ("Warehouse worker", 0),
            ("Admin", 1),
            ("CEO", 1);

--- Inserting employees
INSERT INTO employees (id_user, hourly_wage, employee_type_id) VALUES
            (3, 140.3, 1),
            (4, 180.3, 2),
            (5, 200.6, 3),
            (6, 1000.45, 4);

--- Inserting components
INSERT INTO components (name, price, pieces_available) VALUES
            ("Antenna", 123, 100),
            ("Battery", 31, 100),
            ("CPU", 500, 100),
            ("RAM", 400, 100),
            ("ROM", 23, 100),
            ("Visual Display", 590, 100),
            ("Audio IC", 123, 100),
            ("LED", 122, 100),
            ("Microphone", 46, 120),
            ("SIM card Socket", 19, 100);

--- Inserting telephones
INSERT INTO telephones (model, workload, price_constant) VALUES
            ("iPhone 14 Pro", 40, 312),
            ("Samsung Galaxy Z flip", 12, 230),
            ("Xiaomi nevim", 31, 100),
            ("Nokia 380", 300, 99),
            ("iPhone 5s", 30, 120),
            ("Magnesia", 3, 123),
            ("Alcatel", 400, 190);

--- Inserting orders
INSERT INTO orders (id_user, processed) VALUES
            (1, 0),
            (1, 1),
            (1, 0),
            (2, 1),
            (2, 0),
            (2, 1),
            (2, 0);

--- Inserting telephone_order
INSERT INTO telephone_order (id_order, id_telephone, piece_count) VALUES
            (1, 1, 3),
            (6, 2, 3),
            (7, 4, 4),
            (2, 3, 4),
            (3, 4, 5),
            (4, 5, 4),
            (5, 2, 6),
            (1, 1, 7),
            (6, 3, 6),
            (7, 2, 4),
            (2, 4, 23),
            (3, 1, 3),
            (4, 2, 4),
            (5, 1, 4);

--- Inserting component_telephone
INSERT INTO component_telephone (id_telephone, id_component, piece_count) VALUES
            (1, 2, 1),
            (1, 1, 1),
            (1, 3, 1),
            (2, 4, 1),
            (2, 1, 1),
            (3, 1, 2),
            (3, 5, 1),
            (4, 1, 1),
            (4, 8, 1),
            (5, 5, 1),
            (6, 4, 1),
            (5, 3, 1),
            (6, 3, 1),
            (7, 4, 1),
            (7, 3, 2),
            (7, 1, 2),
            (7, 2, 3);

--- Inserting employee_telephone
INSERT INTO employee_telephone (id_employee, id_telephone, hours_spent) VALUES
            (2 , 1, 10.0),
            (1 , 1, 10.0),
            (1 , 1, 10.0),
            (2 , 1, 10.0),
            (2 , 2, 2.0),
            (2 , 2, 10.0),
            (1 , 2, 10.0),
            (1 , 3, 8.0),
            (1 , 3, 10.0),
            (1 , 3, 10.0),
            (2 , 3, 10.0),
            (2 , 3, 10.0),
            (1 , 4, 10.0),
            (1 , 4, 10.0),
            (2 , 4, 10.0),
            (2 , 4, 10.0),
            (1 , 4, 10.0),
            (1 , 5, 10.0),
            (2 , 5, 10.0),
            (1 , 5, 10.0);
--- Mock end