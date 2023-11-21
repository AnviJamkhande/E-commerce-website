from http.client import HTTPResponse
from xml.dom.expatbuilder import FragmentBuilder
from flask import flash, redirect, render_template, request, url_for
from pyparsing import nums
from market import my_sql
from market import app
import random
from datetime import datetime,date


cart_id=0
total_val=0
total_count=0
customer_cart_list=[]

@app.route('/admin/<admin_id>')
def adminRedirect(admin_id):
    return render_template('adminOption.html',admin_id=admin_id)

@app.route('/adminSales/<admin_id>', methods=['GET', 'POST'])
def salesstats(admin_id):
    my_list = []
    cur = my_sql.connection.cursor()
    sales_list = cur.execute("SELECT retails.Artisan_ID, artisan.First_Name, Artisan.Last_Name, count(product.Category_ID) AS No_Of_Categories_Sold, SUM(retails.No_of_Product_Sold) as Total_Products_Sold, SUM(Product.price * retails.No_of_Product_Sold) AS Total_Sales_Done, AVG(Product.price * retails.No_of_Product_Sold) AS Average_Sale_Per_Order FROM retails JOIN artisan JOIN product WHERE retails.Artisan_ID=artisan.Artisan_ID AND product.Product_ID=retails.Product_ID GROUP BY Artisan_ID ORDER BY Artisan_ID")
    if sales_list > 0:
        sales_all = cur.fetchall()
        for sale in sales_all:
            temp_dict = {}
            for index in range(7): #add range
                if index == 1:
                    temp_dict['FirstName'] = sale[1]
                elif index == 2:
                    temp_dict['LastName'] = sale[2]
                elif index == 3:
                    temp_dict['No_Of_cat_sold'] = sale[3]
                elif index == 4:
                    temp_dict['Tot_Prods'] = sale[4]
                elif index == 5:
                    temp_dict['Tot_Sales'] = sale[5]
                elif index == 6:
                    temp_dict['Avg_per_sale'] = sale[6]
            my_list.append(temp_dict)
    if request.method=='POST':
        return redirect('/admin/'+str(admin_id))
    return render_template('sales.html',list=my_list)

@app.route('/adminOrder/<admin_id>',methods=['GET', 'POST'])
def adminViewOrder(admin_id):
    my_list =[]
    cur = my_sql.connection.cursor()
    order_list = cur.execute("SELECT * FROM orders")
    if order_list>0:
        order_all = cur.fetchall()
        for order in order_all:
            temp_dict = {}
            for index in range(11):
                if(index==0):
                    temp_dict['Order_ID']=order[0]
                elif(index==1):
                    temp_dict['Mode']=order[1]
                elif(index==2):
                    temp_dict['Amount']=order[2]
                elif(index==9):
                    temp_dict['Date']=order[9]
            my_list.append(temp_dict)
    if request.method=='POST':
        return redirect('/admin/'+str(admin_id))
    return render_template('viewOrder.html',list=my_list)


@app.route('/adminSeller/<admin_id>',methods=['GET', 'POST'])
def adminAdd_Seller(admin_id):
    if request.method=='POST':
        Seller_Details = request.form
        First_Name = Seller_Details['First_Name']
        Last_Name = Seller_Details['Last_Name']
        Email = Seller_Details['Email']
        Phone_Number = Seller_Details['Phone_Number']
        Password = Seller_Details['Password']
        Place_Of_Operation = Seller_Details['Place_Of_Operation']
        cur = my_sql.connection.cursor()
        cur.execute("INSERT INTO artisan(First_Name,Last_Name,Email,Phone_Number,Password,Place_Of_Operation,Admin_ID) VALUES(%s, %s, %s, %s, %s,%s,%s)",(First_Name,Last_Name,Email,Phone_Number,Password,Place_Of_Operation,admin_id))
        flash('You have successfully added an artisan !')
        my_sql.connection.commit()
        cur.close()
    return render_template('addSeller.html',admin_id=admin_id)

@app.route('/adminProduct/<admin_id>',methods=['GET', 'POST'])
def adminAdd_Product(admin_id):
    if request.method=='POST':
        Product_Details = request.form
        Name = Product_Details['Name']
        Price = Product_Details['Price']
        Artisan_name= Product_Details['Artisan_name']
        Description = Product_Details['Description']
        Category_ID = Product_Details['Category_ID']
        cur = my_sql.connection.cursor()
        cur.execute("INSERT INTO product(Name,Price,Artisan_name,Admin_ID,Category_ID,Description) VALUES(%s, %s, %s, %s, %s,%s)",(Name,Price,Artisan_name,admin_id,Category_ID,Description))
        flash('You have successfully added a Product !')
        my_sql.connection.commit()
        cur.close()
    return render_template('addNewProducts.html',admin_id=admin_id)

@app.route('/sell/<seller_id>',methods=['GET', 'POST'])
def sell(seller_id):
    if request.method=='POST':
        ProdDetail = request.form
        Name = ProdDetail['Name']
        Brand = ProdDetail['Brand']
        Quantity = ProdDetail['Quantity']
        cur = my_sql.connection.cursor()
        prod_list = cur.execute("SELECT * FROM product")
        if prod_list>0:
            prod_all = cur.fetchall()
            c_tup = ()
            for tup in prod_all:
                if(tup[1]==Name and tup[3]==Brand):
                    c_tup = tup
                    break
            if c_tup==() or int(Quantity)<0:
                flash('Invalid Product details or Quantity')
            else:
                cur.execute("INSERT INTO retails(Artisan_ID,Product_ID,No_of_Product_Sold) VALUES(%s, %s, %s)",(seller_id,tup[0],Quantity))
                my_sql.connection.commit()
                cur.close()
                flash('Product added successfully ')
    return render_template('addProduct.html')


def reinitialize():
    global cart_id
    global total_count
    global total_val
    global customer_cart_list
    cart_id = StaticClass.giveCartId()
    total_val=0
    total_count=0
    customer_cart_list=[]

@app.route('/home/<user_id>', methods=['GET', 'POST'])
def userEnter(user_id):
    my_list =[]
    global cart_id
    global total_count
    global total_val
    global customer_cart_list
    cur = my_sql.connection.cursor()
    product_list = cur.execute("SELECT * FROM product")
    if product_list>0:
        product_all = cur.fetchall()
        for prod in product_all:
            temp_dict = {}
            for index in range(1,4):
                if(index==1):
                    temp_dict['Name']=prod[1]
                elif(index==2):
                    temp_dict['Price']=prod[2]
                else:
                    temp_dict['Brand']=prod[6]
            my_list.append(temp_dict)
    if request.method=='POST':
        cur = my_sql.connection.cursor()
        f_amt = total_val
        cur.execute("INSERT INTO cart(Cart_ID,Total_Value,Total_Count,Final_Amount) VALUES(%s, %s, %s, %s)",(cart_id,total_val,total_count,f_amt))
        my_sql.connection.commit()
        cur.close()
        url_direct = '/order'+'/'+str(user_id)
        return redirect(url_direct)
    else:
        purchaseDetails = request.args
        try:
            Name = purchaseDetails['Name']
            Brand = purchaseDetails['Brand']
            Price = purchaseDetails['Price']
            total_count=total_count+1
            total_val=total_val+int(Price)
            temp_dict = {}
            temp_dict['Name']=Name
            temp_dict['Brand']=Brand 
            temp_dict['Price']=Price
            customer_cart_list.append(temp_dict)
            flash('Product has been added successfully to the cart !')
        except KeyError:
            tempError = "Error: KeyError"
    return render_template('home.html',list=my_list)


@app.route('/order/<user_id>',methods=['GET','POST'])
def placeOrder(user_id):
    global cart_id
    global customer_cart_list
    if request.method=='POST':
        for item in customer_cart_list:
            product_name = item['Name']
            cur = my_sql.connection.cursor()
            prod_list = cur.execute("SELECT * FROM product")
            if prod_list>0:
                prod_all = cur.fetchall()
                id = -1
            for tup in prod_all:
                if(tup[1]==product_name):
                    id = tup[0]
                    break
            cur.execute("INSERT INTO associatedWith(Company_ID,Cart_ID,Product_ID) VALUES(%s, %s, %s)",(user_id,cart_id,id))
            my_sql.connection.commit()
            cur.close()
        return redirect('/placeOrder'+'/'+str(user_id))
    return render_template('order.html',list=customer_cart_list,user_id=user_id)


@app.route('/HomePage')
@app.route('/')
def homePage():
    return render_template('homepage.html')

@app.route('/loginRegisterSeller')
def loginRegisterSeller():
    return render_template('loginregisterSeller.html')

@app.route('/loginRegisterUser')
def loginRegisterUser():
    return render_template('loginregisterUser.html')

@app.route('/loginRegisterAdmin')
def loginRegisterAdmin():
    return render_template('loginregisterAdmin.html')

@app.route('/placeOrder/<user_id>',methods=['GET','POST'])
def order_placing(user_id):
    global total_val
    if request.method=='POST':
        orderDetails = request.form
        HNO = orderDetails['HNO']
        City = orderDetails['City']
        State = orderDetails['State']
        Pincode = orderDetails['Pincode']
        Mode = orderDetails['Mode']
        curr_date = date.today()
        now = datetime.now()
        current_time = now.strftime("%H:%M:%S")
        cur = my_sql.connection.cursor()
        cur.execute("INSERT INTO orders(Mode,Amount,City,State,Order_Time,House_Flat_No,Pincode,Cart_ID,Date) VALUES(%s, %s, %s, %s, %s,%s,%s,%s,%s)",(Mode,total_val,City,State,current_time,HNO,Pincode,cart_id,curr_date))
        flash('Your Order has been placed Successfully !')
        my_sql.connection.commit()
        cur.close()
    return render_template('orderDetails.html',total_val=total_val)

@app.route('/customerRegister',methods=['GET','POST'])
def customerRegister():
    if request.method=='POST':
        custDetails = request.form
        First_Name = custDetails['First_Name']
        Last_Name = custDetails['Last_Name']
        Email = custDetails['Email']
        Mobile_No = custDetails['Mobile_No']
        Password = custDetails['Password']
        cur = my_sql.connection.cursor()
        cur.execute("INSERT INTO company(First_Name,Last_Name,Email,Mobile_No,Password) VALUES(%s, %s, %s, %s, %s)",(First_Name,Last_Name,Email,Mobile_No,Password))
        flash('You have registered successfully !')
        my_sql.connection.commit()
        cur.close()
    return render_template('customerRegister.html')

@app.route('/adminRegister',methods=['GET','POST'])
def adminRegister():
    if request.method=='POST':
        custDetails = request.form
        First_Name = custDetails['First_Name']
        Last_Name = custDetails['Last_Name']
        Password = custDetails['Password']
        cur = my_sql.connection.cursor()
        cur.execute("INSERT INTO admin(First_Name,Last_Name,Admin_Password) VALUES(%s, %s, %s)",(First_Name,Last_Name,Password))
        flash('You have registered successfully !')
        my_sql.connection.commit()
        cur.close()
    return render_template('adminRegister.html')

@app.route('/sellerRegister',methods=['GET','POST'])
def sellerRegister():
    if request.method=='POST':
        sellerDetails = request.form
        First_Name = sellerDetails['First_Name']
        Last_Name = sellerDetails['Last_Name']
        Email = sellerDetails['Email']
        Password = sellerDetails['Password']
        Mobile_No = sellerDetails['Phone_Number']
        POO = sellerDetails['Place_Of_Operation']
        cur = my_sql.connection.cursor()
        rand_admin = cur.execute("SELECT Admin_ID FROM admin")
        if rand_admin >0:
            rand_ad = cur.fetchall()
            F_key = random.choice(rand_ad)
            cur.execute("INSERT INTO artisan(First_Name,Last_Name,Email,Phone_Number,Password,Place_Of_Operation,Admin_ID) VALUES(%s, %s, %s,%s,%s,%s, %s)",(First_Name,Last_Name,Email,Mobile_No,Password,POO, F_key))
            flash('You have registered successfully !')
        my_sql.connection.commit()
        cur.close()
    return render_template('sellerRegister.html')
        
@app.route('/UserLogin',methods=['GET','POST'])
def UserLogin():
    if request.method=='POST':
        userDetail = request.form
        Email = userDetail['Email']
        Password = userDetail['Password']
        cur = my_sql.connection.cursor()
        cust_list = cur.execute("SELECT * FROM company")
        if cust_list>0:
            cust_all = cur.fetchall()
            c_tup = ()
            for tup in cust_all:
                if(tup[3]==Email):
                    c_tup = tup
                    break
            if c_tup==() or Password!=c_tup[5]:
                flash('Invalid Email or Password')
            else:
                reinitialize()
                url_direct = '/home'+'/'+str(c_tup[0])
                return redirect(url_direct)
    return render_template('UserLogin.html')

@app.route('/AdminLogin',methods=['GET','POST'])
def AdminLogin():
    if request.method=='POST':
        userDetail = request.form
        First_Name = userDetail['First_Name']
        Last_Name = userDetail['Last_Name']
        Password = userDetail['Password']
        cur = my_sql.connection.cursor()
        cust_list = cur.execute("SELECT * FROM admin")
        if cust_list>0:
            cust_all = cur.fetchall()
            c_tup = ()
            for tup in cust_all:
                if(tup[1]==First_Name and tup[2]==Last_Name):
                    c_tup = tup
                    break
            if c_tup==() or Password!=c_tup[3]:
                flash('Invalid Email or Password')
            else:
                url_direct = '/admin'+'/'+str(c_tup[0])
                return redirect(url_direct)
    return render_template('AdminLogin.html')

@app.route('/SellerLogin',methods=['GET','POST'])
def SellerLogin():
    if request.method=='POST':
        userDetail = request.form
        Email = userDetail['Email']
        Password = userDetail['Password']
        cur = my_sql.connection.cursor()
        cust_list = cur.execute("SELECT * FROM artisan")
        if cust_list>0:
            cust_all = cur.fetchall()
            c_tup = ()
            for tup in cust_all:
                if(tup[3]==Email):
                    c_tup = tup
                    break
            if c_tup==() or Password!=c_tup[5]:
                flash('Invalid Email or Password')
            else:
                url_direct = '/sell'+'/'+str(c_tup[0])
                return redirect(url_direct)
    return render_template('SellerLogin.html')

class StaticClass:
    
    cart_id = random.randint(1000,100000)

    @staticmethod
    def giveCartId():
        StaticClass.cart_id +=1
        return StaticClass.cart_id