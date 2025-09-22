CREATE TABLE `notifications` (
  `Notification_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int DEFAULT NULL,
  `Admin_ID` int DEFAULT NULL,
  `Title` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Message` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Type` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Priority` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Delivery_Method` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `sent_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Notification_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `notifications_ibfk_1_idx` (`Admin_ID`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `USERS` (`User_ID`),
  CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`Admin_ID`) REFERENCES `ADMIN_RECORDS` (`Admin_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
