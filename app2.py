from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

# Establishing a connection with MySQL
def connect_to_db():
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='12345678',
        database='ecommerceprojmine'
    )
    return conn

# Error handling for database operations
def execute_query(query, data=None):
    conn = connect_to_db()
    cursor = conn.cursor()

    try:
        if data:
            cursor.execute(query, data)
        else:
            cursor.execute(query)
        conn.commit()
        return True
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        conn.rollback()
        return False
    finally:
        cursor.close()
        conn.close()

@app.route('/', methods=['GET'])
def index():
    # Fetch artisan names from the Artisans table
    conn = connect_to_db()
    cursor = conn.cursor()
    query = "SELECT Name FROM Artisans"
    cursor.execute(query)
    artisan_names = [row[0] for row in cursor.fetchall()]
    cursor.close()
    conn.close()

    return render_template('add_display_artisan.html', artisan_names=artisan_names)

@app.route('/add_artisan', methods=['POST'])
def add_artisan():
    if request.method == 'POST':
        name = request.form['name']
        age = int(request.form['age']) if request.form['age'].isdigit() else None
        product = request.form['product']

        # Inserting new artisans into the Artisans table in MySQL
        insert_query = "INSERT INTO Artisans (Name, Age, Product) VALUES (%s, %s, %s)"
        data = (name, age, product)

        if execute_query(insert_query, data):
            return 'Artisan added successfully!'
        else:
            return 'Failed to add artisan'

    return 'Invalid request'


@app.route('/display_all_artisans', methods=['GET'])
def display_all_artisans():
    conn = connect_to_db()
    cursor = conn.cursor()

    # Fetching all information from the Artisans table
    select_query = "SELECT ID, Name, Age, Product FROM Artisans"
    cursor.execute(select_query)
    artisans_data = cursor.fetchall()

    cursor.close()
    conn.close()
    print(artisans_data)  # Add this line to your Flask route before rendering the template

    return render_template('index.html', artisans=artisans_data)

if __name__ == '__main__':
    app.run(debug=True)
