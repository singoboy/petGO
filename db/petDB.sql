-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 15, 2016 at 09:36 PM
-- Server version: 5.5.42
-- PHP Version: 7.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petDB`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail`
--

CREATE TABLE `detail` (
  `D_ID` int(11) NOT NULL,
  `D_OrderID` varchar(40) DEFAULT NULL,
  `D_ProductID` int(11) DEFAULT NULL,
  `D_PName` varchar(40) DEFAULT NULL,
  `D_PPrice` int(11) DEFAULT NULL,
  `D_PQuantity` int(11) DEFAULT NULL,
  `D_ItemTotal` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`D_ID`, `D_OrderID`, `D_ProductID`, `D_PName`, `D_PPrice`, `D_PQuantity`, `D_ItemTotal`) VALUES
(1, '20160710212308cdaef', 2, '貓罐頭', 100, 1, 100),
(2, '20160710212308cdaef', 3, '狗罐頭', 150, 1, 150),
(3, '201607102126577d3cf', 3, '狗罐頭', 150, 1, 150),
(4, '20160710212955ff9bf', 3, '狗罐頭', 150, 1, 150),
(5, '20160710212955ff9bf', 3, '狗罐頭', 150, 1, 150),
(6, '20160710212955ff9bf', 3, '狗罐頭', 150, 1, 150),
(7, '20160710213910e74d0', 2, '貓罐頭', 100, 1, 100),
(8, '20160710213910e74d0', 3, '狗罐頭', 150, 1, 150),
(9, '201607102140443a644', 3, '狗罐頭', 150, 1, 150),
(10, '201607102140443a644', 2, '貓罐頭', 100, 1, 100),
(11, '20160710224439a1408', 3, '狗罐頭', 150, 1, 150),
(12, '20160710224439a1408', 2, '貓罐頭', 100, 1, 100),
(13, '2016071211354670e58', 2, '貓罐頭', 100, 1, 100),
(14, '20160712170034360a4', 2, '貓罐頭', 100, 1, 100),
(15, '2016071217050896710', 2, '貓罐頭', 100, 1, 100),
(16, '2016071217050896710', 2, '貓罐頭', 100, 1, 100),
(17, '2016071217054004415', 2, '貓罐頭', 100, 1, 100),
(18, '20160713110047099ce', 3, '狗罐頭', 150, 1, 150),
(19, '2016071311375766a8b', 3, '狗罐頭', 150, 1, 150),
(20, '2016071311375766a8b', 2, '貓罐頭', 100, 1, 100),
(21, '201607131204310ca4e', 3, '狗罐頭', 150, 1, 150),
(22, '201607131204310ca4e', 2, '貓罐頭', 100, 1, 100);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `M_ID` int(11) NOT NULL,
  `M_Account` varchar(50) DEFAULT NULL,
  `M_Password` varchar(30) DEFAULT NULL,
  `M_Name` varchar(40) DEFAULT NULL,
  `M_Addr` varchar(50) DEFAULT NULL,
  `M_Email` varchar(50) DEFAULT NULL,
  `M_Phone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`M_ID`, `M_Account`, `M_Password`, `M_Name`, `M_Addr`, `M_Email`, `M_Phone`) VALUES
(1, 'singoboy', 'singo', '小丹', '資策會', NULL, NULL),
(6, 'Kobe', 'Kobe', 'Kobe', '小巨蛋', NULL, NULL),
(7, 'wade', 'wade', 'wade', 'wade', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `O_Index` int(30) NOT NULL,
  `O_OrderID` varchar(40) DEFAULT NULL,
  `O_Date` datetime DEFAULT NULL,
  `O_Total` int(11) DEFAULT NULL,
  `O_MemberID` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`O_Index`, `O_OrderID`, `O_Date`, `O_Total`, `O_MemberID`) VALUES
(1, '20160710212308cdaef', '2016-07-10 21:23:08', 250, NULL),
(2, '201607102126577d3cf', '2016-07-10 21:26:57', 150, NULL),
(3, '20160710212955ff9bf', '2016-07-10 21:29:55', 450, NULL),
(4, '20160710213910e74d0', '2016-07-10 21:39:10', 250, NULL),
(5, '201607102140443a644', '2016-07-10 21:40:44', 250, NULL),
(6, '20160710224439a1408', '2016-07-10 22:44:39', 250, NULL),
(7, '2016071211354670e58', '2016-07-12 11:35:46', 100, NULL),
(8, '20160712170034360a4', '2016-07-12 17:00:34', 100, NULL),
(9, '2016071217050896710', '2016-07-12 17:05:08', 200, NULL),
(10, '2016071217054004415', '2016-07-12 17:05:40', 100, NULL),
(11, '20160713110047099ce', '2016-07-13 11:00:47', 150, NULL),
(12, '2016071311375766a8b', '2016-07-13 11:37:57', 250, NULL),
(13, '201607131204310ca4e', '2016-07-13 12:04:31', 250, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(50) NOT NULL,
  `imageName` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `name`, `price`, `imageName`) VALUES
(1, '蘑菇', 50, 'mushroom.jpeg'),
(2, '貓罐頭', 100, 'catcan.jpeg'),
(3, '狗罐頭', 150, 'dogcan.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `reserve`
--

CREATE TABLE `reserve` (
  `R_ID` int(11) NOT NULL,
  `R_TIME` datetime DEFAULT NULL,
  `R_MEMBER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reserve`
--

INSERT INTO `reserve` (`R_ID`, `R_TIME`, `R_MEMBER_ID`) VALUES
(3, '2016-07-13 11:00:00', NULL),
(9, '2016-07-14 16:00:00', NULL),
(10, '2016-07-14 17:00:00', NULL),
(11, '2016-07-15 17:00:00', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail`
--
ALTER TABLE `detail`
  ADD PRIMARY KEY (`D_ID`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`M_ID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`O_Index`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`productID`);

--
-- Indexes for table `reserve`
--
ALTER TABLE `reserve`
  ADD PRIMARY KEY (`R_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail`
--
ALTER TABLE `detail`
  MODIFY `D_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `O_Index` int(30) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `reserve`
--
ALTER TABLE `reserve`
  MODIFY `R_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
