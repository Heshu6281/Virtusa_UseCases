create database SwiftShipDB;
use SwiftShipDB;
create table Partners(
PartnerId int primary key,
PartnerName varchar(100)
);

create table Shipments(
ShipmentId int primary key,
PartnerId int,
DestinationCity varchar(100),
PromisedDate date,
ActualDeliveryDate date,
Status varchar(50),
foreign key (PartnerId) references Partners (PartnerId)
);

create table DeliveryLogs(
LogId int primary key,
ShipmentId int,
StatusUpdate varchar(100),
UpdateDate date,
foreign key (ShipmentID) references Shipments (ShipmentId)
);

insert into Partners (PartnerId,PartnerName) values
(1,'Bluedart'),
(2,'Delhivery'),
(3,'Ekart'),
(4,'DTDC'),
(5,'IndiaPost');

insert into Shipments (ShipmentId,PartnerId,DestinationCity,PromisedDate,ActualDeliveryDate,Status) values
(101,1,'Warangal','2026-04-10', '2026-04-10', 'Delivered'),
(102,2,'Hanamkonda','2026-04-11', '2026-04-13', 'Delivered'),
(103,3,'Warangal','2026-04-12', '2026-04-15', 'Returned'),
(104,1,'Hyderabad','2026-04-13', '2026-04-13', 'Delivered'),
(105,4,'Bangalore','2026-04-14', '2026-04-18', 'Returned'),
(106,5,'Hyderabad','2026-04-15', '2026-04-15', 'Delivered'),
(107,2,'Warangal','2026-04-16', '2026-04-17', 'Delivered'),
(108,3,'Karimnagar','2026-04-18', '2026-04-18', 'Delivered'),
(109,4,'Chennai','2026-04-19', '2026-04-23', 'Returned'),
(110,5,'Warangal','2026-04-21', '2026-04-21', 'Delivered'),
(111,1,'Hyderabad','2026-04-20','2026-04-25','Delivered'),
(112,3,'Warangal','2026-04-18','2026-04-22','Returned'),
(113,2,'Delhi','2026-04-19','2026-04-19','Delivered');

INSERT INTO DeliveryLogs (LogId, ShipmentId, StatusUpdate, UpdateDate) VALUES
(1, 101, 'Order Picked', '2026-04-08'),
(2, 101, 'In Transit', '2026-04-09'),
(3, 101, 'Out for Delivery', '2026-04-10'),
(4, 101, 'Delivered', '2026-04-10'),

(5, 102, 'Order Picked', '2026-04-09'),
(6, 102, 'In Transit', '2026-04-10'),
(7, 102, 'Delayed in Transit', '2026-04-12'),
(8, 102, 'Delivered', '2026-04-13'),

(9, 103, 'Order Picked', '2026-04-10'),
(10, 103, 'In Transit', '2026-04-11'),
(11, 103, 'Delivery Failed', '2026-04-14'),
(12, 103, 'Returned', '2026-04-15'),

(13, 104, 'Order Picked', '2026-04-11'),
(14, 104, 'Out for Delivery', '2026-04-13'),
(15, 104, 'Delivered', '2026-04-13'),

(16, 105, 'In Transit', '2026-04-13'),
(17, 105, 'Delivery Failed', '2026-04-17'),
(18, 105, 'Returned', '2026-04-18');

-- Delayed Shipment Query
select ShipmentId, PartnerId , DestinationCity, PromisedDate , ActualDeliveryDate
from Shipments
where ActualDeliveryDate > PromisedDate;

-- Performance Ranking
select p.PartnerName,
       s.Status,
       count(*) as TotalCount
from Shipments s
join Partners p on s.PartnerId = p.PartnerId
group by p.PartnerName , s.Status;

-- zone filter
select DestinationCity, count(*) as TotalOrders 
from Shipments
where PromisedDate >= date_sub(curdate(),interval 30 DAY)
group by DestinationCity
order by TotalOrders desc
limit 1;

-- Partner Scorecard
select p.PartnerName,
count(*) as TotalShipments,
sum(case when s.ActualDeliveryDate > s.PromisedDate
     then 1 else 0 end) as DelayedShipments,
sum(case when s.Status = 'Delivered'
    then 1 else 0 end) as SucccessfullDeliveries,
round(sum(case when s.Status = 'Delivered'
  then 1 else 0 end) *100.0 / count(*), 2) as SuccessRate
from Shipments s 
join Partners p on s.PartnerId = p.PartnerId
group by p.PartnerName
order by DelayedShipments asc;