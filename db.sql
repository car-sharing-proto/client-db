DROP TABLE IF EXISTS BankCard;
DROP TABLE IF EXISTS Client;

CREATE TABLE Client (
    id INTEGER,
    phone_number TEXT CHECK (
        phone_number REGEXP
        '^8\d{10}$'
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
        card_number REGEXP
        '\d{16}$'
    ),
    holder_name TEXT NOT NULL,
    validity DATE NOT NULL,
    code TEXT CHECK(
        code REGEXP
        '\d{3}$'
    ),
    client_id INTEGER,
    
    PRIMARY KEY (card_number),
    FOREIGN KEY (client_id) REFERENCES Client (id) 
);