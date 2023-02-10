from database.database import get_db

class ComponentService:
    
    @staticmethod
    def get_all():
        db = get_db()    
        return db.execute("SELECT * FROM components").fetchall()
    
    @staticmethod
    def get_by_id(id):
        db = get_db()
        return db.execute("SELECT * FROM components WHERE id_component = ?", [id]).fetchone()
    
    @staticmethod
    def get_telephone_components(id):
        db = get_db()
        
        return db.execute("SELECT components.id_component as id_component, components.name as name, sum(component_telephone.piece_count) as piece_count, components.price as price FROM component_telephone  JOIN telephones ON (telephones.id_telephone = component_telephone.id_telephone) JOIN components ON (components.id_component = component_telephone.id_component)  where component_telephone.id_telephone = ? GROUP BY components.id_component", [id]).fetchall()
    
    @staticmethod
    def change_count(id, count):
        db = get_db()
        db.execute("UPDATE components SET pieces_available = ? WHERE id_component = ?", [count, id])
        
        db.commit()
    @staticmethod    
    def new_component(name, price, pieces_available):
        db = get_db()
        
        db.execute("INSERT INTO components (name, price, pieces_available) VALUES (?, ?, ?)", [name, price, pieces_available])
        
        db.commit()
        
    @staticmethod
    def delete_component(id):
        db = get_db()
        
        db.execute("DELETE from components WHERE id_component = ?", [id])
        db.commit()
        
    @staticmethod
    def get_telephones_with_component(id):
        db = get_db()
        return db.execute("select * from component_telephone join components on (components.id_component = component_telephone.id_component) join telephones on (component_telephone.id_telephone = telephones.id_telephone) where components.id_component = ?", [id]).fetchall()
    
    @staticmethod
    def add_component_to_telephone(id_component, count, id_telephone):
        db = get_db()
        
        db.execute("INSERT INTO component_telephone (id_telephone, id_component, piece_count) VALUES (?, ?, ?)", [id_telephone, id_component, count])
        db.commit()