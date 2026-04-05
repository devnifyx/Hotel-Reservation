-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2026 at 08:52 AM
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
-- Database: `hotel_reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `location` varchar(150) NOT NULL,
  `price_per_night` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `name`, `location`, `price_per_night`, `description`, `image_url`, `created_at`) VALUES
(1, 'Grand Hyatt KL', 'Grand Hyatt KL', 480.00, 'Updated description', '/hotel-api/api/uploads/1775364450_69d1e96204318.jpg', '2026-03-30 03:44:33'),
(2, 'Sunway Resort', 'Sunway ResortJaya', 280.00, 'Family resort with theme park access', '/hotel-api/api/uploads/1775364462_69d1e96e83889.jpg', '2026-03-30 03:44:33'),
(3, 'Eastern & Oriental', 'Eastern & Oriental Hotel', 350.00, 'Heritage hotel on the Penang waterfront', '/hotel-api/api/uploads/1775364471_69d1e9777cd99.jpeg', '2026-03-30 03:44:33'),
(4, 'Marriott Putrajaya', 'Marriott Putrajaya', 320.00, 'Modern hotel near government buildings', '/hotel-api/api/uploads/1775364480_69d1e9805b5cf.webp', '2026-03-30 03:44:33'),
(5, 'Lexis Hibiscus', 'Lexis hibiscus imperial suite', 200.00, 'Private pool villa by the sea', '/hotel-api/api/uploads/1775364491_69d1e98b26397.jpg', '2026-03-30 03:44:33'),
(7, 'Hilton KL', 'Hilton KL', 500.00, 'Modern city hotel', '/hotel-api/api/uploads/1775364499_69d1e993113fa.jpg', '2026-03-30 04:40:16'),
(8, 'TRX Hotel', 'TRX Hotel', 450.00, 'City view', '/hotel-api/api/uploads/1775364506_69d1e99a16c6d.jpg', '2026-03-30 05:05:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
