from database.database import get_db


class TelephoneService:

    @staticmethod
    def get_all():
        db = get_db()
        return db.execute(
            "SELECT telephones.id_telephone, telephones.model, COUNT(employee_telephone.id_telephone) AS count FROM employee_telephone  RIGHT JOIN telephones ON (telephones.id_telephone = employee_telephone.id_telephone) GROUP BY telephones.id_telephone"
        ).fetchall()

    @staticmethod
    def get_by_id(id: int):
        db = get_db()
        return db.execute(
            "SELECT * FROM telephones WHERE id_telephone = ?",
            [id]
        ).fetchone()

    @staticmethod
    def search(name: str):
        db = get_db()
        return db.execute("SELECT * FROM telephones WHERE model ILIKE '%?%'", [name]).fetchall()
    
    @staticmethod
    def insert_telephone(model, workload, price_constant):
        db = get_db()
        db.execute(
            'INSERT INTO telephones (model, workload, price_constant) VALUES (?, ?, ?)',
            [model, workload, price_constant]
        )
        db.commit()
        
    @staticmethod
    def get_telephones_made_by(id):
        db = get_db()
        
        return db.execute("""SELECT * FROM employee_telephone
                   JOIN employees ON (employee_telephone.id_employee = employees.id_employee)
                   JOIN telephones ON (employee_telephone.id_telephone = telephones.id_telephone)
                   WHERE employees.id_user = ?""", [id]).fetchall()
    @staticmethod
    def get_telephone_count(id):
        db = get_db()
        
        return db.execute("SELECT count(*) AS count FROM employee_telephone WHERE id_telephone = ?", [id]).fetchone()
    
    @staticmethod
    def get_units(id):
        db = get_db()
        
        return db.execute("SELECT * FROM employee_telephone JOIN employees ON (employees.id_employee = employee_telephone.id_employee) JOIN users ON (users.id_user = employees.id_user) WHERE employee_telephone.id_telephone = ?", [id]).fetchall()
    
    @staticmethod
    def delete_latest(id):
        db = get_db()
        
        db.execute("delete from employee_telephone WHERE serial_number = (select max(serial_number) from employee_telephone WHERE id_telephone = ?)", [id])
        db.commit()