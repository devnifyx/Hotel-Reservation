-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2026 at 06:28 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `status` enum('pending','confirmed','cancelled') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `hotel_id`, `check_in`, `check_out`, `status`, `created_at`) VALUES
(1, 1, 1, '2026-04-10', '2026-04-13', 'confirmed', '2026-03-30 03:44:51'),
(2, 2, 3, '2026-04-15', '2026-04-17', 'confirmed', '2026-03-30 03:44:51'),
(3, 3, 5, '2026-04-20', '2026-04-22', 'pending', '2026-03-30 03:44:51'),
(8, 5, 2, '2026-04-03', '2026-04-05', 'pending', '2026-03-30 04:55:29'),
(9, 4, 5, '2026-04-09', '2026-04-12', 'confirmed', '2026-03-30 04:56:18');

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
(1, 'Grand Hyatt KL', 'Kuala Lumpur', 480.00, 'Updated description', '', '2026-03-30 03:44:33'),
(2, 'Sunway Resort', 'Petaling Jaya', 280.00, 'Family resort with theme park access', '', '2026-03-30 03:44:33'),
(3, 'Eastern & Oriental', 'Penang', 350.00, 'Heritage hotel on the Penang waterfront', '', '2026-03-30 03:44:33'),
(4, 'Marriott Putrajaya', 'Putrajaya', 320.00, 'Modern hotel near government buildings', '', '2026-03-30 03:44:33'),
(5, 'Lexis Hibiscus', 'Port Dickson', 200.00, 'Private pool villa by the sea', '', '2026-03-30 03:44:33'),
(7, 'Hilton KL', 'Kuala Lumpur', 500.00, 'Modern city hotel', '', '2026-03-30 04:40:16'),
(8, 'TRX Hotel', 'Kuala Lumpur', 450.00, 'City view', '', '2026-03-30 05:05:39');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(50) NOT NULL,
  `status` enum('unpaid','paid') DEFAULT 'unpaid',
  `paid_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `booking_id`, `amount`, `method`, `status`, `paid_at`) VALUES
(1, 1, 1350.00, 'Credit Card', 'paid', NULL),
(2, 2, 700.00, 'Online Banking', 'unpaid', NULL),
(3, 3, 400.00, 'Cash', 'unpaid', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Ahmad Syaher', 'syaher@email.com', '$2y$10$examplehash1', '2026-03-30 03:44:09'),
(2, 'Nurul Ain', 'ain@email.com', '$2y$10$examplehash2', '2026-03-30 03:44:09'),
(3, 'Hafiz Zulkifli', 'hafiz@email.com', '$2y$10$examplehash3', '2026-03-30 03:44:09'),
(4, 'Hanif', 'hanif@email.com', 'password123', '2026-03-30 04:54:42'),
(5, 'Hilmi', 'hilmi@email.com', 'password123', '2026-03-30 04:54:42'),
(6, 'zulkifli rahman', 'rahman@email.com', '$2y$10$PVK48u1Qje96TnF1S2MpIeeL16ND8.QDaQ2y4SQapPMfVda/dgKHu', '2026-03-31 04:18:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
