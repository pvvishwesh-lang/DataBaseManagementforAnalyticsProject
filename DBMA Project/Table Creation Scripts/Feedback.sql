CREATE TABLE `feedback` (
  `Feedback_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int DEFAULT NULL,
  `Place_ID` int DEFAULT NULL,
  `Spot_ID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comments` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Submitted_At` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Feedback_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `Place_ID` (`Place_ID`),
  KEY `Spot_ID` (`Spot_ID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `USERS` (`User_ID`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`Place_ID`) REFERENCES `PUBLIC_PLACES` (`Place_ID`),
  CONSTRAINT `feedback_ibfk_3` FOREIGN KEY (`Spot_ID`) REFERENCES `SPOTS_AVAILABILITY` (`Spot_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
