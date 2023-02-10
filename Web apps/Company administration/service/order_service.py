from database.database import get_db

class OrderService:
    @staticmethod
    def get_all():
        db = get_db()
        return db.execute("SELECT * FROM orders LEFT JOIN users ON (users.id_user = orders.id_user) ORDER BY processed, id_order").fetchall()
        
    @staticmethod    
    def get_by_id(id: int):
        db = get_db()
        return db.execute("SELECT * FROM orders WHERE id_order = ?", [id]).fetchone()

    @staticmethod
    def dispatch_order(id):
        db = get_db()
        db.execute("UPDATE orders SET processed = 1 WHERE id_order = ?", [id])
        db.commit()
        
    @staticmethod
    def get_ordered_items(id):
        db = get_db()
        return db.execute("SELECT * FROM telephone_order JOIN telephones ON (telephone_order.id_telephone = telephones.id_telephone) WHERE telephone_order.id_order = ?", [id]).fetchall()
        
    @staticmethod
    def buy(id_user, id_telephone, piece_count):
        db = get_db()
        
        order = db.execute("INSERT INTO orders (id_user, processed) VALUES (?, 0) returning id_order", [id_user]).fetchone()
        id_order = order['id_order']
        db.commit()
        
        db.execute("INSERT INTO telephone_order (id_order, id_telephone, piece_count) values (?, ?, ?)", [id_order, id_telephone, piece_count])
        db.commit()