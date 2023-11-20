import yaml
from flask import Flask, render_template, request
from flask_mysqldb import MySQL

app = Flask(__name__)
app.secret_key = "this@is@my@secret"

# Configure database
from yaml import Loader

with open('database.yaml', 'r') as yamlfile:
    db = yaml.load(yamlfile, Loader=Loader)

app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']
my_sql = MySQL(app)
from market import routes



