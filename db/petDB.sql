-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 16, 2016 at 08:03 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

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
(13, '20160716171512c4b0c', 2, '貓罐頭', 100, 1, 100),
(14, '2016071618570326937', 3, '狗罐頭', 150, 1, 150),
(15, '2016071618570326937', 2, '貓罐頭', 100, 1, 100),
(16, '20160723144056ac96e', 2, '貓罐頭', 100, 1, 100),
(17, '20160723144056ac96e', 3, '狗罐頭', 150, 1, 150),
(18, '2016081221012464f11', 2, '貓罐頭', 100, 3, 100),
(19, '2016081221012464f11', 3, '狗罐頭', 150, 1, 150),
(20, '2016081221012464f11', 1, '蘑菇', 50, 1, 50),
(21, '201608161636576f137', 1, '蘑菇', 50, 1, 50),
(22, '201608161636576f137', 2, '貓罐頭', 100, 1, 100),
(23, '201608161636576f137', 3, '狗罐頭', 150, 1, 150),
(24, '201608161636576f137', 4, '貓砂', 250, 1, 250),
(25, '20160816183800b4587', 1, '蘑菇', 50, 1, 50),
(26, '20160816183800b4587', 2, '貓罐頭', 100, 1, 100),
(27, '20160816183800b4587', 3, '狗罐頭', 150, 1, 150),
(28, '20160816183800b4587', 4, '貓砂', 250, 1, 250),
(29, '20160816183800b4587', 5, '潔牙骨', 100, 1, 100),
(30, '20160816183800b4587', 6, '兔飼料', 300, 1, 300),
(31, '201608161947527fb7d', 1, '蘑菇', 50, 1, 50),
(32, '201608161947527fb7d', 2, '貓罐頭', 100, 1, 100),
(33, '201608161947527fb7d', 3, '狗罐頭', 150, 1, 150),
(34, '201608161947527fb7d', 4, '貓砂', 250, 1, 250),
(35, '201608161947527fb7d', 5, '潔牙骨', 100, 1, 100),
(36, '2016081619532633654', 1, '蘑菇', 50, 1, 50),
(37, '2016081619532633654', 2, '貓罐頭', 100, 1, 100),
(38, '2016081619532633654', 3, '狗罐頭', 150, 1, 150),
(39, '2016081619532633654', 4, '貓砂', 250, 1, 250),
(40, '2016081619555654ae7', 1, '蘑菇', 50, 1, 50),
(41, '2016081619555654ae7', 3, '狗罐頭', 150, 1, 150),
(42, '2016081619555654ae7', 4, '貓砂', 250, 1, 250),
(43, '2016081619555654ae7', 5, '潔牙骨', 100, 1, 100),
(44, '201608162001148c25e', 1, '蘑菇', 50, 1, 50),
(45, '201608162001148c25e', 2, '貓罐頭', 100, 1, 100),
(46, '201608162001148c25e', 3, '狗罐頭', 150, 2, 300),
(47, '201608162001148c25e', 4, '貓砂', 250, 2, 500),
(48, '201608162001148c25e', 5, '潔牙骨', 100, 1, 100),
(49, '201608162001148c25e', 6, '兔飼料', 300, 3, 900);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`O_Index`, `O_OrderID`, `O_Date`, `O_Total`, `O_MemberID`) VALUES
(1, '20160716170913d35a8', '2016-07-16 17:09:13', 700, 8),
(2, '201607161709255133f', '2016-07-16 17:09:25', 250, 8),
(3, '20160716170958c12f0', '2016-07-16 17:09:58', 250, 7),
(4, '2016071617122603da3', '2016-07-16 17:12:26', 50, 7),
(5, '20160716171512c4b0c', '2016-07-16 17:15:12', 250, 6),
(6, '2016071618570326937', '2016-07-16 18:57:03', 250, 6),
(7, '20160723144056ac96e', '2016-07-23 14:40:56', 250, 7),
(8, '2016081221012464f11', '2016-08-12 21:01:24', 500, 7),
(9, '201608161636576f137', '2016-08-16 16:36:57', 550, 6),
(10, '20160816183800b4587', '2016-08-16 18:38:00', 950, 6),
(11, '201608161947527fb7d', '2016-08-16 19:47:52', 650, 6),
(12, '2016081619532633654', '2016-08-16 19:53:26', 550, 6),
(13, '2016081619555654ae7', '2016-08-16 19:55:56', 550, 6),
(14, '201608162001148c25e', '2016-08-16 20:01:14', 1950, 6);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(50) NOT NULL,
  `imageName` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `name`, `price`, `imageName`) VALUES
(1, '蘑菇', 50, 'mushroom.jpeg'),
(2, '貓罐頭', 100, 'catcan.jpeg'),
(3, '狗罐頭', 150, 'dogcan.jpeg'),
(4, '貓砂', 250, 'soild.jpg'),
(5, '潔牙骨', 100, 'goo.jpg'),
(6, '兔飼料', 300, 'rabit.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `P_H_MAP`
--

CREATE TABLE `P_H_MAP` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `P_H_MAP`
--

INSERT INTO `P_H_MAP` (`id`, `name`, `address`, `phone`, `lat`, `lon`) VALUES
(1, '博愛動物醫院', '中正區杭州南路2段92號1樓', '33938850', 25.029309, 121.521824),
(2, '來旺動物醫院', '中正區重慶南路3段50號1樓', '23051120', 25.027954, 121.515607),
(3, '中正犬貓醫院', '中正區重慶南路3段60~4號2樓', '23054880', 25.026731, 121.515855),
(4, '漢民動物醫院', '中正區和平西路1段156號1樓', '23074801', 25.02741, 121.515147),
(5, '恩旺動物醫院', '中正區羅斯福路2段7之4號1樓', '23947349', 25.029123, 121.521259),
(6, '古亭動物醫院', '中正區羅斯福路2段138號1樓', '23693373', 25.025853, 121.522903),
(7, '佑昇動物醫院', '中正區羅斯福路3段38號1樓', '23656729', 25.023062, 121.52522),
(8, '台灣動物醫院', '中正區忠孝東路2段74號1樓', '23412128', 25.043161, 121.528862),
(9, '寶寶新動物醫院', '中正區汀州路2段125號1樓', '23677624', 25.025098, 121.519424),
(10, '金旺動物醫院', '中正區青島東路33~2號1樓', '23212580', 25.043257, 121.525049),
(11, '恩孺動物診所', '中正區金山南路1段92號1樓', '23942821', 25.036078, 121.527441),
(12, '康廷動物醫院', '中正區寧波西街88號1樓', '23928187', 25.029802, 121.515733),
(13, '全國動物醫院公館分院', '中正區羅斯福路3段316巷9弄1號1樓', '23658196', 25.015572, 121.531842),
(14, '瀚生動物醫院', '中正區新生南路1段144~1號1樓', '23581765', 25.035688, 121.532486),
(15, '晨光動物醫院', '大同區重慶北路2段47號1樓', '25583347', 25.055248, 121.514346),
(16, '大眾家畜醫院', '大同區重慶北路3段51號1樓', '25861518', 25.065732, 121.513917),
(17, '永新動物醫院', '大同區重慶北路3段185號1樓', '25982889', 25.069284, 121.513997),
(18, '正安動物醫院', '大同區民權西路240號1樓', '25571757', 25.062773, 121.512822),
(19, '弘愛犬貓動物醫院', '大同區民生西路105號1樓', '25503892', 25.05762, 121.518959),
(20, '全民連鎖動物醫院總院', '大同區民生西路247、249號1、2樓', '25530371', 25.057185, 121.514809),
(21, '凡賽爾賽鴿寵物鳥醫院', '大同區民族西路53號1樓', '25869933', 25.068672, 121.519023),
(22, '皇家動物醫院', '大同區民族西路228號1樓', '25960967', 25.068504, 121.512906),
(23, '慈愛動物醫院寧夏分院', '大同區寧夏路1號1樓、3樓', '25563320', 25.054302, 121.514911),
(24, '傑翔動物醫院', '大同區民權西路270之2號1樓', '25573343', 25.062668, 121.511968),
(25, '長沁動物醫院', '大同區重慶北路3段17號', '25992119', 25.064577, 121.513953),
(26, '湖光動物醫院', '大同區重慶北路3段138、140號', '25858860', 25.067799, 121.513462),
(27, '不萊梅特殊寵物專科醫院', '大同區民權西路227號', '25993907', 25.063135, 121.51197),
(28, '梁動物內科醫院', '中山區長安東路1段41~1號1樓', '25811563', 25.049157, 121.525421),
(29, '龍江獸醫院', '中山區龍江路21巷1號1樓', '27722223', 25.047824, 121.540658),
(30, '太僕動物醫院', '中山區龍江路260號1樓', '25170902', 25.060018, 121.540508),
(31, '美加璦動物醫院', '中山區龍江路443巷1之2號1樓', '25054989', 25.067323, 121.541436),
(32, '弘安動物醫院', '中山區五常街69號1樓', '25045630', 25.06444, 121.540148),
(33, '大直動物醫院', '中山區北安路468號1樓', '85096306', 25.079582, 121.544844),
(34, '仁慈動物醫院', '中山區北安路518巷6號1樓', '25336983', 25.079488, 121.545929),
(35, '惟新動物醫院', '中山區明水路672巷34號1樓', '85023725', 25.083482, 121.551659),
(36, '諾亞動物醫院', '中山區吉林路166號1樓', '25642121', 25.056744, 121.529993),
(37, '廣慈動物醫院', '中山區錦州街371號1樓', '25044236', 25.060443, 121.540387),
(38, '興安動物醫院', '中山區興安街89號1樓', '25048179', 25.056218, 121.543126),
(39, '米亞動物醫院', '中山區民權東路2段57號1樓', '25923556', 25.062741, 121.530877),
(40, '和的獸醫院', '中山區民權東路2段152巷22弄2號1樓', '25081009', 25.060587, 121.535017),
(41, '復生動物醫院', '中山區民生東路1段78號1樓', '25643940', 25.057953, 121.526699),
(42, '全民連鎖動物醫院民生東院', '中山區民生東路2段108號1樓', '25639515', 25.057823, 121.531142),
(43, '大晶動物醫院', '中山區農安街72號1樓', '25970625', 25.064704, 121.528927),
(44, '吉林動物醫院', '中山區吉林路121~1號1樓', '25642010', 25.057015, 121.530321),
(45, '東宏動物醫院', '中山區吉林路432號1樓', '25957366', 25.066269, 121.530222),
(46, '101台北貓醫院', '中山區建國北路3段101號1樓', '25091101', 25.066106, 121.536391),
(47, '北安動物醫院', '中山區北安路642號1樓', '25335990', 25.08325, 121.549285),
(48, '華遠動物醫院', '中山區長春路336號1樓', '27131187', 25.054475, 121.540933),
(49, '恩典動物醫院', '中山區民生東路2段45號1樓、2樓', '25314545', 25.05814, 121.529245),
(50, '成功動物醫院', '中山區天祥路3號1樓', '25218001', 25.060647, 121.521143),
(51, '小小貓咪動物醫院', '中山區北安路458巷47弄10號1樓', '25337529', 25.078242, 121.545434),
(52, '黃動物醫院', '中山區復興北路506號1樓', '25045960', 25.065697, 121.544117),
(53, '伊甸動物醫院', '中山區北安路554巷33號1樓', '85092579', 25.080187, 121.549568),
(54, '長宏動物醫院', '中山區吉林路173號1樓', '25678939', 25.059322, 121.530332),
(55, '山區松江路26巷32號', '中山區民生東路1段83號', '25212205', 25.058292, 121.527107),
(56, '文藝動物醫院', '中山區民生東路1段87號地下1樓', '25317261', 25.05831, 121.527217),
(57, '小王子動物醫院', '中山區松江路26巷32號', '25676897', 25.047017, 121.531552),
(58, '吉米犬貓專科醫院', '中山區林森北路649號', '25855991', 25.06763, 121.525877),
(59, '中山動物醫院', '松山區民權東路3段140巷5號1樓及106巷3弄8號1樓', '27196996', 25.061339, 121.546738),
(60, '隆記動物醫院', '松山區民生東路5段212巷1號1樓', '27607639', 25.058572, 121.565056),
(61, '澤禾動物醫院', '松山區健康路256號1樓', '27616267', 25.053876, 121.562711),
(62, '台欣動物醫院', '松山區健康路187號1樓', '25285119', 25.05433, 121.561666),
(63, '健康動物醫院', '松山區健康路238號1樓', '27601818', 25.053872, 121.561831),
(64, '恩亞動物醫院', '松山區健康路325巷14號1樓', '27678889', 25.055677, 121.567214),
(65, '三民動物醫院', '松山區三民路101巷1號1樓', '27534954', 25.057362, 121.563342),
(66, '良醫動物醫院', '松山區八德路4段188號1樓', '27615091', 25.048499, 121.563693),
(67, '嘉慶動物醫院', '松山區八德路4段214-1、218號1樓', '87879121', 25.048703, 121.564547),
(68, '全陽犬貓專科醫院', '松山區八德路4段305號1樓', '27627945', 25.049233, 121.566632),
(69, '美國愛屋動物醫院', '松山區八德路4段520號1樓', '27457379', 25.04976, 121.571109),
(70, '人人愛動物醫院', '松山區延吉街46之3號1樓', '25778182', 25.045182, 121.55366),
(71, '國泰動物醫院', '松山區延吉街57號1樓', '25795722', 25.044972, 121.553853),
(72, '日健動物醫院', '松山區光復北路6~2號1樓', '25707508', 25.048613, 121.55764),
(73, '豐盛動物醫院', '松山區光復北路46號1樓', '25785605', 25.049632, 121.557655),
(74, '台北動物醫院', '松山區光復北路164號1樓', '27176036', 25.052992, 121.556672),
(75, '泰山動物醫院', '松山區光復南路52號1樓', '25792650', 25.045839, 121.55751),
(76, '曼哈頓動物醫院', '松山區市民大道4段77號1樓', '27815203', 25.045256, 121.547103),
(77, '復興動物醫院', '松山區八德路2段381號1樓', '27711414', 25.047975, 121.545076),
(78, '新亞動物醫院', '松山區延壽街390號1樓', '27457119', 25.056256, 121.557711),
(79, '貝恩動物醫院', '松山區南京東路3段256巷55號1樓', '27407366', 25.049111, 121.544615),
(80, '南京太僕動物醫院', '松山區南京東路5段286號', '27562005', 25.050699, 121.567241),
(81, '敦品動物醫院', '大安區大安路1段205號1樓', '27070877', 25.035322, 121.546179),
(82, '康福動物醫院', '大安區瑞安街135巷23號1樓', '27074075', 25.02675, 121.5411),
(83, '富康動物醫院', '大安區建國南路1段298號1樓', '27020135', 25.035861, 121.53735),
(84, '仁愛動物醫院', '大安區仁愛路4段228之5號1樓', '27029165', 25.03745, 121.551716),
(85, '中心動物醫院', '大安區仁愛路4段411~1號1樓', '27410443', 25.038081, 121.556009),
(86, '亞洲獸醫專科醫院', '大安區信義路4段109號1樓', '27081488', 25.03351, 121.547743),
(87, '敦化動物醫院', '大安區敦化南路1段279號1樓', '27080284', 25.035926, 121.549542),
(88, '澄毅動物醫院', '大安區安和路2段171巷13號1樓', '27334341', 25.028283, 121.550585),
(89, '見安獸醫院', '大安區四維路170巷45號1樓', '27070989', 25.028416, 121.546313),
(90, '碩聯動物醫院', '大安區辛亥路2段143號1樓', '27366549', 25.021717, 121.539903),
(91, '上群動物醫院', '大安區延吉街72之20號1樓', '27753007', 25.042267, 121.554084),
(92, '戴瑩乾動物醫院', '大安區延吉街91號1樓', '27310809', 25.043438, 121.554053),
(93, '幸福動物醫院', '大安區延吉街251號1樓', '27005277', 25.034901, 121.556243),
(94, '五洲動物醫院', '大安區新生南路1段137~2號1樓', '27079477', 25.036934, 121.532997),
(95, '萬國家畜醫院', '大安區新生南路2段80~3號1樓', '23965136', 25.027346, 121.534507),
(96, '弘吉獸醫院', '大安區市民大道3段238號1樓', '27410958', 25.044326, 121.541462),
(97, '佑仁動物醫院', '大安區和平東路1段200號1樓', '23635377', 25.026163, 121.531259),
(98, '專心動物醫院', '大安區和平東路2段34、34~1號1樓', '23633016', 25.025512, 121.5369),
(99, '遠見動物眼科醫院', '大安區和平東路2段68號1樓', '23775388', 25.025283, 121.538995),
(100, '常明動物眼科醫院', '大安區和平東路2段201號1樓', '27030809', 25.025243, 121.542345),
(101, '宏成動物醫院', '大安區和平東路3段66-1號1樓', '23780228', 25.024427, 121.54983),
(102, '曾安動物醫院', '大安區通化街148號1樓', '27383248', 25.028819, 121.553772),
(103, '沐恩動物醫院', '大安區基隆路2段220號1至4樓', '23782300', 25.023514, 121.551294),
(104, '安庭動物醫院', '大安區金山南路2段139號1樓及地下1樓', '23923655', 25.029703, 121.526652),
(105, '聖地牙哥動物醫院', '大安區羅斯福路3段65號3樓之1', '23643458', 25.022938, 121.52597),
(106, '名人維東尼動物醫院', '大安區建國南路1段358號', '27090123', 25.033743, 121.537393),
(107, '愛狗園動物醫院', '大安區基隆路2段124號', '27392966', 25.028914, 121.556832),
(108, '全民連鎖動物醫院信義院', '大安區信義路4段406、408號1、2樓', '27019959', 25.032874, 121.556969),
(109, '王樣動物醫院', '大安區金華街217號1樓', '23570217', 25.029917, 121.528995),
(110, '麟安動物醫院', '大安區和平東路3段324號', '27383008', 25.019874, 121.557043),
(111, '極光動物醫院', '大安區建國南路2段31號', '27848211', 25.03233, 121.538204),
(112, '明誠動物醫院', '大安區瑞安街45號1樓', '27086310', 25.029733, 121.543039),
(113, '寵樂動物醫院', '大安區文昌街89號1樓', '27087967', 25.032742, 121.551766),
(114, '國立台灣大學生物資源暨農學院附設動物醫院', '大安區基隆路3段153號', '27396828', 25.015528, 121.543076),
(115, '貓醫生的貓診所', '大安區忠孝東路3段194號2樓之1', '0920510879', 25.041457, 121.539247),
(116, '杜克動物醫院', '大安區基隆路2段223號1樓', '0933097748', 25.022742, 121.551011),
(117, '雙園動物醫院', '萬華區西園路2段105號1樓', '23084409', 25.030213, 121.496624),
(118, '安迪動物醫院', '萬華區西園路2段175號1樓', '23055518', 25.02786, 121.495177),
(119, '大東動物醫院', '萬華區東園街158號1樓', '23098379', 25.022769, 121.497831),
(120, '保全獸醫院', '萬華區西藏路324、326號1樓', '23024375', 25.029554, 121.500206),
(121, '環南動物醫院', '萬華區和平西路3段205號1樓', '23020109', 25.035495, 121.497043),
(122, '萬華動物醫院', '萬華區昆明街165號1樓', '23614831', 25.040161, 121.504427),
(123, '康寧動物醫院', '萬華區長沙街2段157號1樓', '23831528', 25.040553, 121.502496),
(124, '華中動物醫院', '萬華區萬大路227號1樓', '23328572', 25.026561, 121.500674),
(125, '古德動物醫院', '萬華區西園路2段194號1樓', '23088289', 25.029294, 121.495755),
(126, '長青動物醫院', '萬華區廣州街78號1樓', '23369908', 25.036459, 121.502848),
(127, '艋舺動物醫院', '萬華區萬大路365號1樓', '23010365', 25.022983, 121.499849),
(128, '志誠動物醫院', '萬華區萬大路536號1樓', '23056634', 25.018643, 121.49664),
(129, '安安動物醫院', '信義區松德路57號1樓', '27281315', 25.038775, 121.576994),
(130, '大愛動物醫院', '信義區松德路74號1樓', '87805116', 25.038355, 121.575747),
(131, '欣旺動物醫院', '信義區松山路265號1樓', '27618013', 25.043633, 121.578015),
(132, '恩加動物醫院', '信義區松山路315~2號1樓', '87877551', 25.042363, 121.578058),
(133, '新東動物醫院', '信義區忠孝東路5段189號1樓', '27656189', 25.041237, 121.569338),
(134, '崇安動物醫院', '信義區中坡南路62號1樓', '27276027', 25.041873, 121.584759),
(135, '陽光動物醫院', '信義區林口街222號1樓', '27279922', 25.042139, 121.581202),
(136, '欣欣動物醫院', '信義區松隆路286-1號1樓', '27681119', 25.048276, 121.575974),
(137, '名冠動物醫院', '信義區中坡南路207號1樓', '27590447', 25.041361, 121.585503),
(138, '立健動物醫院', '信義區和平東路3段255號1樓', '27339102', 25.022727, 121.554654),
(139, '文逸動物醫院', '信義區和平東路3段391巷8弄27號1樓', '27322254', 25.020693, 121.557475),
(140, '安興動物醫院', '信義區吳興街478號1樓', '87803433', 25.02357, 121.569277),
(141, '豐德動物醫院', '信義區莊敬路235號1樓', '27588292', 25.029782, 121.562272),
(142, '詠欣動物醫院', '信義區莊敬路428號1樓', '27202631', 25.027017, 121.566676),
(143, '玉山動物醫院', '信義區信義路6段37號1樓', '23466659', 25.034922, 121.576084),
(144, '華欣家畜醫院', '信義區光復南路473巷13弄7號1樓', '27054895', 25.034264, 121.558434),
(145, '永春動物醫院', '信義區忠孝東路5段424號1樓', '87898849', 25.040685, 121.575551),
(146, '星辰動物醫院', '信義區松隆路225號1樓', '27611199', 25.048414, 121.576835),
(147, '艾爾瑪動物醫院', '信義區仁愛路4段452巷8號1樓', '87894859', 25.037034, 121.55911),
(148, '松山動物醫院', '信義區松山路275號1樓', '27673322', 25.04342, 121.578014),
(149, '愛心動物醫院', '信義區光復南路563號1樓', '23451633', 25.03107, 121.557622),
(150, '沐樂動物醫院', '信義區忠孝東路4段559巷30號1樓', '27699899', 25.042889, 121.56383),
(151, '臺北市流浪貓保護協會附設貓醫院', '信義區信義路6段81號1樓', '27261872', 25.035755, 121.577254),
(152, '陽明家畜醫院', '士林區天母東路1之6號1樓', '28726911', 25.118317, 121.53125),
(153, '福臨動物醫院', '士林區中山北路5段519號1樓', '28836500', 25.093874, 121.527857),
(154, '天母家畜醫院', '士林區中山北路6段431之3號1樓', '28315677', 25.114082, 121.527015),
(155, '楊動物醫院', '士林區中山北路6段368號1樓', '28717261', 25.112315, 121.52646),
(156, '微笑動物醫院', '士林區中山北路7段163號1樓', '28730728', 25.123837, 121.532256),
(157, '士林獸醫院', '士林區中正路379號1樓', '28822193', 25.094204, 121.521699),
(158, '台愛動物醫院', '士林區中正路629號1樓', '88115729', 25.086222, 121.5086),
(159, '阿牛犬貓急診醫院', '士林區文林路311號1樓', '28827381', 25.092127, 121.525975),
(160, '忠誠獸醫院', '士林區文林路734號1樓', '28351390', 25.102775, 121.52048),
(161, '藍天家畜醫院', '士林區文林路757號1樓', '28380088', 25.103235, 121.519391),
(162, '社子動物醫院', '士林區延平北路5段191號1樓', '28165355', 25.083378, 121.510029),
(163, '昌展動物醫院', '士林區延平北路6段160號1樓', '28169197', 25.08963, 121.506625),
(164, '中興動物醫院', '士林區延平北路6段245號1樓', '28113970', 25.089105, 121.504216),
(165, '信達犬貓專科醫院', '士林區華齡街22巷15弄5號1樓', '28812150', 25.083467, 121.520353),
(166, '厚德動物醫院', '士林區華齡街54號1樓', '28831716', 25.084214, 121.519481),
(167, '唯安動物醫院', '士林區承德路4段18號1', '28851695', 25.080103, 121.521825),
(168, '汎亞動物醫院', '士林區承德路4段183號1樓', '28826655', 25.108885, 121.523445),
(169, '溫莎動物醫院', '士林區德行東路83號1樓', '28345969', 25.107498, 121.527474),
(170, '劉動物醫院', '士林區德行東路269號1樓', '28365679', 25.110075, 121.535318),
(171, '芝山動物醫院', '士林區文林路762-2號1樓', '28328385', 25.103524, 121.519792),
(172, '劍橋動物醫院', '士林區忠誠路1段102號1樓', '88665889', 25.105312, 121.528362),
(173, '世東動物醫院', '士林區士東路39號1樓', '28712529', 25.112015, 121.527386),
(174, '常源動物醫院', '士林區德行東路189號1樓', '28370616', 25.108958, 121.531596),
(175, '天母太僕動物醫院', '士林區天母西路48號1樓', '28732070', 25.118305, 121.525102),
(176, '尼古拉動物醫院', '士林區克強路23號1樓', '28323386', 25.108885, 121.523445),
(177, '百科家畜醫院', '北投區西安街1段359號1樓', '28214942', 25.114248, 121.515332),
(178, '聯合家畜醫院', '北投區裕民一路 40巷29號1樓', '28282117', 25.115446, 121.517794),
(179, '中英動物醫院', '北投區中央北路1段149號1樓', '28936119', 25.135338, 121.498555),
(180, '北投動物醫院', '北投區中央北路2段60~1號1樓', '28928665', 25.137296, 121.494921),
(181, '大同動物醫院', '北投區中央北路2段112號1樓', '28959607', 25.137334, 121.492658),
(182, '旺旺動物醫院', '北投區東華街2段2號1樓', '28203693', 25.115648, 121.515103),
(183, '大葉動物醫院', '北投區大業路394號1樓', '28935372', 25.129979, 121.49719),
(184, '百威動物醫院', '北投區中和街288號1樓', '28910951', 25.140542, 121.500303),
(185, '和欣動物醫院', '北投區雙全街7號1樓', '28973439', 25.138922, 121.501275),
(186, '全民動物醫院北投分院', '北投區光明路61號1樓', '28939752', 25.132908, 121.499885),
(187, '豐茂動物醫院', '北投區實踐街64號1樓', '28210824', 25.115155, 121.509923),
(188, '丹堤動物醫院', '北投區知行路208~2號1樓', '55865668', 25.119359, 121.466859),
(189, '明德動物醫院', '北投區明德路115號1樓', '28239018', 25.109937, 121.519816),
(190, '劍橋動物醫院石牌芸林分院', '北投區石牌路2段332~1號1樓', '28721398', 25.122378, 121.524396),
(191, '加生動物醫院', '北投區石牌路1段95號1樓', '28207218', 25.113934, 121.511758),
(192, '杜瑪動物醫院', '北投區大業路541號1樓', '28977779', 25.135428, 121.496489),
(193, '內湖動物醫院', '內湖區內湖路1段45號1樓', '27992011', 25.085194, 121.559186),
(194, '西湖動物醫院', '內湖區內湖路1段341之2號1樓', '27990700', 25.082376, 121.568834),
(195, '德安動物醫院', '內湖區內湖路1段611號1樓', '26582478', 25.08077, 121.573864),
(196, '佳欣動物醫院', '內湖區內湖路2段383號1樓', '27946126', 25.083992, 121.592451),
(197, '加洲動物醫院', '內湖區文德路9號1樓', '27987942', 25.078525, 121.580461),
(198, '港墘動物醫院', '內湖區港墘路109~2號1樓', '26575990', 25.079987, 121.577496),
(199, '長慶動物醫院', '內湖區東湖路7巷7號1樓', '26331257', 25.069344, 121.61282),
(200, '東湖動物醫院', '內湖區東湖路43巷5號1樓', '26332220', 25.069214, 121.613998),
(201, '全安動物醫院', '內湖區東湖路113巷54號1樓', '26336495', 25.070859, 121.616031),
(202, '勝利動物醫院', '內湖區康樂街116之2號1樓', '26327815', 25.07117, 121.618944),
(203, '康泰動物醫院', '內湖區康樂街164之1號1樓', '26313068', 25.073234, 121.6194),
(204, '佳恩動物醫院', '內湖區成功路3段117號1樓', '27941290', 25.078887, 121.589802),
(205, '健生動物醫院', '內湖區成功路4段182巷8弄4號1樓', '27910198', 25.08408, 121.59359),
(206, '亞馬森動物醫院', '內湖區成功路4段311號1樓', '87923248', 25.084495, 121.598386),
(207, '大湖動物醫院', '內湖區成功路5段10號1樓', '27968241', 25.084633, 121.600989),
(208, '宇恒動物醫院', '內湖區民權東路6段57號1樓', '27951676', 25.069272, 121.587336),
(209, '全國動物醫院台北分院', '內湖區舊宗路1段30巷13號1樓', '87918706', 25.057744, 121.580316),
(210, '納嘉動物醫院', '內湖區內湖區成功路5段55號1樓', '26330555', 25.074339, 121.606194),
(211, '維康動物醫院', '內湖區成功路3段150號1樓', '27937293', 25.080006, 121.589836),
(212, '佳康動物醫院', '內湖區康寧路3段169-1號1樓', '26318345', 25.070255, 121.611808),
(213, '角落動物醫院', '內湖區金湖路22號1樓', '27926858', 25.083123, 121.596238),
(214, '樂沛動物醫院', '內湖區成功路4段368號1樓', '27909218', 25.084834, 121.600458),
(215, '洪生動物醫院', '南港區忠孝東路7段571號1樓', '27833715', 25.053117, 121.614129),
(216, '啓正動物醫院', '南港區南港路1段289~1號1樓', '26517616', 25.054446, 121.608277),
(217, '中研動物醫院', '南港區研究院路1段72號1樓', '26512100', 25.052805, 121.616026),
(218, '維恩動物醫院', '南港區東新街132號1樓', '26515527', 25.046464, 121.588726),
(219, '北新獸醫院', '文山區羅斯福路5段172號4樓', '29310690', 25.004393, 121.538633),
(220, '正吉動物醫院', '文山區羅斯福路5段47~1號1樓', '29347505', 25.007252, 121.53898),
(221, '景美動物醫院', '文山區羅斯福路6段6號1樓', '29310850', 25.000375, 121.539341),
(222, '品安動物醫院', '文山區羅斯福路6段89號1樓', '29359188', 24.998807, 121.540463),
(223, '加恩動物醫院', '文山區木柵路1段102號1樓', '22360117', 24.987457, 121.550941),
(224, '達仁動物醫院', '文山區木柵路2段133號1樓', '29371558', 24.989043, 121.562202),
(225, '木新獸醫院', '文山區木新路3段133~2號1樓', '29362748', 24.981793, 121.561844),
(226, '維拉動物醫院', '文山區興隆路1段94號1樓', '29333872', 25.00298, 121.541075),
(227, '靜心獸醫院', '文山區興隆路2段21、23號1樓', '29330562', 24.998932, 121.545505),
(228, '正興獸醫院', '文山區興隆路2段95巷5之1號1樓', '29330607', 24.999738, 121.546823),
(229, '路加動物醫院', '文山區興隆路2段224之4號1樓', '55852108', 25.001167, 121.553201),
(230, '世安動物醫院', '文山區興隆路3段298~2號1樓', '22306841', 24.993465, 121.558915),
(231, '再興動物醫院', '文山區興隆路1段1號1樓', '29342899', 25.004484, 121.539037),
(232, '自強動物醫院', '文山區興隆路4段108號1樓', '29372852', 24.983094, 121.562071),
(233, '康禾動物醫院', '文山區興隆路4段159之1號1樓', '29374998', 24.98434, 121.561976),
(234, '亞太動物醫院', '文山區景福街244號1樓及地下1樓', '29300005', 24.993488, 121.539814),
(235, '安心動物醫院', '文山區羅斯福路5段17號1樓', '29326935', 25.007971, 121.538481),
(236, '大群動物醫院', '文山區羅斯福路6段206號1樓', '29305557', 24.993605, 121.540793),
(237, '締爾動物醫院', '文山區木新路3段321號1樓', '29388211', 24.98056, 121.55662),
(238, '景文動物醫院', '文山區景文街29號1樓', '89319955', 24.992431, 121.541431),
(239, '景興動物醫院', '文山區景華街92號1樓', '29330600', 24.994957, 121.5457);

-- --------------------------------------------------------

--
-- Table structure for table `reserve`
--

CREATE TABLE `reserve` (
  `R_ID` int(11) NOT NULL,
  `R_TIME` datetime DEFAULT NULL,
  `R_MEMBER_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reserve`
--

INSERT INTO `reserve` (`R_ID`, `R_TIME`, `R_MEMBER_ID`) VALUES
(3, '2016-07-17 14:00:00', 7),
(5, '2016-07-25 14:00:00', 7),
(9, '2016-07-20 16:00:00', 8),
(13, '2016-07-19 20:00:00', 6),
(14, '2016-07-19 18:00:00', 6),
(15, '2016-07-23 20:00:00', 7),
(16, '2016-07-26 15:00:00', 7);

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
-- Indexes for table `P_H_MAP`
--
ALTER TABLE `P_H_MAP`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `D_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `M_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `O_Index` int(30) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `productID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `P_H_MAP`
--
ALTER TABLE `P_H_MAP`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=240;
--
-- AUTO_INCREMENT for table `reserve`
--
ALTER TABLE `reserve`
  MODIFY `R_ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
