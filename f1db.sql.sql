-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2024 at 04:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `f1`
--

-- --------------------------------------------------------

--
-- Table structure for table `circuit`
--

CREATE DATABASE f1

USE f1

CREATE TABLE `circuit` (
  `Circuit_ID` varchar(3) PRIMARY KEY NOT NULL,
  `Circuit_Name` varchar(30) NOT NULL,
  `Circuit_Location` varchar(22) NOT NULL,
  `Circuit_Length` decimal(5,3) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `circuit`
--

INSERT INTO `circuit` (`Circuit_ID`, `Circuit_Name`, `Circuit_Location`, `Circuit_Length`) VALUES
('BAK', 'Baku City Circuit', 'Baku, Azerbaijan', 6.003),
('BHR', 'Bahrain International Circuit', 'Sakhir, Bahrain', 5.412),
('CAT', 'Circuit de Barcelona-Catalunya', 'Montmelo, Spain', 4.655),
('COT', 'Circuit of the Americas', 'Austin, USA', 5.513),
('HUN', 'Hungaroring', 'Mogyorod, Hungary', 4.381),
('IMO', 'Imola Circuit', 'Imola, Italy', 4.909),
('INT', 'Interlagos', 'Sao Paulo, Brazil', 4.309),
('IST', 'Istanbul Park', 'Tuzla, Turkey', 5.338),
('MCO', 'Circuit de Monaco', 'Monte Carlo, Monaco', 3.337),
('MEX', 'Autodromo Hermanos Rodriguez', 'Mexico City, Mexico', 4.304),
('MON', 'Monza Circuit', 'Monza, Italy', 5.793),
('POR', 'Algarve International Circuit', 'Portimao, Portugal', 4.653),
('RBA', 'Red Bull Ring', 'Spielberg, Austria', 4.318),
('RIC', 'Circuit Paul Ricard', 'Le Castellet, France', 5.842),
('SIL', 'Silverstone Circuit', 'Silverstone, UK', 5.891),
('SOC', 'Sochi Autodrom', 'Sochi, Russia', 5.848),
('SPA', 'Circuit de Spa-Francorchamps', 'Stavelot, Belgium', 7.004),
('YAS', 'Yas Marina Circuit', 'Abu Dhabi, UAE', 5.554),
('ZAN', 'Circuit Zandvoort', 'Zandvoort, Netherlands', 4.259);

-- --------------------------------------------------------

--
-- Table structure for table `constructor_list`
--

CREATE TABLE `constructor_list` (
  `Const_ID` varchar(3) PRIMARY KEY NOT NULL,
  `Team_Name` varchar(15) NOT NULL,
  `Base_Location` varchar(19) NOT NULL,
  `Engine_Used` varchar(8) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `constructor_list`
--

INSERT INTO `constructor_list` (`Const_ID`, `Team_Name`, `Base_Location`, `Engine_Used`) VALUES
('ALP', 'Alpine', 'Enstone, UK', 'Renault'),
('AMR', 'Aston Martin', 'Silverstone, UK', 'Mercedes'),
('ARR', 'Alfa Romeo', 'Hinwil, Switzerland', 'Ferrari'),
('ATY', 'AlphaTauri', 'Faenza, Italy', 'Honda'),
('FER', 'Ferrari', 'Maranello, Italy', 'Ferrari'),
('HAS', 'Haas', 'Kannapolis, USA', 'Ferrari'),
('MCL', 'McLaren', 'Woking, UK', 'Mercedes'),
('MER', 'Mercedes', 'Brackley, UK', 'Mercedes'),
('RBR', 'Red Bull Racing', 'Milton Keynes, UK', 'Honda'),
('WIL', 'Williams', 'Grove, UK', 'Mercedes');

-- --------------------------------------------------------

--
-- Table structure for table `const_champs`
--

CREATE TABLE `const_champs` (
  `Const_ID` varchar(3) NOT NULL PRIMARY KEY,
  `Position` int(11) NOT NULL,
  `Points` decimal(5,1) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `const_champs`
--

INSERT INTO `const_champs` (`Const_ID`, `Position`, `Points`) VALUES
('ALP', 5, 155.0),
('AMR', 7, 77.0),
('ARR', 9, 13.0),
('ATY', 6, 142.0),
('FER', 3, 323.5),
('HAS', 10, 0.0),
('MCL', 4, 275.0),
('MER', 1, 613.5),
('RBR', 2, 585.5),
('WIL', 8, 23.0);

-- --------------------------------------------------------

--
-- Table structure for table `driver_champs`
--

CREATE TABLE `driver_champs` (
  `Driver_ID` int(11) NOT NULL,
  `Position` int(11) NOT NULL,
  `Points` decimal(5,1) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_champs`
--

INSERT INTO `driver_champs` (`Driver_ID`, `Position`, `Points`) VALUES
(3, 8, 115.0),
(4, 6, 160.0),
(5, 12, 43.0),
(6, 18, 7.0),
(7, 16, 10.0),
(9, 20, 0.0),
(10, 11, 110.0),
(11, 4, 190.0),
(14, 10, 81.0),
(16, 7, 159.0),
(18, 13, 34.0),
(22, 14, 32.0),
(31, 9, 74.0),
(33, 1, 395.5),
(44, 2, 387.5),
(47, 19, 0.0),
(55, 5, 164.5),
(63, 17, 16.0),
(77, 3, 226.0),
(99, 15, 3.0);

-- --------------------------------------------------------

--
-- Table structure for table `driver_list`
--

CREATE TABLE `driver_list` (
  `Driver_ID` int(11) NOT NULL PRIMARY KEY,
  `Fname` varchar(9) NOT NULL,
  `Lname` varchar(10) NOT NULL,
  `DOB` date NOT NULL,
  `Nationality` varchar(10) NOT NULL,
  `Team` varchar(15) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `driver_list`
--

INSERT INTO `driver_list` (`Driver_ID`, `Fname`, `Lname`, `DOB`, `Nationality`, `Team`) VALUES
(3, 'Daniel', 'Ricciardo', '1989-07-01', 'Australian', 'McLaren'),
(4, 'Lando', 'Norris', '1999-11-13', 'British', 'McLaren'),
(5, 'Sebastian', 'Vettel', '1987-07-03', 'German', 'Aston Martin'),
(6, 'Nicholas', 'Latifi', '1995-06-29', 'Canadian', 'Williams'),
(7, 'Kimi', 'Raikkonen', '1979-10-17', 'Finnish', 'Alfa Romeo'),
(9, 'Nikita', 'Mazepin', '1999-03-02', 'Russian', 'Haas'),
(10, 'Pierre', 'Gasly', '1996-02-07', 'French', 'AlphaTauri'),
(11, 'Sergio', 'Perez', '1990-01-26', 'Mexican', 'Red Bull Racing'),
(14, 'Fernando', 'Alonso', '1981-07-29', 'Spanish', 'Alpine'),
(16, 'Charles', 'Leclerc', '1997-10-16', 'Monegasque', 'Ferrari'),
(18, 'Lance', 'Stroll', '1998-10-29', 'Canadian', 'Aston Martin'),
(22, 'Yuki', 'Tsunoda', '2000-05-11', 'Japanese', 'AlphaTauri'),
(31, 'Esteban', 'Ocon', '1996-09-17', 'French', 'Alpine'),
(33, 'Max', 'Verstappen', '1997-09-30', 'Dutch', 'Red Bull Racing'),
(44, 'Lewis', 'Hamilton', '1985-01-07', 'British', 'Mercedes'),
(47, 'Mick', 'Schumacher', '1999-03-22', 'German', 'Haas'),
(55, 'Carlos', 'Sainz', '1994-09-01', 'Spanish', 'Ferrari'),
(63, 'George', 'Russell', '1998-02-15', 'British', 'Williams'),
(77, 'Valtteri', 'Bottas', '1989-08-28', 'Finnish', 'Mercedes'),
(99, 'Antonio', 'Giovinazzi', '1993-12-14', 'Italian', 'Alfa Romeo');

-- --------------------------------------------------------

--
-- Table structure for table `fastest_lap`
--

CREATE TABLE `fastest_lap` (
  `Driver_ID` varchar(3) NOT NULL,
  `Circuit_ID` varchar(3) NOT NULL,
  `Lap_No` int(11) NOT NULL,
  `Time` varchar(7) DEFAULT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fastest_lap`
--

/* INSERT INTO `fastest_lap` (`Driver_ID`, `Circuit_ID`, `Lap_No`, `Time`) VALUES
('BOT', 'POR', 64, '01:19.9'),
('BOT', 'SOC', 53, '01:37.8'),
('GAS', 'HUN', 70, '01:18.4'),
('HAM', 'BAK', 51, '01:43.5'),
('HAM', 'BHR', 51, '01:32.1'),
('HAM', 'CAT', 60, '01:18.1'),
('HAM', 'MEX', 71, '01:17.8'),
('HAM', 'MON', 53, '01:24.1'),
('HAM', 'SIL', 50, '01:28.6'),
('LEC', 'RIC', 53, '01:36.2'),
('LEC', 'ZAN', 72, '01:11.1'),
('NOR', 'YAS', 58, '01:26.1'),
('PER', 'INT', 70, '01:11.0'),
('PER', 'IST', 58, '01:30.4'),
('VER', 'COT', 56, '01:38.2'),
('VER', 'IMO', 63, '01:15.5'),
('VER', 'MCO', 78, '01:12.9'),
('VER', 'RBA', 71, '01:06.2'),
('VER', 'SPA', 44, '01:46.3'); */

INSERT INTO fastest_lap (Driver_ID, Circuit_ID, Lap_No, Time) VALUES
('44', 'MCO', 78, '1:12.9'),
('33', 'SPA', 44, '1:46.3'),
('16', 'MON', 65, '1:12.1');


-- --------------------------------------------------------

--
-- Table structure for table `pole_position`
--

CREATE TABLE `pole_position` (
  `Driver_ID` varchar(3) NOT NULL,
  `Circuit_ID` varchar(3) NOT NULL,
  `Q_Time` varchar(7) NOT NULL
) -- ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pole_position`
--

INSERT INTO `pole_position` (`Driver_ID`, `Circuit_ID`, `Q_Time`) VALUES
('BOT', 'MEX', '01:15.9'),
('BOT', 'MON', '01:19.6'),
('BOT', 'POR', '01:18.3'),
('HAM', 'CAT', '01:16.7'),
('HAM', 'HUN', '01:15.4'),
('HAM', 'IMO', '01:14.4'),
('HAM', 'INT', '01:07.9'),
('HAM', 'IST', '01:22.9'),
('HAM', 'SIL', '01:26.1'),
('HAM', 'SOC', '01:41.4'),
('LEC', 'BAK', '01:41.2'),
('LEC', 'MCO', '01:10.3'),
('VER', 'BHR', '01:29.0'),
('VER', 'COT', '01:32.9'),
('VER', 'RBA', '01:03.7'),
('VER', 'RIC', '01:30.0'),
('VER', 'SPA', '01:59.8'),
('VER', 'YAS', '01:22.1'),
('VER', 'ZAN', '01:08.9');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `circuit`
--
ALTER TABLE `circuit`
  ADD PRIMARY KEY (`Circuit_ID`);

--
-- Indexes for table `constructor_list`
--
ALTER TABLE `constructor_list`
  ADD PRIMARY KEY (`Const_ID`);

--
-- Indexes for table `const_champs`
--
ALTER TABLE `const_champs`
  ADD PRIMARY KEY (`Const_ID`);

--
-- Indexes for table `driver_champs`
--
ALTER TABLE `driver_champs`
  ADD PRIMARY KEY (`Driver_ID`);

--
-- Indexes for table `driver_list`
--
ALTER TABLE `driver_list`
  ADD PRIMARY KEY (`Driver_ID`);

--
-- Indexes for table `fastest_lap`
--
ALTER TABLE `fastest_lap`
  ADD PRIMARY KEY (`Driver_ID`,`Circuit_ID`,`Lap_No`);

--
-- Indexes for table `pole_position`
--
ALTER TABLE `pole_position`
  ADD PRIMARY KEY (`Driver_ID`,`Circuit_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- TRIGGER #1:
-- This trigger automatically updates the constructor's points in const_champs when a driver's points are updated in driver_champs.
-- It calculates the sum of points for all drivers in a team and updates the corresponding constructor's points.
DELIMITER //
CREATE TRIGGER update_constructor_points
AFTER UPDATE ON driver_champs
FOR EACH ROW
BEGIN
    UPDATE const_champs cc
    SET cc.Points = (
        SELECT SUM(dc.Points)
        FROM driver_champs dc
        INNER JOIN driver_list dl ON dc.Driver_ID = dl.Driver_ID
        INNER JOIN constructor_list cl ON dl.Team = cl.Team_Name
        WHERE cl.Const_ID = cc.Const_ID
    )
    WHERE cc.Const_ID IN (
        SELECT cl.Const_ID
        FROM constructor_list cl
        INNER JOIN driver_list dl ON cl.Team_Name = dl.Team
        WHERE dl.Driver_ID = NEW.Driver_ID
    );
END //
DELIMITER ;

-- TRIGGER 2:
-- This trigger automatically inserts a new record into the driver_champs table when a new driver is added to the driver_list table.
-- It sets the initial position to 0 and points to 0 for the new driver.
DELIMITER //
CREATE TRIGGER insert_driver_champs
AFTER INSERT ON driver_list
FOR EACH ROW
BEGIN
    INSERT INTO driver_champs (Driver_ID, Position, Points)
    VALUES (NEW.Driver_ID, 0, 0);
END //
DELIMITER ;
