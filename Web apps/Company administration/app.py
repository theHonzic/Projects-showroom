from flask import Flask
from database import database
from views.auth import auth_bp
from views.homepage import homepage
from views.telephones import telephones
from views.users import users
from views.orders import orders
from views.work import work
from views.components import components

app = Flask(__name__)
app.config['DEBUG'] = True
app.config.from_object('config')
database.init_app(app)

app.register_blueprint(homepage, url_prefix='/')
app.register_blueprint(auth_bp, url_prefix='/auth')
app.register_blueprint(telephones, url_prefix='/telephones')
app.register_blueprint(users, url_prefix='/users')
app.register_blueprint(orders, url_prefix='/orders')
app.register_blueprint(work, url_prefix='/work')
app.register_blueprint(components, url_prefix="/components")

if __name__ == '__main__':
    app.run('0.0.0.0', port=5001, debug=True)
