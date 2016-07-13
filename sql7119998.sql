-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: sql7.freemysqlhosting.net
-- Generation Time: Jun 21, 2016 at 09:26 AM
-- Server version: 5.5.49-0ubuntu0.14.04.1
-- PHP Version: 5.3.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sql7119998`
--

-- --------------------------------------------------------

--
-- Table structure for table `Advisors`
--

CREATE TABLE IF NOT EXISTS `Advisors` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `advisorId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `bookingTime` datetime DEFAULT NULL,
  `isAvailable` int(11) DEFAULT NULL,
  `currTime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `Advisors`
--

INSERT INTO `Advisors` (`Id`, `advisorId`, `userId`, `bookingTime`, `isAvailable`, `currTime`) VALUES
(1, 8, 4, '2016-05-10 14:00:00', 0, '2016-05-29 16:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `Connections`
--

CREATE TABLE IF NOT EXISTS `Connections` (
  `Id` int(20) NOT NULL AUTO_INCREMENT,
  `SenderId` int(11) DEFAULT NULL,
  `ReceiverId` int(11) DEFAULT NULL,
  `Accepted` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `Connections`
--

INSERT INTO `Connections` (`Id`, `SenderId`, `ReceiverId`, `Accepted`) VALUES
(20, 1, 8, 1),
(24, 7, 9, 0),
(26, 8, 11, 0),
(28, 12, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `Locations`
--

CREATE TABLE IF NOT EXISTS `Locations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `longitude` varchar(20) NOT NULL,
  `latitude` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90 ;

--
-- Dumping data for table `Locations`
--

INSERT INTO `Locations` (`id`, `username`, `longitude`, `latitude`) VALUES
(70, 'songoku', '57.0352299730381', '9.93793644967626'),
(76, 'miley', '57.03524168333', '9.93804495174237'),
(78, 'john.smith', '57.0352281711077', '9.93793778321331'),
(88, 'spamkanalen', '57.02081347821', '9.8835357092413'),
(89, 'alex', '57.0414874140402', '9.94510558445612');

-- --------------------------------------------------------

--
-- Table structure for table `Passions`
--

CREATE TABLE IF NOT EXISTS `Passions` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Passion` varchar(50) DEFAULT NULL,
  `Active` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `Passions`
--

INSERT INTO `Passions` (`Id`, `Passion`, `Active`) VALUES
(0, 'Gaming', 1),
(1, 'Programming', 1),
(2, 'Fishing', 1),
(3, 'Jogging', 1),
(5, 'Design', 1),
(6, 'Medicine', 1),
(7, 'Yoga', 1),
(8, 'Soccer', 1),
(9, 'Volunteering', 1),
(10, 'Cooking', 1),
(11, 'Hunting', 1),
(12, 'Card games', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `Id` int(20) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Passion1` int(11) DEFAULT NULL,
  `Passion2` int(11) DEFAULT NULL,
  `Passion3` int(11) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `isAdvisor` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`Id`, `Username`, `Password`, `Email`, `Name`, `Passion1`, `Passion2`, `Passion3`, `Birthdate`, `isAdvisor`) VALUES
(1, 'son.goku', 'songoku', 'son.goku@dragonball.ro', 'Son Goku', 1, 2, 0, '2016-05-08', 0),
(2, 'michael.jackson', 'michael', 'michael.jackson@gmail.com', 'Michael Jackson', 0, 1, 2, '2016-05-15', 1),
(7, 'joey', 'joey', 'joey1992@yahoo.com', 'Joey Banderas', 1, 2, 3, '1977-02-19', 0),
(8, 'alex', 'alex', 'alex_scorpion_1995@yahoo.com', 'Alexandru Draghi', 3, 6, 5, '1962-05-03', 1),
(9, 'miley', 'miley', 'miley@yahoo.us', 'Miley Cypris', 0, 1, 2, '1985-05-30', 0),
(10, 'john.smith', 'john.smith', 'john.smith@hotmail.com', 'John Smith', 1, 4, 11, '1975-09-01', 0),
(11, 'jack', 'jack', 'jack@gmail.com', 'Jackie Chan', 0, 2, 1, '1996-06-11', 0),
(12, 'spamkanalen', 'Spam123!', 'spamkanalen@gmail.com', 'spamkanalen', 4, 3, 11, '1991-06-15', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
