from backend.app import app
from flaskext.mysql import MySQL

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Wimg780523'
app.config['MYSQL_DATABASE_DB'] = 'giraffe'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)