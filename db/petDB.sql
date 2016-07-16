-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 16, 2016 at 05:40 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`D_ID`, `D_OrderID`, `D_ProductID`, `D_PName`, `D_PPrice`, `D_PQuantity`, `D_ItemTotal`) VALUES
(1, '20160716170913d35a8', 3, '狗罐頭', 150, 1, 150),
(2, '20160716170913d35a8', 2, '貓罐頭', 100, 1, 100),
(3, '20160716170913d35a8', 2, '貓罐頭', 100, 1, 100),
(4, '20160716170913d35a8', 3, '狗罐頭', 150, 1, 150),
(5, '20160716170913d35a8', 1, '蘑菇', 50, 1, 50),
(6, '20160716170913d35a8', 3, '狗罐頭', 150, 1, 150),
(7, '201607161709255133f', 2, '貓罐頭', 100, 1, 100),
(8, '201607161709255133f', 3, '狗罐頭', 150, 1, 150),
(9, '20160716170958c12f0', 3, '狗罐頭', 150, 1, 150),
(10, '20160716170958c12f0', 2, '貓罐頭', 100, 1, 100),
(11, '2016071617122603da3', 1, '蘑菇', 50, 1, 50),
(12, '20160716171512c4b0c', 3, '狗罐頭', 150, 1, 150),
(13, '20160716171512c4b0c', 2, '貓罐頭', 100, 1, 100);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`M_ID`, `M_Account`, `M_Password`, `M_Name`, `M_Addr`, `M_Email`, `M_Phone`) VALUES
(1, 'singoboy', 'singo', '小丹', '資策會', NULL, NULL),
(6, 'Kobe', 'Kobe', 'Kobe', '小巨蛋', NULL, NULL),
(7, 'wade', 'wade', 'wade', '麥當勞', NULL, NULL),
(8, 'tmac', 'tmac', 'tmac', '輔仁大學', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`O_Index`, `O_OrderID`, `O_Date`, `O_Total`, `O_MemberID`) VALUES
(1, '20160716170913d35a8', '2016-07-16 17:09:13', 700, 8),
(2, '201607161709255133f', '2016-07-16 17:09:25', 250, 8),
(3, '20160716170958c12f0', '2016-07-16 17:09:58', 250, 7),
(4, '2016071617122603da3', '2016-07-16 17:12:26', 50, 7),
(5, '20160716171512c4b0c', '2016-07-16 17:15:12', 250, 6);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reserve`
--

INSERT INTO `reserve` (`R_ID`, `R_TIME`, `R_MEMBER_ID`) VALUES
(3, '2016-07-17 14:00:00', 7),
(5, '2016-07-25 14:00:00', 7),
(6, '2016-07-25 18:00:00', 7),
(9, '2016-07-20 16:00:00', 8),
(10, '2016-07-19 16:00:00', 8),
(11, '2016-07-30 15:00:00', 8),
(12, '2016-07-16 20:00:00', 6),
(13, '2016-07-19 20:00:00', 6),
(14, '2016-07-19 18:00:00', 6);

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
  MODIFY `D_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `O_Index` int(30) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `reserve`
--
ALTER TABLE `reserve`
  MODIFY `R_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
