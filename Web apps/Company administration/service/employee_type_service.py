from database.database import get_db

class EmployeeTypeService:
    @staticmethod
    def get_all():
        db = get_db()
        return db.execute("SELECT * FROM employee_types").fetchall()