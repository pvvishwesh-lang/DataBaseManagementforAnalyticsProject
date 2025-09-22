CREATE TABLE `space_categories` (
  `Space_Category_ID` int NOT NULL AUTO_INCREMENT,
  `Place_ID` int DEFAULT NULL,
  `Category_Name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Space_Category_ID`),
  KEY `Place_ID` (`Place_ID`),
  CONSTRAINT `space_categories_ibfk_1` FOREIGN KEY (`Place_ID`) REFERENCES `PUBLIC_PLACES` (`Place_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
