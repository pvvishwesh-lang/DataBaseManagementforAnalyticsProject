CREATE TABLE `time_slots` (
  `Time_Slot_ID` int NOT NULL AUTO_INCREMENT,
  `Place_ID` int DEFAULT NULL,
  `Spot_ID` int DEFAULT NULL,
  `Start_Time` datetime(6) NOT NULL,
  `End_Time` datetime(6) NOT NULL,
  `Max_Capacity` int NOT NULL,
  `Booked_Count` int NOT NULL,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Time_Slot_ID`),
  KEY `Place_ID` (`Place_ID`),
  KEY `Spot_ID` (`Spot_ID`),
  CONSTRAINT `time_slots_ibfk_1` FOREIGN KEY (`Place_ID`) REFERENCES `PUBLIC_PLACES` (`Place_ID`),
  CONSTRAINT `time_slots_ibfk_2` FOREIGN KEY (`Spot_ID`) REFERENCES `SPOTS_AVAILABILITY` (`Spot_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
