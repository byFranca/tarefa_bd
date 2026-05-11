
--
-- Constraints for dumped tables
--

--
-- Constraints for table `CustomerCustomerDemo`
--
ALTER TABLE `CustomerCustomerDemo`
  ADD CONSTRAINT `FK_CustomerCustomerDemo_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`),
  ADD CONSTRAINT `FK_CustomerCustomerDemo` FOREIGN KEY (`CustomerTypeID`) REFERENCES `CustomerDemographics` (`CustomerTypeID`);

--
-- Constraints for table `Employees`
--
ALTER TABLE `Employees`
  ADD CONSTRAINT `FK_Employees_Employees` FOREIGN KEY (`ReportsTo`) REFERENCES `Employees` (`EmployeeID`);

--
-- Constraints for table `EmployeeTerritories`
--
ALTER TABLE `EmployeeTerritories`
  ADD CONSTRAINT `FK_EmployeeTerritories_Territories` FOREIGN KEY (`TerritoryID`) REFERENCES `Territories` (`TerritoryID`),
  ADD CONSTRAINT `FK_EmployeeTerritories_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`);

--
-- Constraints for table `OrderDetails`
--
ALTER TABLE `OrderDetails`
  ADD CONSTRAINT `FK_Order_Details_Products` FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`),
  ADD CONSTRAINT `FK_Order_Details_Orders` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`);

--
-- Constraints for table `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `FK_Orders_Shippers` FOREIGN KEY (`ShipVia`) REFERENCES `Shippers` (`ShipperID`),
  ADD CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`),
  ADD CONSTRAINT `FK_Orders_Employees` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`);

--
-- Constraints for table `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `FK_Products_Suppliers` FOREIGN KEY (`SupplierID`) REFERENCES `Suppliers` (`SupplierID`),
  ADD CONSTRAINT `FK_Products_Categories` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`);

--
-- Constraints for table `Territories`
--
ALTER TABLE `Territories`
  ADD CONSTRAINT `FK_Territories_Region` FOREIGN KEY (`RegionID`) REFERENCES `Region` (`RegionID`);

