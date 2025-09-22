CREATE TABLE `spots_availability` (
  `Spot_ID` int NOT NULL AUTO_INCREMENT,
  `Place_ID` int NOT NULL,
  `Spot_Name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Space_Category_Id` int DEFAULT NULL,
  `Capacity` int NOT NULL,
  `Current_Count` int NOT NULL,
  `Status` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Last_Updated` datetime(6) NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Spot_ID`),
  KEY `Place_ID` (`Place_ID`),
  CONSTRAINT `spots_availability_ibfk_1` FOREIGN KEY (`Place_ID`) REFERENCES `PUBLIC_PLACES` (`Place_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
