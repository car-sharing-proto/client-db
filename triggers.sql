DROP TRIGGER IF EXISTS ValidateDrivingLicenseData;

CREATE TRIGGER ValidateDrivingLicenseData
BEFORE INSERT ON DrivingLicense
WHEN (
    SELECT EXISTS(
        SELECT * AS passport
        FROM (
            SELECT Passport 
            WHERE Passport.client_id = NEW.id
            ORDER BY Passport.issue_date DESC
            LIMIT 1
        ) 
        WHERE (
            passport.name <> NEW.name OR
            passport.surname <> NEW.surname OR
            passport.patronymic <> NEW.patronymic OR
            passport.birth_date <> NEW.birth_date
        )
    )
)
BEGIN
    SELECT RAISE(FAIL, 'The driving license data does not match the current passport data!');
END;

