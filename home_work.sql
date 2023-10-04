join_db                         // DATABASE

        emails                                        
                CREATE TABLE                    
        users                                          
                FOREIGN KEY email_id
                        users -> id  => result: email title
        fruits                                      
                FOREIGN KEY created_by_user_id
                        fruits -> id => result: user_name, email_title
        courses                                 
                FOREIGN KEY created_by_user_id
                        courses -> id => result: course_title, user_name, email_title,
                        teacher_name, teacher_surname
        teachers
                FOREIGN KEY created_by_user_id
        company
                FOREIGN KEY created_by_user_id
                        company -> email_id => result: company_title, company_email,
                        user_name, user_email 
        employess
                FOREIGN KEY created_by_user_id
                FOREIGN KEY company_id
                        employess -> id => result: user_name, user_email,
                        company_title, company_email
        cars 
                FOREIGN KEY created_by_user_id
                FOREIGN KEY company_id
                        cars -> id => result: car_title, user_name, user_email,
                        company_title, company_email
        customers
                FOREIGN KEY employe_id
                FOREIGN KEY company_id
                FOREIGN KEY car_id
                        customers -> id => result: company_title, company_email, 
                        car_title, employe_id -> tegishli -> user_email;


CREATE DATABASE join_db;

-- emails
CREATE TABLE emails(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            title VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO emails(title)
            VALUES('user1@mail.com'),
            ('user2@mail.com'),
            ('user3@mail.com');

SELECT * FROM emails;

-- users
CREATE TABLE USERS(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            user_name VARCHAR(50) NOT NULL,
            email_id VARCHAR(50) UNIQUE NOT NULL,
            CONSTRAINT fk_user_email
            FOREIGN KEY(email_id) 
	    REFERENCES emails(id)
);

INSERT INTO users(user_name, email_id)
            VALUES('dilshodbek', '45ee0197-89e7-40a6-a703-13759cf1e035'),
            ('lochinbek', '1997704c-c6fe-48e5-8c11-b53b21b419f0'),
            ('ismoil', '8f030e5e-f2cf-46bb-b11b-9b0e4704709f');

SELECT e.title FROM users u JOIN emails e ON e.id = u.email_id WHERE u.id = 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba';

-- fruits
CREATE TABLE fruits(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            fruit_name VARCHAR(50) NOT NULL,
            fruit_price VARCHAR(50) NOT NULL,
            fruit_description TEXT,
            created_by_user_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id)
);

INSERT INTO fruits(fruit_name, fruit_price, fruit_description, created_by_user_id)
            VALUES('peach', '7000', 'delicious peach', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba'),
            ('apple', '5000', 'delicious apple', '59597d98-a230-4065-9d8a-5cb871f02de7'),
            ('pomegranate', '10000', 'delicious pomegranate', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a');

SELECT u.user_name, e.title FROM fruits f JOIN users u ON u.id = f.created_by_user_id 
JOIN emails e ON e.id = u.email_id WHERE u.id = 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba';

-- courses
CREATE TABLE courses(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            title VARCHAR(50) NOT NULL,
            price VARCHAR(50) NOT NULL,
            course_description TEXT,
            created_by_user_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id)
);

INSERT INTO courses(title, price, course_description, created_by_user_id)
            VALUES('react', '800000', 'react lesson', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba'),
            ('vue', '800000', 'vue lesson', '59597d98-a230-4065-9d8a-5cb871f02de7'),
            ('angular', '800000', 'angular lesson', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a');

SELECT c.title, u.user_name, e.title, t.teacher_name, t.teacher_surname FROM courses c JOIN users u ON u.id = c.created_by_user_id 
JOIN emails e ON e.id = u.email_id JOIN teachers t ON t.created_by_user_id = u.id
WHERE u.id = 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba';

-- teachers
CREATE TABLE teachers(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            teacher_name VARCHAR(50) UNIQUE NOT NULL,
            teacher_surname VARCHAR(50) NOT NULL,
            created_by_user_id VARCHAR(50) UNIQUE NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id)
);

INSERT INTO teachers(teacher_name, teacher_surname, created_by_user_id)
            VALUES('dilshodbek', 'komilov', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba'),
            ('lochinbek', 'quvondiqov', '59597d98-a230-4065-9d8a-5cb871f02de7'),
            ('ismoil', 'abdujalilov', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a');

-- company
CREATE TABLE company(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            company_name VARCHAR(50) NOT NULL,
            company_email VARCHAR(50) NOT NULL,
            created_by_user_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id)
);

INSERT INTO company(company_name, company_email, created_by_user_id)
            VALUES('najot ta`lim', 'najotTa`lim@mail.com', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba'),
            ('IT House', 'itHouse@mail.com', '59597d98-a230-4065-9d8a-5cb871f02de7'),
            ('Education', 'education@mail.com', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a');

SELECT c.company_name, company_email, u.user_name, e.title FROM company c 
JOIN users u ON u.id = c.created_by_user_id
JOIN emails e ON e.id = u.email_id WHERE u.email_id = '45ee0197-89e7-40a6-a703-13759cf1e035';

-- employees
CREATE TABLE employees(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            employee_name VARCHAR(50) UNIQUE NOT NULL,
            created_by_user_id VARCHAR(50) NOT NULL,
            company_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id),
            CONSTRAINT fk_created_by_company
            FOREIGN KEY(company_id) 
	    REFERENCES company(id)
);

INSERT INTO employees(employee_name, created_by_user_id, company_id)
            VALUES('dilshodbek', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba',
                                 '186e3b5e-034b-454f-b8e2-9a1d3746868c'),
            ('lochinbek', '59597d98-a230-4065-9d8a-5cb871f02de7', 
                                 '79b5e3e6-c687-4e9d-a6d8-a591904798ee'),
            ('ismoil', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a', 
                                 'dabfe92b-da9f-4edd-a800-ee71942b5ea6');

SELECT u.user_name, emails.title, c.company_name, c.company_email FROM employees e 
JOIN users u ON u.id = e.created_by_user_id
JOIN emails ON emails.id = u.email_id
JOIN company c ON c.id = e.company_id WHERE e.id = '149fe723-eb35-401b-b681-314fd0dbe077';

-- cars
CREATE TABLE cars(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            car_title VARCHAR(50) NOT NULL,
            created_by_user_id VARCHAR(50) NOT NULL,
            company_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_user_id) 
	    REFERENCES users(id),
            CONSTRAINT fk_created_by_company
            FOREIGN KEY(company_id) 
	    REFERENCES company(id)
);

INSERT INTO cars(car_title, created_by_user_id, company_id)
            VALUES('malibu', 'c51f1af0-a6ff-4028-a6b7-f26b045c87ba', '186e3b5e-034b-454f-b8e2-9a1d3746868c'),
            ('cobalt', '59597d98-a230-4065-9d8a-5cb871f02de7', '79b5e3e6-c687-4e9d-a6d8-a591904798ee'),
            ('mercedes-benz', '1052777b-b2ae-46f5-92a5-6a5dd6617f0a', 'dabfe92b-da9f-4edd-a800-ee71942b5ea6');

SELECT c.car_title, u.user_name, e.title, company_name, company_email FROM cars c 
JOIN users u ON u.id = c.created_by_user_id
JOIN emails e ON e.id = u.email_id
JOIN company ON company.id = c.company_id WHERE c.id = 'ffa9d942-ad39-4e6d-9f6b-6b35290a1264';

-- customers
CREATE TABLE customers(
            id VARCHAR UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
            customer_name VARCHAR(50) UNIQUE NOT NULL,
            created_by_employee_id VARCHAR(50) NOT NULL,
            company_id VARCHAR(50) NOT NULL,
            car_id VARCHAR(50) NOT NULL,
            CONSTRAINT fk_created_by
            FOREIGN KEY(created_by_employee_id) 
	    REFERENCES employees(id),
            CONSTRAINT fk_created_by_company
            FOREIGN KEY(company_id) 
	    REFERENCES company(id),
            CONSTRAINT fk_created_by_car
            FOREIGN KEY(car_id) 
	    REFERENCES cars(id)
);

INSERT INTO customers(customer_name, created_by_employee_id, company_id, car_id)
            VALUES('sherzodbek', '149fe723-eb35-401b-b681-314fd0dbe077', '186e3b5e-034b-454f-b8e2-9a1d3746868c',
            'ffa9d942-ad39-4e6d-9f6b-6b35290a1264'),
            ('oyatilla', 'e5cc6e01-dcad-4234-9e11-14fdbc6f247c', '79b5e3e6-c687-4e9d-a6d8-a591904798ee',
            'a23a4fc2-dba8-46ce-abd4-a2257503e9fc'),
            ('nurullo', 'fe799fed-35e6-4781-9cb6-f1676d8dae2e', 'dabfe92b-da9f-4edd-a800-ee71942b5ea6',
            '4c3018cc-d9ea-44bc-99d2-2b7477f8fb2e');

SELECT com.company_name, com.company_email, cars.car_title, u.user_name, e.title 
FROM customers cus 
JOIN company com ON com.id = cus.company_id
JOIN cars ON cars.id = cus.car_id
JOIN users u ON com.created_by_user_id = u.id
JOIN emails e ON e.id = u.email_id
JOIN employees emp ON emp.id = cus.created_by_employee_id
WHERE emp.id = '149fe723-eb35-401b-b681-314fd0dbe077';

