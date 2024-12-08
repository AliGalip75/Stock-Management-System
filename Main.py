from customtkinter import *
from tkinter import ttk
import tkinter as tk
import psycopg2
from PIL import Image
from tkinter import messagebox
    
def destroy_program(): # Login penceresi kapanırsa program da kapansın
    main_menu.destroy()
    
def get_connection():
    return psycopg2.connect(
            dbname='stock_management_system',  # Veritabanı adı
            user='postgres',               # Kullanıcı adı
            password='12345',                   # Şifre
            host='localhost',                   # Sunucu
            port='5432'                         # Port
            )
    
    
def center_window(window, width, height):
    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()
    position_top = int(screen_height / 2 - height / 2)
    position_right = int(screen_width / 2 - width / 2)
    window.geometry(f'{width}x{height}+{position_right}+{position_top}')

    
def branch_stock_menu(admin_id):
    branch_stock_window = CTkToplevel(main_menu)
    branch_stock_window.transient(main_menu)
    branch_stock_window.title("Branch Stock")
    branch_stock_window.geometry("1400x550")
    branch_stock_window.resizable(False, False)
    center_window(branch_stock_window, 1400, 550)
    
    conn = get_connection()
    cursor = conn.cursor()
    
    cursor.execute("""SELECT
            r.name AS region_name,
            City.name AS city_name,
            b.name AS branch_name,
            b.opening_date AS opening_date,
            b.type AS type,
            p.name AS product_name,
            p.cost AS cost,
            c.name AS category_name,
            c.type AS category_type,
            bs.quantity AS quantity
        
            FROM
                Region r
            FULL JOIN
                City ON r.id = city.region_id
            FULL JOIN
                Branch b ON city.id = b.city_id
            FULL JOIN
                Branch_Stock bs ON b.id = bs.branch_id
            FULL JOIN
                Product p ON bs.product_id = p.id
            FULL JOIN
                Category c ON p.category_id = c.id
            WHERE
                r.admin_id = %s
            ORDER BY city.name, b.name;""", (admin_id,))
            
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]        
    cursor.close()
    conn.close()
    
    return rows, columns, branch_stock_window  

def show_branch_stock_table(admin_id):
    rows, columns, branch_stock_window = branch_stock_menu(admin_id)
    style = ttk.Style(branch_stock_window)
    style.theme_use("clam")
    style.configure(
        "Treeview", #hangi ttk widget'ına işlem yapılacağının belirtilmesi
        font=("Arial", 12),
        foreground="#fff", #tablodaki değerlerin rengi
        background="#000", #tablonun arka plan rengi
        fieldbackground="#313837",
    )
    style.map("Treeview", background=[("selected", "#6BF62D")])

    frame = ttk.Frame(branch_stock_window)
    frame.pack(fill="both", expand=True, padx=20, pady=20) 

    x_scroll = ttk.Scrollbar(frame, orient="horizontal")
    y_scroll = ttk.Scrollbar(frame, orient="vertical")
    
    tree = ttk.Treeview(
        frame, 
        columns=columns, 
        show="headings",
        xscrollcommand=x_scroll.set, 
        yscrollcommand=y_scroll.set,
    )
    for col in columns: 
        tree.heading(col, text=col) 
        tree.column(col, anchor="center", width=100) 

    x_scroll.config(command=tree.xview)
    y_scroll.config(command=tree.yview)

    x_scroll.pack(side="bottom", fill="x")
    y_scroll.pack(side="right", fill="y")

    for row in rows:
        tree.insert("", tk.END, values=row)

    tree.pack(fill="both", expand=True)
            
def region_stock_menu(admin_id):
    region_stock_window = CTkToplevel(main_menu)
    region_stock_window.transient(main_menu)#yeni pencere ana pencerenin üstünde açılsın ve ana pencerede işlemi kısıtlansın
    region_stock_window.title("Region Stock")
    region_stock_window.geometry("1200x500")
    region_stock_window.resizable(False, False)
    center_window(region_stock_window, 1200, 500)
    
    conn = get_connection()
    cursor = conn.cursor()
            
    cursor.execute("""SELECT 
            r.name AS region_name,
            p.name AS product_name,
            p.cost AS product_cost,
            c.name AS category_name,
            c.type AS category_type,
            rs.quantity AS quantity
            FROM 
                Region r
            FULL JOIN 
                Region_Stock rs ON r.id = rs.region_id
            FULL JOIN 
                Product p ON rs.product_id = p.id
            FULL JOIN 
                Category c ON p.category_id = c.id
            WHERE 
                r.admin_id = %s
            ORDER BY c.name, c.type;""", (admin_id,))
            
    rows = cursor.fetchall()  # Veriyi al örn: rows = [(1, "Ali", 25),(2, "Fatih", 30)]
    columns = [desc[0] for desc in cursor.description]  # Sütun adlarını al örn: columns = ['id', 'name', 'age']
    cursor.close()
    conn.close()
    return rows, columns, region_stock_window


def show_region_stock_table(admin_id):
    rows, columns, region_stock_window = region_stock_menu(admin_id)
    style = ttk.Style(region_stock_window)
    style.theme_use("clam")
    style.configure(
        "Treeview", #hangi ttk widget'ına işlem yapılacağının belirtilmesi
        font=("Arial", 12),
        foreground="#fff", #tablodaki değerlerin rengi
        background="#000", #tablonun arka plan rengi
        fieldbackground="#313837",
    )
    style.map("Treeview", background=[("selected", "#6BF62D")]) #imleçle üzerine gelindiğinde gerçekleşecek işlem

    #Çerçeve oluştur ve tabloyu içine yerleştir
    frame = ttk.Frame(region_stock_window)
    frame.pack(fill="both", expand=True, padx=20, pady=20)  # Çerçeveye boşluk ekle

    #Tablo için kaydırma çubukları
    x_scroll = ttk.Scrollbar(frame, orient="horizontal")
    y_scroll = ttk.Scrollbar(frame, orient="vertical")
    
    #Tabloyu oluştur
    tree = ttk.Treeview(
        frame, 
        columns=columns, 
        show="headings", #ilk satırda sütun isimlerini göster
        xscrollcommand=x_scroll.set, 
        yscrollcommand=y_scroll.set,
    )
    for col in columns: 
        tree.heading(col, text=col) #sorgudan gelen kolon isimlerini değiştirebiliriz fakat burda aynı bıraktık
        tree.column(col, anchor="center", width=100) #kolondaki değerin hizalanması

    # Kaydırma çubuklarını bağlayın
    x_scroll.config(command=tree.xview)
    y_scroll.config(command=tree.yview)

    # Kaydırma çubuklarını yerleştirin
    x_scroll.pack(side="bottom", fill="x")
    y_scroll.pack(side="right", fill="y")

    # Verileri tabloya ekle
    for row in rows:
        tree.insert("", tk.END, values=row)

    # Tabloyu yerleştir
    tree.pack(fill="both", expand=True)
    
    
    
    
def fetch_category_names(): # kategori adlarını dizi şeklinde döndürür 
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT DISTINCT name FROM Category")
    categories = [row[0] for row in cur.fetchall()]
    conn.close()
    return categories

def fetch_category_types(category_var):
    conn = get_connection()
    cur = conn.cursor()
    selected_category = category_var.get()
    cur.execute("SELECT DISTINCT type FROM Category WHERE name=%s",(selected_category,))
    types = [row[0] for row in cur.fetchall()]
    conn.close()
    return types

def update_types_menu(category_var, type_optionmenu, types_var):
    types = fetch_category_types(category_var)  # Yeni türleri al
    types_var.set(types[0])  # İlk türü varsayılan yap
    type_optionmenu.configure(values=types)  # OptionMenu'yu güncelle
    
def add_new_product(name, category, category_type, quantity, cost, tree, admin_id):
    if not name or not quantity or not cost:
        messagebox.showerror("Error", "Please fill all fields.")
        return

    try:
        conn = get_connection()
        cursor = conn.cursor()

        cursor.execute(
            "SELECT id FROM Category WHERE name = %s AND type = %s", 
            (category, category_type)
        )
        category_id = cursor.fetchone()
        if not category_id:
            tk.messagebox.showerror("Error", "Invalid category.")
            return

        # Yeni ürünü ekle
        cursor.execute(
            """
            INSERT INTO Product (name, cost, category_id) 
            VALUES (%s, %s, %s) RETURNING id
            """,
            (name, cost, category_id)
        )
        product_id = cursor.fetchone()[0]

        # Bölge stoğuna yeni ürünü ekle
        cursor.execute(
            """
            INSERT INTO Region_Stock (region_id, product_id, quantity)
            VALUES (
                (SELECT id FROM Region WHERE admin_id = %s), 
                %s, 
                %s
            )
            """,
            (admin_id, product_id, quantity)
        )

        # Veritabanını kaydet
        conn.commit()

        # Tabloyu güncelle
        tree.insert(
            "",
            tk.END,
            values=(product_id, name, cost, category_id, category, category_type)
        )

        tk.messagebox.showinfo("Success", "Product added successfully!")

    except Exception as e:
        tk.messagebox.showerror("Error", f"An error occurred: {e}")

    finally:
        cursor.close()
        conn.close()
    
def clear_add_product_form(name, stock, cost):
        name.delete(0, tk.END)
        stock.delete(0, tk.END)
        cost.delete(0, tk.END)

def add_product(admin_id):
    add_product_window = CTkToplevel(main_menu)
    add_product_window.transient(main_menu)
    add_product_window.title("Add New Product")
    add_product_window.geometry("1500x550")
    add_product_window.resizable(False, False)
    center_window(add_product_window, 1500, 550)
    
    left_frame = CTkFrame(master=add_product_window, width=450, border_width=1, border_color='white', corner_radius=0)
    left_frame.pack(side="left", fill="y")
    right_frame = CTkFrame(master=add_product_window, width=1050, border_width=1, border_color='white', corner_radius=0)
    right_frame.pack(side="right", fill="y")
    
    
    product_name_label = CTkLabel(left_frame, text="Product Name = ", font=FONT)
    product_name_label.place(x=20, y=30)
    product_name_entry = CTkEntry(left_frame, width=200)
    product_name_entry.place(x=190, y=30)
    
    categories = fetch_category_names() # kategori isim listesi
    category_var = StringVar(value=categories[0])
    category_name_label = CTkLabel(left_frame, text="Category Name = ", font=FONT)
    category_name_label.place(x=20, y=120)
    caretory_optionmenu = CTkOptionMenu(left_frame, values=categories, variable=category_var, width=200)
    caretory_optionmenu.place(x=190, y=120)
    
    types = fetch_category_types(category_var)
    types_var = StringVar(value=types[0])
    type_label = CTkLabel(left_frame, text="Category Type = ", font=FONT)
    type_label.place(x=20, y=210)
    type_optionmenu = CTkOptionMenu(left_frame, values=types, variable=types_var, width=200)
    type_optionmenu.place(x=190, y=210)
    
    
    def on_category_change(*args):
        update_types_menu(category_var, type_optionmenu, types_var)

    category_var.trace("w", on_category_change)  # kategori değişikliğini dinler 
    
    
    product_stock_label = CTkLabel(left_frame, text="Stock = ", font=FONT)
    product_stock_label.place(x=20, y=300)
    product_stock_entry = CTkEntry(left_frame, width=200)
    product_stock_entry.place(x=190, y=300)
    
    cost_label = CTkLabel(left_frame, text="Cost = ", font=FONT)
    cost_label.place(x=20, y=390)
    cost_entry = CTkEntry(left_frame, width=200)
    cost_entry.place(x=190, y=390)
    
    cancel_button = CTkButton(left_frame, text="Reset", command=lambda: clear_add_product_form(product_name_entry, product_stock_entry, cost_entry), fg_color=button_color, hover=False, font=('Arial',17), border_width=2, border_color="white", width=150)
    cancel_button.place(x=40, y=480)
    
    cancel_button = CTkButton(left_frame, text="Add", fg_color=button_color, hover=False, font=('Arial',17), border_width=2, border_color="white", width=150, command=lambda: add_new_product(
                                product_name_entry.get(),
                                category_var.get(),
                                types_var.get(),
                                product_stock_entry.get(),
                                cost_entry.get(),
                                tree,
                                admin_id
                                )
    )
    cancel_button.place(x=240, y=480)
    
    
    
    
    conn = get_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
                SELECT p.id AS product_id,
                        p.name AS product_name,
                        p.cost AS product_cost,
                        c.id,
                        c.name AS category_name, 
                        c.type AS category_type
                FROM Product p
                JOIN Category c 
                ON p.category_id = c.id
                WHERE p.id IN(SELECT product_id 
                                FROM Region_Stock
                                WHERE region_id = (SELECT id 
                                                    FROM Region
                                                    WHERE admin_id = %s
                                                    )
                            )
                ORDER BY p.id ASC;
                    """,(admin_id,))

    rows = cursor.fetchall()  # Veriyi al örn: rows = [(1, "Ali", 25),(2, "Fatih", 30)]
    columns = [desc[0] for desc in cursor.description]  # Sütun adlarını al örn: columns = ['id', 'name', 'age']
    cursor.close()
    conn.close()
    style = ttk.Style(add_product_window)
    style.theme_use("clam")
    style.configure(
        "Treeview", #hangi ttk widget'ına işlem yapılacağının belirtilmesi
        font=("Arial", 12),
        foreground="#fff", #tablodaki değerlerin rengi
        background="#000", #tablonun arka plan rengi
        fieldbackground="#313837",
    )
    style.map("Treeview", background=[("selected", "#6BF62D")]) #imleçle üzerine gelindiğinde gerçekleşecek işlem

    #Çerçeve oluştur ve tabloyu içine yerleştir
    frame = CTkFrame(right_frame, width=1050)
    frame.pack(fill="both", expand=True, padx=20, pady=20)  # Çerçeveye boşluk ekle

    #Tablo için kaydırma çubukları
    x_scroll = ttk.Scrollbar(frame, orient="horizontal")
    y_scroll = ttk.Scrollbar(frame, orient="vertical")
        
    #Tabloyu oluştur
    tree = ttk.Treeview(
        frame, 
        columns=columns, 
        show="headings", #ilk satırda sütun isimlerini göster
        xscrollcommand=x_scroll.set, 
        yscrollcommand=y_scroll.set,
    )
    for col in columns: 
        tree.column(col, anchor="center", width=200,) #kolondaki değerin hizalanması
        
    tree.heading("product_id", text="Product Id")
    tree.heading("product_name", text="Product Name")
    tree.heading("product_cost", text="Product Cost")
    tree.heading("id", text="Category Id")
    tree.heading("category_name", text="Category Name")
    tree.heading("category_type", text="Category Type")
    
    tree.column("product_id", anchor="center", width=100,)
    tree.column("product_name", anchor="center", width=200,)
    tree.column("product_cost", anchor="center", width=200,)
    tree.column("id", anchor="center", width=100,)
    tree.column("category_name", anchor="center", width=200,)
    tree.column("category_type", anchor="center", width=200,)
    
    # Kaydırma çubuklarını bağlayın
    x_scroll.config(command=tree.xview)
    y_scroll.config(command=tree.yview)

    # Kaydırma çubuklarını yerleştirin
    x_scroll.pack(side="bottom", fill="x")
    y_scroll.pack(side="right", fill="y")

    # Verileri tabloya ekle
    for row in rows:
        tree.insert("", tk.END, values=row)

    # Tabloyu yerleştir
    tree.pack(fill="both", expand=True)
        
  


def control_menu():
    control_window = CTkToplevel(main_menu)
    control_window.title("Stock Management System")
    control_window.geometry("250x400")
    control_window.resizable(False, False)
    center_window(control_window, 250, 250)
    control_window.protocol("WM_DELETE_WINDOW", destroy_program)
      
    customer_login_button = CTkButton(control_window, text="Customer Login", fg_color=button_color, hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white")
    admin_login_button = CTkButton(control_window, text="Admin Login", fg_color=button_color,  command=lambda: control(control_window),hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white")
    control_window.columnconfigure(0, weight=1)
    control_window.rowconfigure(0, weight=1)
    control_window.rowconfigure(1, weight=1)
    
    customer_login_button.grid(row=0, column=0, ipadx=20, ipady=30)
    admin_login_button.grid(row=1, column=0, ipadx=32, ipady=30)
    
def control(control_window):
    control_window.destroy()
    login_menu()
            
            
def validate_user(username, password):
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Kullanıcı adı ve şifre ile sorgu
        cursor.execute("SELECT * FROM Admin WHERE username=%s AND password=%s", (username, password))
        user = cursor.fetchone()
        
        return user is not None  # Kullanıcı mevcutsa True, değilse False döndür

    except Exception as e:
        print(f"An error occured: {e}")
        return False            
            
def login(username, password, error, login_window):
    username = username.get()
    password = password.get()
    
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id FROM admin WHERE username=%s AND password=%s", (username, password,))
    admin_id = cursor.fetchone()
    
    conn.close()
    
    if validate_user(username, password):
        login_window.destroy()
        open_main_menu(username, admin_id)  
    else:
        error.configure(text="Username or password is incorrect.")

def login_menu():
    login_window = CTkToplevel(main_menu)
    login_window.title("Login Admin")
    login_window.geometry("300x400")
    login_window.resizable(False,False)
    center_window(login_window, 300, 400)

    image_path = 'user.png'
    img = CTkImage(Image.open(image_path),size=(100, 100))
    imagelabel = CTkLabel(login_window, image=img, text="")
    imagelabel.pack(pady=20)

    username_label = CTkLabel(login_window, text="Username:", font=('Arial',17))
    username_label.pack(pady=5)
    username_entry = CTkEntry(login_window)
    username_entry.pack(pady=5)

    password_label = CTkLabel(login_window, text="Password:", font=('Arial',17))
    password_label.pack(pady=5)
    password_entry = CTkEntry(login_window, show="*")
    password_entry.pack(pady=5)

    login_button = CTkButton(login_window, text="Login", command=lambda: login(username_entry, password_entry, error_label, login_window), fg_color=button_color, hover=False, font=('Arial',17), border_width=2, border_color="white")
    login_button.pack(pady=10)

    # Başta boş bir label, login işleminde hata olursa configure ile text ekleniyor
    error_label = CTkLabel(login_window, text="", text_color="red")
    error_label.pack(pady=5)
    
    
    login_window.protocol("WM_DELETE_WINDOW", destroy_program) #Eğer login ekranı kapatılırsa programı komple kapat
    
    
def change_password(admin_id):
    def validate_form():
        if not (username_entry.get().strip() and old_password_entry.get().strip() and new_password_entry.get().strip()):
            tk.messagebox.showerror("Error", "Please fill all fields")
            clear_change_password_form(username_entry, old_password_entry, new_password_entry)
            return
            
        conn = get_connection()
        cursor = conn.cursor()
        
        cursor.execute(
            """
            SELECT username, password
            FROM Admin
            WHERE id=%s
            """, (admin_id,)
        )
        row = cursor.fetchone() # (admin1, pass1)
        
        
        if (row[0] != username_entry.get()) or (row[1] != old_password_entry.get()):
            tk.messagebox.showerror("Error", "Username or Password Incorrect")
            clear_change_password_form(username_entry, old_password_entry, new_password_entry)
        else:
            new_password = new_password_entry.get()
            cursor.execute(
                """
                UPDATE Admin
                SET password = %s
                WHERE username = %s AND password= %s
                """, (new_password, username_entry.get(), old_password_entry.get()) 
            )
            tk.messagebox.showinfo("Successful", "Password changed successfully")
            clear_change_password_form(username_entry, old_password_entry, new_password_entry)
            
        conn.commit()
        cursor.close()
        conn.close()
            
            
    change_password_window = CTkToplevel(main_menu)
    change_password_window.title("Change Password")
    change_password_window.geometry("450x650")
    change_password_window.resizable(False, False)
    center_window(change_password_window, 450, 650)
    change_password_window.transient(main_menu)
    
    img = CTkImage(Image.open("user.png"),size=(150, 150))
    imagelabel = CTkLabel(change_password_window, image=img, text="")
    imagelabel.place(x=150, y=20)
    
    username_label = CTkLabel(change_password_window, text="Username", font=FONT)
    username_label.place(x=177, y=200)
    username_entry = CTkEntry(change_password_window, width=165)
    username_entry.place(x=145, y=240)
    
    old_password_label = CTkLabel(change_password_window, text="Old Password", font=FONT)
    old_password_label.place(x=160, y=280)
    old_password_entry = CTkEntry(change_password_window, width=165, show="*")
    old_password_entry.place(x=145, y=320)
    
    show_old_password_var = CTkCheckBox(change_password_window, text="Show", command=lambda: toggle_password_visibility(show_old_password_var, old_password_entry))
    show_old_password_var.place(x=330, y=320)

    
    new_password_label = CTkLabel(change_password_window, text="New Password", font=FONT)
    new_password_label.place(x=160, y=360)
    new_password_entry = CTkEntry(change_password_window, width=165, show="*")
    new_password_entry.place(x=145, y=400)
    
    show_new_password_var = CTkCheckBox(change_password_window, text="Show", command=lambda: toggle_password_visibility(show_new_password_var, new_password_entry))
    show_new_password_var.place(x=330, y=400)
    
    reset_button = CTkButton(change_password_window, text="Reset", fg_color=button_color, command=lambda: clear_change_password_form(username_entry, old_password_entry, new_password_entry), hover=False, font=FONT, border_width=2, border_color="white")
    reset_button.place(x=60, y=520)
    
    reset_button = CTkButton(change_password_window, text="Save", fg_color=button_color, command=validate_form, hover=False, font=FONT, border_width=2, border_color="white")
    reset_button.place(x=250, y=520)
    
def clear_change_password_form(username, old_pass, new_pass):
    username.delete(0, tk.END)
    old_pass.delete(0, tk.END)
    new_pass.delete(0, tk.END)
    
def toggle_password_visibility(show_pass_var, pass_entry):
    if show_pass_var.get():
        pass_entry.configure(show="")
    else:
        pass_entry.configure(show="*")




def open_main_menu(username, admin_id):# Ana Menu
    main_menu.deiconify()# Ana menü penceresini tekrar görünür hale getir
    left_frame = CTkFrame(master=main_menu, border_width=1, border_color='white', width=280, corner_radius=0)
    left_frame.pack(side='left', fill=BOTH, expand=True)
    right_frame = CTkFrame(master=main_menu, border_width=1, border_color='white', width=720, corner_radius=0)
    right_frame.pack(side='right', fill=BOTH, expand=True)
    
    img = CTkImage(Image.open("user.png"),size=(180, 180))
    imagelabel = CTkButton(left_frame, image=img, text="", fg_color="transparent", hover=False)
    imagelabel.pack(pady=20)
    
    welcome_label = CTkLabel(left_frame, text=f'Welcome, {username}', font=('Arial',17))
    welcome_label.pack()
    
    right_frame.columnconfigure(0, weight=1)
    right_frame.columnconfigure(1, weight=1)
    right_frame.columnconfigure(2, weight=1)
    right_frame.rowconfigure(0, weight=1)
    right_frame.rowconfigure(1, weight=1)
    
    button_region_stock = CTkButton(right_frame, text='Region Stock', command=lambda: show_region_stock_table(admin_id), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_region_stock.grid(row=0, column=0, ipadx=5, ipady=15)
    
    button_branch_stock = CTkButton(right_frame, text='Branch Stock', command=lambda: show_branch_stock_table(admin_id),fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_branch_stock.grid(row=0, column=1, ipadx=5, ipady=15)
    
    button_add_product = CTkButton(right_frame, text='Add New Product', command=lambda: add_product(admin_id), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_add_product.grid(row=0, column=2, ipadx=5, ipady=15)
    
    button_supply_product = CTkButton(right_frame, text='Supply Product', fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_supply_product.grid(row=1, column=0, ipadx=5, ipady=15)
    
    button_update_product = CTkButton(right_frame, text='Update Product', fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_update_product.grid(row=1, column=1, ipadx=5, ipady=15)
    
    button_add_product = CTkButton(right_frame, text='Change password',command= lambda: change_password(admin_id), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_add_product.grid(row=1, column=2, ipadx=5, ipady=15)
    

#Uygulamanın ana penceresini oluştur
main_menu = CTk()
main_menu.title("Stock Management System")
main_menu.geometry("1200x350")
main_menu.resizable(False, False)
main_menu.withdraw()#Başlangıçta ana menüyü gizle
center_window(main_menu, 1000, 300)
FONT=('Arial', 20)
button_color = "#3B8E62"
set_appearance_mode("dark")
control_menu() #Giriş penceresi
set_default_color_theme("green")
main_menu.mainloop()

