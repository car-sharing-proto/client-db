DROP TABLE IF EXISTS BankCard;
DROP TABLE IF EXISTS VehicleCategory;
DROP TABLE IF EXISTS DrivingLicense;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Passport;
DROP TABLE IF EXISTS Client;

CREATE TABLE Client (
    id SERIAL,
    phone_number TEXT CHECK (
        phone_number ~ '^8[\d]{10}$'
    ),
    mail TEXT CHECK (
        mail LIKE '%_@__%.__%'
    ),
    accaunt_status TEXT CHECK (
        accaunt_status IN (
            'non-activated',
            'activated',
            'banned',
            'closed'
        )
    ),
    driving_style FLOAT CHECK (
        driving_style >= 0 AND
        driving_style <= 1
    ),
    rating FLOAT CHECK (
        rating >= 0 AND
        rating <= 1
    ),
    registration_date DATE NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE BankCard (
    card_number TEXT CHECK (
        card_number ~ '[\d]{16}$'
    ),
    holder_name TEXT NOT NULL,
    validity DATE NOT NULL,
    code TEXT CHECK(
        code  ~ '[\d]{3}$'
    ),
    client_id INTEGER,
    
    PRIMARY KEY (card_number),
    FOREIGN KEY (client_id) REFERENCES Client (id) 
);

CREATE TABLE DrivingLicense (
    series_number TEXT CHECK (
        series_number ~ '[\d]{10}$'
    ),
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    patronymic TEXT NOT NULL,
    birth_date DATE NOT NULL,
    birth_place TEXT NOT NULL,
    issue_date DATE NOT NULL,
    valid_unitil DATE NOT NULL,
    region TEXT NOT NULL,
    issued_by TEXT NOT NULL,
    automatic_transmission BOOLEAN, 
    driving_expirience TEXT CHECK (
        driving_expirience ~ '[\d]{4}$'
    ),
    photo_link TEXT NOT NULL,
    client_id INTEGER,

    PRIMARY KEY (series_number),
    FOREIGN KEY (client_id) REFERENCES Client (id) 
);

CREATE TABLE VehicleCategory (
    designation TEXT CHECK (
        designation IN (
            'B',
            'C'
        )
    ),
    driving_license_series_number TEXT,

    PRIMARY KEY (designation, driving_license_series_number),
    FOREIGN KEY (driving_license_series_number) 
        REFERENCES DrivingLicense (series_number)
);

CREATE TABLE Passport (
    series_number TEXT CHECK (
        series_number ~ '[\d]{10}$'
    ),
    issue_date DATE NOT NULL,
    issued_by TEXT NOT NULL,
    unit_code TEXT CHECK (
        unit_code ~ '[\d]{6}$'
    ),
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    patronymic TEXT NOT NULL,
    birth_date DATE NOT NULL,
    birth_place TEXT NOT NULL,
    photo_link TEXT NOT NULL,
    client_id INTEGER,

    PRIMARY KEY (series_number),
    FOREIGN KEY (client_id) REFERENCES Client (id) 
);

CREATE TABLE Registration (
    id SERIAL,
    passport_series_number TEXT,
    registration_date DATE NOT NULL,
    region TEXT NOT NULL,
    locality TEXT NOT NULL, 
    street TEXT NOT NULL,
    building TEXT NOT NULL,
    unit_code TEXT NOT NULL,
    unit_name TEXT NOT NULL,
    photo_link TEXT NOT NULL,

    PRIMARY KEY (id, passport_series_number),
    FOREIGN KEY (passport_series_number) 
        REFERENCES Passport (series_number) 
);