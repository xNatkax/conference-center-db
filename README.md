The database for the conference center was designed based on a **hybrid model**, combining relational and graph elements. Implementation of such a structure allows efficient data management and optimization of information retrieval depending on its nature. 

The **graph structure** includes the following tables, belonging to the *Reservations* schema:
- *Customers (NODE)* - customers who use the services of the conference center,
- *Services (NODE)* - a catalog of services offered by the conference center,
- *Reservations (NODE)* - information about reservations,
- *booked (EDGE)* - relationship linking customers to bookings and event dates,
- *includes (EDGE)* - a relation assigning bookings to services and their quantities.

The **relational part** includes tables belonging to the *Feedback, Events, Orders* and *Inventory* schemas:
- *Reviews* - contains customer feedback on events held at the conference center,
- *CompletedEvents* - stores information about completed events,
- *EventMaterials*- contains information about materials used at specific events,
- *Orders* and *OrderDetails* - contains information about orders of materials used by the conference center during events,
- *Inventory* - contains information about materials used at the conference center, their quantities and minimum levels,
- *LowStockRecords* - contains information about materials used at the conference center, which on a particular day have reached the minimum level and are required to be ordered.

**Full-text indexes** have been implemented in the database in places that require searching by keywords and phrases. This makes it possible to quickly and accurately find information about customers or reservations.

The database uses a document format - **XML** - to store customer registration and contact information, additional customer descriptions and detailed descriptions of complex bookings.

The project includes a set of SQL scripts for creating and comprehensively managing the database:
- *setup-database.sql* - the script allows you to fully create a database, including creating schemas, defining tables and relationships between them;
- *input_sample_data.sql* - the script fills the tables with sample data, which allows you to test security and validate the correctness of commands that operate on data;
- *indexes.sql* - the script implements nonclustered indexes to optimize query performance and full-text indexes to improve information retrieval in descriptive text fields;
- *permissions.sql* - the script allows you to manage the security of the database by defining logins, users and roles and assigning them access rights as required.
- *sample_queries.sql* - prepared sample SQL queries and stored procedures to retrieve data, demonstrate database functionality and facilitate data analysis and report generation;
- *maintenance.sql* - defines administrative procedures including data integrity checks, disaster recovery strategies for the database and updating distribution statistics. The script additionally provides encryption of customer data from the Customers table and audits monitoring access to this table.

Administrative activities have been automated using **SQL Server Agent**.

The automatic deletion of backups older than 30 days has been implemented using cron, because due to the fact that I work on MacOS, I do not have full access to the SQL Server Agent functionality.

**List of functional requirements for the conference center database**
1. The Conference Center is to be able to store selected information about customers (companies, organizations) using its services. This information includes: registration data (company name, TIN ), contact information (headquarters address, telephone number, e-mail address), customer satisfaction survey results and notes from customer contacts.
2. The Conference Center's customer database system should allow authorized employees to add, update, store and search customer data according to selected criteria, such as company/organization name, TIN number and company location.
3. The Conference Center is to be able to store all necessary information about the services offered to customers. Each rented room should contain detailed information such as capacity (in persons), equipment, text description and prices of services.
4. The Conference Center's database of rooms and services should allow authorized employees to search by words or phrases contained in the text description of each item, and to filter results by categories such as room type and availability.
5. The Conference Center should be able to record all reservations in the system. Each reservation should include information such as the date and time of the reservation, details of the customer making the reservation, a list of reserved rooms and services with their schedule, and the total rental price including discount for regular customers (10-15%).
6. Any employee with appropriate rights should be able to view the history of bookings in the system. The history should be available in the form of a report with the ability to export to a CSV file, and should be searchable.
7. The client should be able to store information about completed events in the system. Each completed event should contain data on the number of participants and the number of coffee and catering portions consumed during the event. The system should allow searching completed events.
8. The client should be able to create a catalog of materials used during orders (e.g.: coffee, tea, pastries, beverages, board paper, pens) and monitor stock levels by authorized employees. The system should allow adding new materials and editing existing ones, as well as setting low stock notifications.
9. Stock monitoring should be based on the ability to check the current quantity of each product and enter updates after an event. The system should automatically update the stock after an event, and should also be able to generate reports on material consumption.
10. The material catalog should set a minimum stock level necessary for product renewal. An authorized employee should be able to generate reports with a list of goods that need to be ordered and receive notifications of low inventory at the end of the month.
11. The customer of the conference center should be able to enter ratings (1-5 stars) and text comments on the orders carried out. The feedback database should allow it to be searched by authorized employees by specific words or phrases.
12. Users such as salesman, procurement, contractor, social media specialist and manager should be defined in the system. Responsibilities and available functions should be defined for each role.
13. The salesperson should have access to all data except customer feedback and stock status. The procurement officer should have access to the data on stock status and catalog of goods. The contractor should only have access to orders (fulfillment and event schedule). The social media specialist should have access to customer reviews and customer data. The manager should have read-only access to all data.

**List of non-functional requirements for the conference center database**
1. The system should be scalable and support potential growth in the number of customers, rooms, services and bookings. It should be able to dynamically increase resources as the load increases without affecting the performance of the system.
2. The system must ensure the security of customer and booking data in accordance with RODO regulations. All personal customer data must be encrypted. Access to the system should be controlled by authorization and authentication mechanisms.
3. Searches for customers, rooms, services and reviews should take no more than 2 seconds for standard queries and 5 seconds for more complex queries.
4. The database must have regular backups of the data at least once a day with the possibility of quick restoration in case of failure. The restoration process should be completed in no more than 1 hour from the moment the failure is reported. The system should keep backups for 30 days.
