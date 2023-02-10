import hashlib
from database.database import get_db
import config

class UserService():
        
    @staticmethod
    def get_users():
        db = get_db()
        return db.execute("SELECT * FROM users LEFT JOIN employees ON users.id_user = employees.id_user LEFT JOIN employee_types ON employee_types.id_employee_type = employees.employee_type_id").fetchall()
    
    @staticmethod
    def get_user(id):
        db = get_db()
        return db.execute("SELECT * FROM users LEFT JOIN employees ON users.id_user = employees.id_user LEFT JOIN employee_types ON employee_types.id_employee_type = employees.employee_type_id WHERE users.id_user = ?", [id]).fetchone()
    
    @staticmethod
    def get_employees():
        db = get_db()
        return db.execute(
            "SELECT * FROM employees JOIN users ON employees.id_user = users.id_user"
        ).fetchall()
    

        
    @staticmethod
    def get_employee_by_id(id):
        db = get_db()
        return db.execute(
            "SELECT * FROM employees JOIN users ON employees.id_user = users.id_user JOIN employee_types ON employees.employee_type_id = employee_types.id_employee_type WHERE users.id_user = ?",
            [id]).fetchone()
        
    
    @staticmethod
    def search_employees_by_name(text):
        db = get_db()
        
        sql = "SELECT * FROM employees JOIN users ON employees.id_user = users.id_user WHERE LOWER(users.first_name) LIKE LOWER(?) OR LOWER(users.last_name) LIKE LOWER(?)"
        arguments = []
        arguments.append('%' + text + '%')
        return db.execute(sql, arguments).fetchall()

    @staticmethod
    def edit_employee(id_user, first_name, last_name, email, phone_number, hourly_wage, role, confirm):
        db = get_db()
        db.execute("""UPDATE users SET first_name = ?,
                   last_name = ?,
                   email = ?,
                   phone_number = ?,
                   registration_completed = ?
                    WHERE id_user = ?""", [first_name, last_name, email, phone_number, confirm, id_user])
        db.commit()
        db.execute("""UPDATE employees SET hourly_wage = ?,
                   employee_type_id = ?
                    WHERE id_user = ?
                         """, [hourly_wage, role, id_user])
        db.commit()
    
    
    @staticmethod
    def edit_customer(id_user, first_name, last_name, email, phone_number, confirm):
        db = get_db()
        db.execute("""UPDATE users SET first_name = ?,
                   last_name = ?,
                   email = ?,
                   phone_number = ?,
                   registration_completed = ?,
                   blocked = ?
                    WHERE id_user = ?""", [first_name, last_name, email, phone_number, confirm, 0, id_user])
        db.commit()
        
    @staticmethod
    def add_customer(first_name, last_name, email, phone_number, password):
        db = get_db()
        
        db.execute("INSERT INTO users (first_name, last_name, phone_number, email, password, registration_completed, blocked) VALUES (?, ?, ?, ?, ?, ?, 0)", [first_name, last_name, phone_number, email, password, "0"])
        db.commit()
    
    @staticmethod    
    def add_employee(first_name, last_name, email, phone_number, password, hourly_wage, role):
        db = get_db()
        user_id = db.execute("INSERT INTO users (first_name, last_name, email, phone_number, password, registration_completed, blocked) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id_user", [first_name, last_name, email, phone_number, password, 1]).fetchone()

        id = user_id['id_user']
        db.commit()
        
        db.execute("INSERT INTO employees (id_user, hourly_wage, employee_type_id) VALUES (?, ?, ?)", [id, hourly_wage, str(role)])
        
        db.commit()   
        
         
    @staticmethod
    def complete_customer_registration(id):
        db = get_db()
        
        db.execute("UPDATE users SET registration_completed = 1 WHERE id_user = ?", [id])
        db.commit()
        
    
    @staticmethod
    def delete_user(id):
        db = get_db()
        
        user = db.execute("SELECT * FROM employees WHERE id_user = ?", [id]).fetchone()
        
        if user == None:
            db.execute("DELETE FROM users WHERE id_user = ?", [id])
        else:
            db.execute("DELETE FROM employees WHERE id_user = ?", [id])
            db.execute("DELETE FROM users WHERE id_user = ?", [id])
        db.commit()
        
        
    @staticmethod
    def block(value, id):
        db = get_db()
        
        db.execute("UPDATE users SET blocked = ? WHERE id_user = ?", [value, id])
        
        db.commit()
    
    ## User Verification
    @staticmethod
    def verify(email, password):
        db = get_db()
        hashed_password = hashlib.sha256(password.encode()+config.PASSWORD_SALT.encode()).hexdigest()

        user = db.execute('''
            SELECT employees.id_employee as id_employee, users.id_user AS id_user, users.first_name AS first_name, users.last_name AS last_name, users.email AS email, employee_types.role AS role, employee_types.administrator_rights AS admin, users.registration_completed AS registration_completed, users.blocked AS blocked
            FROM users 
            LEFT JOIN employees ON (employees.id_user = users.id_user)
            LEFT JOIN employee_types ON (employees.employee_type_id = employee_types.id_employee_type)
			WHERE users.email = ? AND users.password = ?''',[email, hashed_password]).fetchone()
        if user:
            return user
        else:
            return None
        
    @staticmethod
    def work(id_employee, id_telephone, hours_spent):
        db = get_db()
        
        db.execute("INSERT INTO employee_telephone (id_employee, id_telephone, hours_spent) VALUES (?, ?, ?)", [id_employee, id_telephone, hours_spent])
        db.commit()