# encoding=utf-8
from flask import Flask
from utils.config import AppConfig
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config.from_object(AppConfig)
db = SQLAlchemy(app)
db.init_app(app)

from views import *



if __name__ == '__main__':
    app.run(debug=True)
