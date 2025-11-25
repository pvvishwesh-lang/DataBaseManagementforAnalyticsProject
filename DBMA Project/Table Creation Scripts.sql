-- Project.Accounts definition

CREATE TABLE `Accounts` (
  `Account_ID` varchar(100) NOT NULL,
  `FirstName` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LastName` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `UserName` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Email` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Password_Hashed` text,
  `Phone_Number` varchar(1000) DEFAULT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Account_ID`),
  UNIQUE KEY `UserName` (`UserName`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.BOOKINGS definition

CREATE TABLE `BOOKINGS` (
  `Booking_ID` varchar(100) NOT NULL,
  `Group_Size` int NOT NULL,
  `Reservation_Date` datetime(6) NOT NULL,
  `Status` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Booking_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.daily_operational_log definition

CREATE TABLE `daily_operational_log` (
  `Log_ID` varchar(100) NOT NULL,
  `Log_Date` datetime(6) NOT NULL,
  `Visitor_Count` int NOT NULL,
  `Total_Sales` float NOT NULL,
  `Trash_Level` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Notes` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Log_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.feedback definition

CREATE TABLE `feedback` (
  `Feedback_ID` varchar(100) NOT NULL,
  `Rating` int DEFAULT NULL,
  `Comments` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Submitted_At` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Feedback_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.notifications definition

CREATE TABLE `notifications` (
  `Notification_ID` varchar(100) NOT NULL,
  `Title` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Message` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Type` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Priority` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Delivery_Method` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `sent_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Notification_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.space_categories definition

CREATE TABLE `space_categories` (
  `Space_Category_ID` varchar(100) NOT NULL,
  `Category_Name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Space_Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.TIME_SLOTS definition

CREATE TABLE `TIME_SLOTS` (
  `Time_Slot_ID` varchar(100) NOT NULL,
  `Start_Time` varchar(1000) NOT NULL,
  `End_Time` varchar(1000) NOT NULL,
  `Max_Capacity` int NOT NULL,
  `Booked_Count` int NOT NULL,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Slot_Date` date DEFAULT NULL,
  PRIMARY KEY (`Time_Slot_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.admin_records definition

CREATE TABLE `admin_records` (
  `Account_ID` varchar(100) NOT NULL,
  `Role` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Last_Login` datetime(6) DEFAULT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Account_ID`),
  CONSTRAINT `admin_records_Accounts_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.audit_logging definition

CREATE TABLE `audit_logging` (
  `Audit_Log_ID` varchar(100) NOT NULL,
  `Account_ID` varchar(100) NOT NULL,
  `Event_Time` datetime DEFAULT CURRENT_TIMESTAMP,
  `User_name` varchar(1000) NOT NULL,
  `Client_Host` varchar(1000) NOT NULL,
  `Db_Name` varchar(1000) NOT NULL,
  `Table_Name` varchar(1000) NOT NULL,
  `Operation` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Sql_Statement` varchar(1000) NOT NULL,
  `Status` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Affected_Rows` int NOT NULL,
  `Remarks` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Old_Data` varchar(1000) DEFAULT NULL,
  `New_Data` varchar(1000) DEFAULT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Audit_Log_ID`),
  KEY `audit_logging_ibfk_2` (`Account_ID`),
  KEY `audit_logging_ibfk_1` (`Account_ID`),
  CONSTRAINT `audit_logging_Accounts_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.payments definition

CREATE TABLE `payments` (
  `Payment_ID` varchar(100) NOT NULL,
  `Booking_ID` varchar(100) NOT NULL,
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


-- Project.public_places definition

CREATE TABLE `public_places` (
  `Place_ID` varchar(100) NOT NULL,
  `Name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Location` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `City` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Country` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Opening_Time` varchar(100) NOT NULL,
  `Closing_Time` varchar(100) NOT NULL,
  `Contact_Info` varchar(1000) NOT NULL,
  `Total_Spots` int NOT NULL,
  `Space_Category_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Log_ID` varchar(100) NOT NULL,
  PRIMARY KEY (`Place_ID`),
  KEY `public_places->space_categories_idx` (`Space_Category_ID`),
  KEY `public_places_daily_operational_log_FK` (`Log_ID`),
  CONSTRAINT `public_places->space_categories` FOREIGN KEY (`Space_Category_ID`) REFERENCES `space_categories` (`Space_Category_ID`),
  CONSTRAINT `public_places_daily_operational_log_FK` FOREIGN KEY (`Log_ID`) REFERENCES `daily_operational_log` (`Log_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.PublicPlace_Feedback definition

CREATE TABLE `PublicPlace_Feedback` (
  `Feedback_ID` varchar(100) NOT NULL,
  `Place_ID` varchar(100) NOT NULL,
  `Created_At` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Feedback_ID`,`Place_ID`),
  KEY `PublicPlace_Feedback_public_places_FK` (`Place_ID`),
  CONSTRAINT `PublicPlace_Feedback_feedback_FK` FOREIGN KEY (`Feedback_ID`) REFERENCES `feedback` (`Feedback_ID`),
  CONSTRAINT `PublicPlace_Feedback_public_places_FK` FOREIGN KEY (`Place_ID`) REFERENCES `public_places` (`Place_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.spots_availability definition

CREATE TABLE `spots_availability` (
  `Spot_ID` varchar(100) NOT NULL,
  `Place_ID` varchar(100) DEFAULT NULL,
  `Spot_Name` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
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


-- Project.Users definition

CREATE TABLE `Users` (
  `Account_ID` varchar(100) NOT NULL,
  `Address1` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Address2` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `City` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `State` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Country` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Age` int NOT NULL,
  `Profile_Img` text,
  `Is_Student` tinyint(1) DEFAULT NULL,
  `Student_ID` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Last_Login` datetime(6) DEFAULT NULL,
  `Created_At` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Account_ID`),
  CONSTRAINT `Users_Accounts_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`),
  CONSTRAINT `users_chk_1` CHECK ((`Age` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.Booking_Payment definition

CREATE TABLE `Booking_Payment` (
  `Booking_ID` varchar(100) NOT NULL,
  `Payment_ID` varchar(100) NOT NULL,
  `Time_Slot_ID` varchar(100) DEFAULT NULL,
  `Created_At` varchar(50) DEFAULT NULL,
  `Account_ID` varchar(100) DEFAULT NULL,
  KEY `Booking_Payment_BOOKINGS_FK` (`Booking_ID`),
  KEY `Booking_Payment_payments_FK` (`Payment_ID`),
  KEY `Booking_Payment_time_slots_FK` (`Time_Slot_ID`),
  KEY `Booking_Payment_Users_FK` (`Account_ID`),
  CONSTRAINT `Booking_Payment_BOOKINGS_FK` FOREIGN KEY (`Booking_ID`) REFERENCES `BOOKINGS` (`Booking_ID`),
  CONSTRAINT `Booking_Payment_payments_FK` FOREIGN KEY (`Payment_ID`) REFERENCES `payments` (`Payment_ID`),
  CONSTRAINT `Booking_Payment_time_slots_FK` FOREIGN KEY (`Time_Slot_ID`) REFERENCES `time_slots` (`Time_Slot_ID`),
  CONSTRAINT `Booking_Payment_Users_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Users` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.Notifies_Users definition

CREATE TABLE `Notifies_Users` (
  `Account_ID` varchar(100) NOT NULL,
  `Notification_ID` varchar(100) NOT NULL,
  `Created_At` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`,`Notification_ID`),
  KEY `Notifies_notifications_FK` (`Notification_ID`),
  CONSTRAINT `Notifies_notifications_FK` FOREIGN KEY (`Notification_ID`) REFERENCES `notifications` (`Notification_ID`),
  CONSTRAINT `Notifies_Users_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Users` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.SPOTAVAILABILITY_CHECKS_TIME_SLOTS definition

CREATE TABLE `SPOTAVAILABILITY_CHECKS_TIME_SLOTS` (
  `Time_Slot_ID` varchar(100) NOT NULL,
  `Spot_ID` varchar(100) NOT NULL,
  `Checked_At` varchar(50) DEFAULT NULL,
  `MAX_CAPACITY` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Time_Slot_ID`,`Spot_ID`),
  KEY `SpotAvailability_Checks_Time_Slots_spots_availability_FK` (`Spot_ID`),
  CONSTRAINT `SpotAvailability_Checks_Time_Slots_spots_availability_FK` FOREIGN KEY (`Spot_ID`) REFERENCES `spots_availability` (`Spot_ID`),
  CONSTRAINT `SpotAvailability_Checks_Time_Slots_time_slots_FK` FOREIGN KEY (`Time_Slot_ID`) REFERENCES `time_slots` (`Time_Slot_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Project.User_Feedback definition

CREATE TABLE `User_Feedback` (
  `Account_ID` varchar(100) NOT NULL,
  `Feedback_ID` varchar(100) NOT NULL,
  `Submitted_At` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`,`Feedback_ID`),
  KEY `User_Feedback_feedback_FK` (`Feedback_ID`),
  CONSTRAINT `User_Feedback_feedback_FK` FOREIGN KEY (`Feedback_ID`) REFERENCES `feedback` (`Feedback_ID`),
  CONSTRAINT `User_Feedback_Users_FK` FOREIGN KEY (`Account_ID`) REFERENCES `Users` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
