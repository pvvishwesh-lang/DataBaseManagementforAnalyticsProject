CREATE TABLE `payments` (
  `Payment_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int DEFAULT NULL,
  `Amount` float NOT NULL,
  `Currency` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Payment_Method` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Transaction_Date` datetime(6) NOT NULL,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Payment_Reference` varchar(1000) NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Payment_ID`),
  KEY `Booking_ID` (`Booking_ID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `BOOKINGS` (`Booking_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
