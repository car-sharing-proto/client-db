DROP TABLE IF EXISTS Client;

CREATE TABLE Client (
    id INTEGER,
    phone_number TEXT CHECK (
        phone_number REGEXP
        '^8\d{10}$'),
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