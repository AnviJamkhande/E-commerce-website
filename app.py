import mysql.connector

# Establish a connection to your MySQL database
conn = mysql.connector.connect(
    host='localhost',  # Replace 'your_host' with the actual hostname
    user='root',  # Replace 'your_username' with the actual username
    password='12345678',  # Replace 'your_password' with the actual password
    database='ecommerceprojmine'
)

# Create a cursor object to execute SQL queries
cursor = conn.cursor()

# Example query to fetch data from the Artisans table
cursor.execute("SELECT * FROM Artisans")
artisans_data = cursor.fetchall()

# Close cursor and connection when done
cursor.close()
conn.close()


from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    # Use artisans_data or other fetched data to render your Flash frontend
    return render_template('index.html', artisans=artisans_data)

if __name__ == '__main__':
    app.run(debug=True)
