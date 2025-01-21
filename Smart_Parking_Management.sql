-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 20, 2025 at 07:44 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Smart Parking Management`
--

-- --------------------------------------------------------

--
-- Table structure for table `Manager_Panel`
--

CREATE TABLE `Manager_Panel` (
  `Panel_ID` int(11) NOT NULL,
  `Manager_Name` varchar(100) NOT NULL,
  `Lot_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Parking_Lots`
--

CREATE TABLE `Parking_Lots` (
  `Lot_ID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Contact_Info` varchar(50) NOT NULL,
  `Total_Spaces` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Parking_Lots`
--

INSERT INTO `Parking_Lots` (`Lot_ID`, `Name`, `Location`, `Contact_Info`, `Total_Spaces`) VALUES
(1, 'Downtown Lot', '123 Main St, City Center', '+8801555123456', 50),
(2, 'City Center Lot', '45 Park Ave, City Center', '+8801555987654', 30),
(3, 'Airport Lot', 'Airport Road, City Outskirts', '+8801555012345', 100);

-- --------------------------------------------------------

--
-- Table structure for table `Parking_Spaces`
--

CREATE TABLE `Parking_Spaces` (
  `Space_ID` int(11) NOT NULL,
  `Lot_ID` int(11) NOT NULL,
  `Zone` enum('Regular','Premium') NOT NULL,
  `Is_Occupied` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Parking_Spaces`
--

INSERT INTO `Parking_Spaces` (`Space_ID`, `Lot_ID`, `Zone`, `Is_Occupied`) VALUES
(7, 1, 'Regular', 0),
(8, 1, 'Premium', 1),
(9, 2, 'Regular', 0),
(10, 2, 'Premium', 0),
(11, 3, 'Regular', 1),
(12, 3, 'Premium', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Receipts`
--

CREATE TABLE `Receipts` (
  `Receipt_ID` int(11) NOT NULL,
  `Entry_ID` int(11) NOT NULL,
  `Payment_Amount` decimal(10,2) NOT NULL,
  `Payment_Date` datetime NOT NULL DEFAULT current_timestamp(),
  `Parking_Duration` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `User_ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` enum('Admin','User') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicles`
--

CREATE TABLE `Vehicles` (
  `Vehicle_ID` int(11) NOT NULL,
  `License_Plate` varchar(20) NOT NULL,
  `Type` enum('Car','Bike') NOT NULL,
  `Owner_Name` varchar(100) NOT NULL,
  `Contact_Info` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Vehicles`
--

INSERT INTO `Vehicles` (`Vehicle_ID`, `License_Plate`, `Type`, `Owner_Name`, `Contact_Info`) VALUES
(4, 'Dhaka-Metro-1234', 'Car', 'Nahid Hossain', '+8801700000001'),
(5, 'Chittagong-4567', 'Bike', 'Ahsan Karim', '+8801700000002'),
(6, 'Sylhet-7890', 'Car', 'Rafiq Ahmed', '+8801700000003'),
(7, 'ABC-1234', 'Car', 'John Doe', '+8801234567890'),
(8, 'XYZ-5678', 'Bike', 'Jane Smith', '+8809876543210'),
(9, 'LMN-9012', 'Car', 'Alice Johnson', '+8801122334455');

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Entries`
--

CREATE TABLE `Vehicle_Entries` (
  `Entry_ID` int(11) NOT NULL,
  `Entry_Time` datetime NOT NULL DEFAULT current_timestamp(),
  `Vehicle_ID` int(11) NOT NULL,
  `Space_ID` int(11) DEFAULT NULL,
  `Fee` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Exits`
--

CREATE TABLE `Vehicle_Exits` (
  `Exit_ID` int(11) NOT NULL,
  `Entry_ID` int(11) NOT NULL,
  `Exit_Time` datetime NOT NULL DEFAULT current_timestamp(),
  `Parking_Fee` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Manager_Panel`
--
ALTER TABLE `Manager_Panel`
  ADD PRIMARY KEY (`Panel_ID`),
  ADD KEY `Lot_ID` (`Lot_ID`);

--
-- Indexes for table `Parking_Lots`
--
ALTER TABLE `Parking_Lots`
  ADD PRIMARY KEY (`Lot_ID`);

--
-- Indexes for table `Parking_Spaces`
--
ALTER TABLE `Parking_Spaces`
  ADD PRIMARY KEY (`Space_ID`),
  ADD KEY `Lot_Index` (`Lot_ID`);

--
-- Indexes for table `Receipts`
--
ALTER TABLE `Receipts`
  ADD PRIMARY KEY (`Receipt_ID`),
  ADD KEY `Entry_ID` (`Entry_ID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- Indexes for table `Vehicles`
--
ALTER TABLE `Vehicles`
  ADD PRIMARY KEY (`Vehicle_ID`),
  ADD UNIQUE KEY `License_Plate` (`License_Plate`);

--
-- Indexes for table `Vehicle_Entries`
--
ALTER TABLE `Vehicle_Entries`
  ADD PRIMARY KEY (`Entry_ID`),
  ADD KEY `Vehicle_ID` (`Vehicle_ID`),
  ADD KEY `Space_ID` (`Space_ID`);

--
-- Indexes for table `Vehicle_Exits`
--
ALTER TABLE `Vehicle_Exits`
  ADD PRIMARY KEY (`Exit_ID`),
  ADD KEY `Entry_ID` (`Entry_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Manager_Panel`
--
ALTER TABLE `Manager_Panel`
  MODIFY `Panel_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Parking_Lots`
--
ALTER TABLE `Parking_Lots`
  MODIFY `Lot_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `Parking_Spaces`
--
ALTER TABLE `Parking_Spaces`
  MODIFY `Space_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `Receipts`
--
ALTER TABLE `Receipts`
  MODIFY `Receipt_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Vehicles`
--
ALTER TABLE `Vehicles`
  MODIFY `Vehicle_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Vehicle_Entries`
--
ALTER TABLE `Vehicle_Entries`
  MODIFY `Entry_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Vehicle_Exits`
--
ALTER TABLE `Vehicle_Exits`
  MODIFY `Exit_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Manager_Panel`
--
ALTER TABLE `Manager_Panel`
  ADD CONSTRAINT `manager_panel_ibfk_1` FOREIGN KEY (`Lot_ID`) REFERENCES `Parking_Lots` (`Lot_ID`) ON DELETE CASCADE;

--
-- Constraints for table `Parking_Spaces`
--
ALTER TABLE `Parking_Spaces`
  ADD CONSTRAINT `parking_spaces_ibfk_1` FOREIGN KEY (`Lot_ID`) REFERENCES `Parking_Lots` (`Lot_ID`) ON DELETE CASCADE;

--
-- Constraints for table `Receipts`
--
ALTER TABLE `Receipts`
  ADD CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`Entry_ID`) REFERENCES `Vehicle_Entries` (`Entry_ID`) ON DELETE CASCADE;

--
-- Constraints for table `Vehicle_Entries`
--
ALTER TABLE `Vehicle_Entries`
  ADD CONSTRAINT `vehicle_entries_ibfk_1` FOREIGN KEY (`Vehicle_ID`) REFERENCES `Vehicles` (`Vehicle_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `vehicle_entries_ibfk_2` FOREIGN KEY (`Space_ID`) REFERENCES `Parking_Spaces` (`Space_ID`) ON DELETE SET NULL;

--
-- Constraints for table `Vehicle_Exits`
--
ALTER TABLE `Vehicle_Exits`
  ADD CONSTRAINT `vehicle_exits_ibfk_1` FOREIGN KEY (`Entry_ID`) REFERENCES `Vehicle_Entries` (`Entry_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
