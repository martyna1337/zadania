-- MySQL Script generated by MySQL Workbench
-- Tue Dec 22 22:42:32 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema klub_sportowy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema klub_sportowy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `klub_sportowy` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `klub_sportowy` ;

-- -----------------------------------------------------
-- Table `klub_sportowy`.`diety`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`diety` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `max_kcal` INT NOT NULL,
  `potrawy` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`kontuzje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`kontuzje` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(150) NOT NULL,
  `opis` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`zawodnicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`zawodnicy` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `imię` VARCHAR(25) NOT NULL,
  `nazwisko` VARCHAR(25) NOT NULL,
  `data_urodzenia` DATE NULL,
  `miejsce_urodzenia` VARCHAR(45) CHARACTER SET 'armscii8' NULL,
  `PESEL` VARCHAR(11) NOT NULL,
  `diety_ID` INT NOT NULL,
  `kontuzje_ID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_zawodnicy_diety1_idx` (`diety_ID` ASC) VISIBLE,
  UNIQUE INDEX `PESEL_UNIQUE` (`PESEL` ASC) VISIBLE,
  INDEX `fk_zawodnicy_kontuzje1_idx` (`kontuzje_ID` ASC) VISIBLE,
  CONSTRAINT `fk_zawodnicy_diety1`
    FOREIGN KEY (`diety_ID`)
    REFERENCES `klub_sportowy`.`diety` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zawodnicy_kontuzje1`
    FOREIGN KEY (`kontuzje_ID`)
    REFERENCES `klub_sportowy`.`kontuzje` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`sezony`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`sezony` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `data_rozpoczecia` DATE NOT NULL,
  `data_zakonczenia` DATE NOT NULL,
  `najlepszy_wynik` TIME NOT NULL,
  `zawodnicy_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_seony_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_seony_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`kategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`kategorie` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(45) NOT NULL,
  `dlugosc_trasy` INT NOT NULL,
  `opis_trasy` TEXT NULL,
  `zawodnicy_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_kategorie_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_kategorie_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`historia_sezonow_zawodnika`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`historia_sezonow_zawodnika` (
  `ID` INT NOT NULL,
  `sezony_ID` INT NOT NULL,
  `zawodnicy_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_historia_sezonow_zawodnika_sezony1_idx` (`sezony_ID` ASC) VISIBLE,
  INDEX `fk_historia_sezonow_zawodnika_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_historia_sezonow_zawodnika_sezony1`
    FOREIGN KEY (`sezony_ID`)
    REFERENCES `klub_sportowy`.`sezony` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historia_sezonow_zawodnika_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`sztab_szkoleniowy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`sztab_szkoleniowy` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(25) NOT NULL,
  `nazwisko` VARCHAR(25) NOT NULL,
  `funkcja` ENUM("trener", "lekarz", "fizjoterapeuta", "kucharz", "dietetyk") NOT NULL,
  `zakres_cwiczen` TEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`sponsorzy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`sponsorzy` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `nazwa_firmy` VARCHAR(100) NOT NULL,
  `rodzaj_firmy` VARCHAR(100) NULL,
  `rodzaj_współpracy` VARCHAR(200) NULL,
  `budżet` DECIMAL(10,2) NOT NULL,
  `zawodnicy_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_sponsorzy_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_sponsorzy_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`sztab_szkoleniowy_has_zawodnicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`sztab_szkoleniowy_has_zawodnicy` (
  `sztab_szkoleniowy_ID` INT NOT NULL,
  `zawodnicy_ID` INT NOT NULL,
  PRIMARY KEY (`sztab_szkoleniowy_ID`, `zawodnicy_ID`),
  INDEX `fk_sztab_szkoleniowy_has_zawodnicy_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  INDEX `fk_sztab_szkoleniowy_has_zawodnicy_sztab_szkoleniowy1_idx` (`sztab_szkoleniowy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_sztab_szkoleniowy_has_zawodnicy_sztab_szkoleniowy1`
    FOREIGN KEY (`sztab_szkoleniowy_ID`)
    REFERENCES `klub_sportowy`.`sztab_szkoleniowy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sztab_szkoleniowy_has_zawodnicy_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `klub_sportowy`.`historie_kontuzji`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `klub_sportowy`.`historie_kontuzji` (
  `zawodnicy_ID` INT NOT NULL,
  `kontuzje_ID` INT NOT NULL,
  PRIMARY KEY (`zawodnicy_ID`, `kontuzje_ID`),
  INDEX `fk_zawodnicy_has_kontuzje_kontuzje1_idx` (`kontuzje_ID` ASC) VISIBLE,
  INDEX `fk_zawodnicy_has_kontuzje_zawodnicy1_idx` (`zawodnicy_ID` ASC) VISIBLE,
  CONSTRAINT `fk_zawodnicy_has_kontuzje_zawodnicy1`
    FOREIGN KEY (`zawodnicy_ID`)
    REFERENCES `klub_sportowy`.`zawodnicy` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_zawodnicy_has_kontuzje_kontuzje1`
    FOREIGN KEY (`kontuzje_ID`)
    REFERENCES `klub_sportowy`.`kontuzje` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`diety`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (1, 'wysokobiałkowa', 2000, 'mięso z ryżem');
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (2, 'bezglutenowa', 1800, 'pieczony dorsz');
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (3, 'wegetariańska', 1900, 'naleśniki');
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (4, 'wegańska', 1500, 'sałatka');
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (5, 'lekkostrawna', 2200, 'mus dyniowy z tymiankiem');
INSERT INTO `klub_sportowy`.`diety` (`ID`, `nazwa`, `max_kcal`, `potrawy`) VALUES (6, 'podstawowa', 2400, 'pierogi');

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`kontuzje`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (1, 'skręcenie ', '');
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (2, 'zwichnięcie', '');
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (3, 'stłuczenie', NULL);
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (4, 'złamanie', NULL);
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (5, 'przeciążenie', NULL);
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (6, 'zapalenie', NULL);
INSERT INTO `klub_sportowy`.`kontuzje` (`ID`, `nazwa`, `opis`) VALUES (7, 'nadwyrężenie', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`zawodnicy`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (1, 'Paweł', 'Lewandowski', '1996-09-06', 'Gniezno/Polska', '960609657', 1, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (2, 'Nicola', 'Kłek', '2000-01-03', 'Iława/Polska', '001034768', 2, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (3, 'Stanisław', 'Balonik', '1995-02-05', 'Warszawa/Polska', '950205365', 3, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (4, 'Karolina', 'Wiśniewska', '1997-03-08', 'Gdańsk/Polska', '970308123', 4, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (5, 'Julia', 'Kerber', '2000-01-15', 'Berlin/Niemcy', '001159647', 3, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (6, 'Bratalian', 'Julian', '1999-02-18', 'Praga/Czechy', '990218236', 2, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (7, 'Lilianna', 'Belu', '1998-04-20', 'Praga/Czechy', '980420131', 6, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (8, 'Aleksandra ', 'Liwio', '1996-07-04', 'Kwidzyn/Polska', '960704256', 4, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (9, 'Marta', 'Gorczyca', '1995-03-14', 'Poznan/Polska', '950314711', 1, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (10, 'Elke', 'Biely', '1999-08-11', 'Hannover/Niemcy', '990811954', 6, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (11, 'Petra', 'Smith', '1997-11-23', 'Kassel/Niemcy', '971123715', 7, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (12, 'Filip', 'Wojtacki', '2000-07-12', 'Lublin/Polska', '007124408', 7, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (13, 'Ivan', 'Siggi', '1998-12-12', 'Koszyce/Słowacja', '981212832', 2, NULL);
INSERT INTO `klub_sportowy`.`zawodnicy` (`ID`, `imię`, `nazwisko`, `data_urodzenia`, `miejsce_urodzenia`, `PESEL`, `diety_ID`, `kontuzje_ID`) VALUES (14, 'Damek', 'Berthold', '1996-10-12', 'Poprad/Słowacja', '961012114', 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`sezony`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (1, '2012-07-01', '2012-08-31', '00:08:20', 4);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (2, '2013-07-01', '2013-08-31', '01:20:34', 7);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (3, '2014-07-01', '2014-08-31', '00:03:40', 6);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (4, '2015-07-01', '2015-08-31', '01:42:18', 9);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (5, '2016-07-01', '2016-09-30', '00:09:02', 13);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (6, '2017-07-01', '2017-09-30', '02:23:14', 8);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (7, '2018-06-01', '2018-09-30', '01:36:52', 11);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (8, '2019-06-01', '2019-09-30', '00:32:07', 14);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (9, '2020-06-01', '2020-09-30', '02:16:33', 2);
INSERT INTO `klub_sportowy`.`sezony` (`ID`, `data_rozpoczecia`, `data_zakonczenia`, `najlepszy_wynik`, `zawodnicy_ID`) VALUES (DEFAULT, DEFAULT, DEFAULT, '', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`kategorie`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (1, 'bieg na 100m', 100, NULL, 2);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (2, 'beig na 100m z przeszkodami', 100, NULL, 10);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (3, 'bieg na 400m', 400, NULL, 5);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (4, 'bieg na 400m z przeszkodami', 400, NULL, 7);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (5, 'bieg na 800m', 800, NULL, 3);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (6, 'bieg na 1500m', 1500, NULL, 14);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (7, 'bieg na 3000m', 3000, NULL, 1);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (8, 'bieg na 3000m z przeszkodami', 3000, NULL, 8);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (9, 'bieg na 10000m', 10000, NULL, 12);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (10, 'półmaraton', 21000, NULL, 6);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (11, 'maraton', 42000, NULL, 11);
INSERT INTO `klub_sportowy`.`kategorie` (`ID`, `nazwa`, `dlugosc_trasy`, `opis_trasy`, `zawodnicy_ID`) VALUES (, DEFAULT, DEFAULT, NULL, );

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`historia_sezonow_zawodnika`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`historia_sezonow_zawodnika` (`ID`, `sezony_ID`, `zawodnicy_ID`) VALUES (DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `klub_sportowy`.`historia_sezonow_zawodnika` (`ID`, `sezony_ID`, `zawodnicy_ID`) VALUES (DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `klub_sportowy`.`historia_sezonow_zawodnika` (`ID`, `sezony_ID`, `zawodnicy_ID`) VALUES (DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`sztab_szkoleniowy`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`sztab_szkoleniowy` (`ID`, `imie`, `nazwisko`, `funkcja`, `zakres_cwiczen`) VALUES (1, 'Dariusz', 'Domeg', 'trener', NULL);
INSERT INTO `klub_sportowy`.`sztab_szkoleniowy` (`ID`, `imie`, `nazwisko`, `funkcja`, `zakres_cwiczen`) VALUES (2, 'Magdalena', 'Kote', 'trener', NULL);
INSERT INTO `klub_sportowy`.`sztab_szkoleniowy` (`ID`, `imie`, `nazwisko`, `funkcja`, `zakres_cwiczen`) VALUES (3, 'Wojtek', 'Karwski', 'lekarz', NULL);
INSERT INTO `klub_sportowy`.`sztab_szkoleniowy` (`ID`, `imie`, `nazwisko`, `funkcja`, `zakres_cwiczen`) VALUES (4, 'Piotr', 'Lewtor', 'fizjoterapeuta', NULL);
INSERT INTO `klub_sportowy`.`sztab_szkoleniowy` (`ID`, `imie`, `nazwisko`, `funkcja`, `zakres_cwiczen`) VALUES (5, 'Anna', 'Sokola', 'kucharz', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `klub_sportowy`.`sponsorzy`
-- -----------------------------------------------------
START TRANSACTION;
USE `klub_sportowy`;
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (1, 'Nike', NULL, NULL, 300000, 7);
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (2, 'Runplanet', NULL, NULL, 400000, 11);
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (3, 'Worldrun', NULL, NULL, 450000, 9);
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (4, 'Isoplus', NULL, NULL, 250000, 2);
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (5, 'Timeapp', NULL, NULL, 300000, 5);
INSERT INTO `klub_sportowy`.`sponsorzy` (`ID`, `nazwa_firmy`, `rodzaj_firmy`, `rodzaj_współpracy`, `budżet`, `zawodnicy_ID`) VALUES (6, 'Kinder', NULL, NULL, 150000, 13);

COMMIT;

-- -----------------------------------------------------
-- wyzwalacze procedura funkcja

DELIMITER $$
CREATE FUNCTION liczba_zawodnikow()
RETURNS INT
BEGIN
DECLARE liczba_zawodnikow INT;
SELECT COUNT(*) INTO @liczba_zawodnikow FROM zawodnicy;
RETURN @liczba_zawodnikow;
END $$ 
DELIMITER ;

 

DELIMITER $$
CREATE TRIGGER uzupelniacz BEFORE INSERT ON sponsorzy 
FOR EACH ROW
BEGIN 
IF new.rodzaj_firmy IS NULL
THEN
SET new.rodzaj_firmy="informacja niedostepna";
END IF;
IF new.rodzaj_współpracy IS NULL
THEN
SET new.rodzaj_współpracy="tymczasowo nieokreślona";
END IF;
END $$
DELIMITER ;

 

DELIMITER $$
CREATE TRIGGER incydent AFTER UPDATE ON zawodnicy
FOR EACH ROW
BEGIN 
IF new.kontuzje_ID IS NOT NULL 
THEN
INSERT INTO historia_kontuzji VALUES(old.ID,new.kontuzje_ID);
END IF;
END$$
DELIMITER ;

 

DELIMITER $$
CREATE PROCEDURE zmiana_wyniku(IN id int, nowy_wynik time) 
BEGIN 
UPDATE sezony SET najlepszy_wynik=nowy_wynik WHERE zawodnicy_ID=id;
END $$
DELIMITER ;
-- -----------------------------------------------------