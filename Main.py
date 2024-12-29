from customtkinter import *
from tkinter import ttk
import tkinter as tk
import psycopg2
from PIL import Image
from tkinter import messagebox
from custom_widgets import CustomListbox
from psycopg2 import IntegrityError
    
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
    
#------------------------------------------------------------------------    

def fetch_city_names(admin_id):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""SELECT name 
                    FROM City
                    WHERE region_id = (SELECT id 
				                       FROM Region 
				                       WHERE admin_id=%s
				   		                )
                """,(admin_id))
    cities = [row[0] for row in cur.fetchall()]
    conn.close()
    return cities

def fetch_branch_names(city_var):
    conn = get_connection()
    cursor = conn.cursor()
    selected_city = city_var.get()
    cursor.execute("SELECT name FROM Branch WHERE city_id=(SELECT id FROM City WHERE name=%s)",(selected_city,))
    branches = [row[0] for row in cursor.fetchall()]
    conn.close()
    return branches

def fetch_selected_city_table(tree, city_var, admin_id):
    
    tree.delete(*tree.get_children())
    
    conn = get_connection()
    cursor = conn.cursor()
    selected_city = city_var.get()
    cursor.execute(""" SELECT
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
                r.admin_id = %s AND City.name = %s
            ORDER BY city.name, b.name;
                   """,(admin_id, selected_city))
            
    rows = cursor.fetchall()  
    for row in rows:
        tree.insert("", tk.END, values=row)
    cursor.close()
    conn.close()
    
def reset_branch_table(tree, admin_id):
    tree.delete(*tree.get_children())
    conn = get_connection()
    cursor = conn.cursor()
                   
    cursor.execute("SELECT * FROM fetch_branch_data(%s);", (admin_id,)) #branch tablosundaki verileri getiren fonksiyon
            
    rows = cursor.fetchall()  
    for row in rows:
        tree.insert("", tk.END, values=row)
    cursor.close()
    conn.close()

def show_branch_stock_table(admin_id):
    rows, columns, branch_stock_window = branch_stock_menu(admin_id)
    top_frame = CTkFrame(master=branch_stock_window, border_width=1, border_color='white', height=100, corner_radius=0)
    top_frame.pack_propagate(False)  # Top frame içeriğine göre boyutunu ayarlamaz
    top_frame.pack(side="top", fill=BOTH, expand=True)
    
    cities = fetch_city_names(admin_id) # kategori isim listesi
    city_var = StringVar(value=cities[0])
    category_name_label = CTkLabel(top_frame, text="Select City = ", font=FONT)
    category_name_label.place(x=200, y=40)
    caretory_optionmenu = CTkOptionMenu(top_frame, values=cities, variable=city_var, width=200)
    caretory_optionmenu.place(x=330, y=40)
    
    reset_button = CTkButton(top_frame, text='Reset', fg_color=button_color, command=lambda: reset_branch_table(tree, admin_id), hover=False, font=FONT, border_width=2, border_color="white", width=200, height=40)
    reset_button.place(x=600, y=33)
    
    apply_button = CTkButton(top_frame, text='Apply', fg_color=button_color, command=lambda: fetch_selected_city_table(tree, city_var, admin_id), hover=False, font=FONT, border_width=2, border_color="white", width=200, height=40)
    apply_button.place(x=815, y=33)
    
    bot_frame = CTkFrame(master=branch_stock_window, border_width=1, border_color='white', height=450, corner_radius=0)
    bot_frame.pack_propagate(False)
    bot_frame.pack(side="bottom", fill=BOTH, expand=True)
    style = ttk.Style(bot_frame)
    style.theme_use("clam")
    style.configure(
        "Treeview", #hangi ttk widget'ına işlem yapılacağının belirtilmesi
        font=("Arial", 12),
        foreground="#fff", #tablodaki değerlerin rengi
        background="#000", #tablonun arka plan rengi
        fieldbackground="#313837",
    )
    style.map("Treeview", background=[("selected", "#6BF62D")])

    frame = ttk.Frame(bot_frame)
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
    
    
def branch_stock_menu(admin_id):
    branch_stock_window = CTkToplevel(main_menu)
    branch_stock_window.transient(main_menu)
    branch_stock_window.title("Branch Stock")
    branch_stock_window.geometry("1400x550")
    branch_stock_window.resizable(False, False)
    center_window(branch_stock_window, 1200, 550)
    
    conn = get_connection()
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM fetch_branch_data(%s);", (admin_id,))
            
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]        
    cursor.close()
    conn.close()
    
    return rows, columns, branch_stock_window  
    
#--------------------------------------------------------------------------------------------------------------
            
def region_stock_menu(admin_id):
    region_stock_window = CTkToplevel(main_menu)
    region_stock_window.transient(main_menu)#yeni pencere ana pencerenin üstünde açılsın ve ana pencerede işlemi kısıtlansın
    region_stock_window.title("Region Stock")
    region_stock_window.geometry("1200x500")
    region_stock_window.resizable(False, False)
    center_window(region_stock_window, 1200, 500)
    
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM get_region_stock_data(%s);", (admin_id))
            
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
        tree.column(col, anchor="center", width=100) #kolondaki değerin hizalanması
        
    tree.heading(columns[0], text="Region Name")
    tree.heading(columns[1], text="Product ID")
    tree.heading(columns[2], text="Product Name")
    tree.heading(columns[3], text="Product Cost")
    tree.heading(columns[4], text="Category Name")
    tree.heading(columns[5], text="Category Type")
    tree.heading(columns[6], text="Quantity")

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
    
    
#------------------------------------------------------------------------------------------------------------------
    
def fetch_category_names(): # kategori adlarını dizi şeklinde döndürür 
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT DISTINCT name FROM Category")
    categories = [row[0] for row in cur.fetchall()]
    conn.close()
    return categories

def fetch_category_types(category_var):
    conn = get_connection()
    cursor = conn.cursor()
    selected_category = category_var.get()
    cursor.execute("SELECT DISTINCT type FROM Category WHERE name=%s",(selected_category,))
    types = [row[0] for row in cursor.fetchall()]
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


    
def clear_form(name, stock, cost):
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
    
    cancel_button = CTkButton(left_frame, text="Reset", command=lambda: clear_form(product_name_entry, product_stock_entry, cost_entry), fg_color=button_color, hover=False, font=('Arial',17), border_width=2, border_color="white", width=150)
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
        tree.column(col, anchor="center", width=200) #kolondaki değerin hizalanması
        
    tree.heading(columns[0], text="Product ID")
    tree.heading(columns[1], text="Product Name")
    tree.heading(columns[2], text="Product Cost")
    tree.heading(columns[3], text="Category ID")
    tree.heading(columns[4], text="Category Name")
    tree.heading(columns[5], text="Category Type")
    
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
    
#--------------------------------------------------------------------------------------------------------------
        
def update_product_window(admin_id):
    update_product_window = CTkToplevel(main_menu)
    update_product_window.title("Update Product")
    update_product_window.geometry("1500x550")
    update_product_window.resizable(False, False)
    center_window(update_product_window, 1500, 550)
    update_product_window.transient(main_menu)
    
    left_frame = CTkFrame(master=update_product_window, width=450, border_width=1, border_color='white', corner_radius=0)
    left_frame.pack(side="left", fill="y")
    right_frame = CTkFrame(master=update_product_window, width=1050, border_width=1, border_color='white', corner_radius=0)
    right_frame.pack(side="right", fill="y")
    
    product_id_entry = CTkEntry(left_frame)
    
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
    
    product_stock_label = CTkLabel(left_frame, text="Stock = ", font=FONT)
    product_stock_label.place(x=20, y=300)
    product_stock_entry = CTkEntry(left_frame, width=200)
    product_stock_entry.place(x=190, y=300)
    
    cost_label = CTkLabel(left_frame, text="Cost = ", font=FONT)
    cost_label.place(x=20, y=390)
    cost_entry = CTkEntry(left_frame, width=200)
    cost_entry.place(x=190, y=390)
    
    reset_button = CTkButton(left_frame, text="Reset", fg_color=button_color, command=lambda: clear_form(product_name_entry, product_stock_entry, cost_entry), hover=False, font=FONT, border_width=2, border_color="white")
    reset_button.place(x=50, y=480)
    
    update_button = CTkButton(left_frame, text="Update", fg_color=button_color, command=lambda: update_product(product_id_entry.get(), product_name_entry.get(), cost_entry.get(), product_stock_entry.get(), category_var.get(), types_var.get(), admin_id, tree),hover=False, font=FONT, border_width=2, border_color="white")
    update_button.place(x=230, y=480)
    
    conn = get_connection()
    cursor = conn.cursor()
        
    cursor.execute("SELECT * FROM fetch_region_product_data(%s)",(admin_id)) #product_update tablosu

    rows = cursor.fetchall()  # Veriyi al örn: rows = [(1, "Ali", 25),(2, "Fatih", 30)]
    columns = [desc[0] for desc in cursor.description]  # Sütun adlarını al örn: columns = ['id', 'name', 'age']
    cursor.close()
    conn.close()
    style = ttk.Style(update_product_window)
    style.theme_use("clam")
    style.configure(
        "Treeview", #hangi ttk widget'ına işlem yapılacağının belirtilmesi
        font=("Arial", 12),
        foreground="#fff", #tablodaki değerlerin rengi
        background="#000", #tablonun arka plan rengi
        fieldbackground="#313837",
    )
    style.map("Treeview", background=[("selected", "#6BF62D")])
    
    frame = CTkFrame(right_frame, width=1050)
    frame.pack(fill="both", expand=True, padx=20, pady=20)  
    
    x_scroll = ttk.Scrollbar(frame, orient="horizontal")
    y_scroll = ttk.Scrollbar(frame, orient="vertical")
        
    # Tabloyu oluştur
    tree = ttk.Treeview(
        frame, 
        columns=columns, 
        show="headings", # ilk satırda sütun isimlerini göster
        xscrollcommand=x_scroll.set, 
        yscrollcommand=y_scroll.set,
    )
        
    tree.heading(columns[0], text="Product ID")
    tree.heading(columns[1], text="Product Name")
    tree.heading(columns[2], text="Product Cost")
    tree.heading(columns[3], text="Quantity")
    tree.heading(columns[4], text="Category Name")
    tree.heading(columns[5], text="Category Type")
        
    tree.column(columns[0], anchor="center", width=90)
    tree.column(columns[1], anchor="center", width=180)
    tree.column(columns[2], anchor="center", width=180)
    tree.column(columns[3], anchor="center", width=150)
    tree.column(columns[4], anchor="center", width=200)
    tree.column(columns[5], anchor="center", width=200)
    
    x_scroll.config(command=tree.xview)
    y_scroll.config(command=tree.yview)

    x_scroll.pack(side="bottom", fill="x")
    y_scroll.pack(side="right", fill="y")

    # Verileri tabloya ekle
    for row in rows:
        tree.insert("", tk.END, values=row)

    tree.pack(fill="both", expand=True)
    def on_double_click(event):
        # Seçilen öğeyi al
        item_id = tree.focus()
        selected_item = tree.item(item_id, "values")  # Seçili satırın tüm değerleri
        
        if selected_item:  # Eğer bir satır seçildiyse
            
            product_id_entry.delete(0, tk.END)
            product_id_entry.insert(0, selected_item[0])
            
            product_name_entry.delete(0, tk.END)
            product_name_entry.insert(0, selected_item[1])  # Product Name
            
            category_var.set(selected_item[4])  # Category Name
            types_var.set(selected_item[5])  # Category Type
            
            product_stock_entry.delete(0, tk.END)
            product_stock_entry.insert(0, selected_item[3])  # Stock
            
            cost_entry.delete(0, tk.END)
            cost_entry.insert(0, selected_item[2])  # Cost
    
    # Çift tıklama olayı
    tree.bind("<Double-1>", on_double_click)
    
    def on_category_change(*args):
        update_types_menu(category_var, type_optionmenu, types_var)

    category_var.trace("w", on_category_change)
    
def update_product(product_id, product_name, product_cost, quantity, category_name, category_type, admin_id, tree):
    if not (product_id and product_name and product_cost and quantity and category_name and category_type):
        messagebox.showerror("Error", "Please fill all the fields")
        return
    try:
        product_id = int(product_id)
        product_cost = int(product_cost)
        quantity = int(quantity)
        
        conn = get_connection()
        cursor = conn.cursor()
    
        cursor.execute("""
        UPDATE Product
        SET name = %s,
            cost = %s,
            category_id = (SELECT id FROM Category WHERE name=%s AND type=%s)
        WHERE id = %s;
        """, (product_name, product_cost, category_name, category_type, product_id))
        
        cursor.execute("""
                    UPDATE Region_Stock
                    SET quantity = %s
                    WHERE product_id = %s AND region_id = (SELECT id FROM Region WHERE admin_id=%s)
                    """, (quantity, product_id, admin_id))
        conn.commit()
        messagebox.showinfo("Success", "Product updated successfully!")
    except Exception as e:
        error_message = str(e).split("CONTEXT")[0].strip()
        messagebox.showerror("Error", f"Error: {error_message}")
    finally:
        cursor.close()
        conn.close()
    reset_update_product_table(tree, admin_id)
    
    
def reset_update_product_table(tree, admin_id):
    tree.delete(*tree.get_children())
    conn = get_connection()
    cursor = conn.cursor()
        
    cursor.execute("SELECT * FROM fetch_region_product_data(%s)",(admin_id)) #product_update tablosu
            
    rows = cursor.fetchall()  
    for row in rows:
        tree.insert("", tk.END, values=row)
    cursor.close()
    conn.close()
#-----------------------------------------------------------------------------------------------------

def update_branches_menu(city_var, branch_optionmenu, branch_var):
    branches = fetch_branch_names(city_var)  # Yeni türleri al
    if len(branches) > 0:
        branch_var.set(branches[0])
        branch_optionmenu.configure(values=branches)
    else:
        branch_var.set("")
        branch_optionmenu.configure(values=[])
        
def supply_products(admin_id, current_branch_name, selected_products):
    
    try:
        # branch_id'yi almak için sorgu
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT id FROM Branch WHERE name = %s", (current_branch_name,))
        branch_id= cursor.fetchone()
        
        cursor.execute("SELECT id FROM Region WHERE admin_id = %s", (admin_id,))
        region_id = cursor.fetchone()
        
        if branch_id and region_id:
            branch_id = branch_id[0]
            region_id = region_id[0]
            
            # Ürünleri branch_stock tablosuna ekleme/güncelleme
            for product_id, product_name, product_quantity in selected_products:
                cursor.execute(
                    """
                    INSERT INTO branch_stock (branch_id, product_id, quantity)
                    VALUES (%s, %s, %s)
                    ON CONFLICT (branch_id, product_id)
                    DO UPDATE SET quantity = branch_stock.quantity + EXCLUDED.quantity
                    """,
                    (branch_id, product_id, product_quantity)
                )
                
                cursor.execute(
                    """
                    UPDATE Region_Stock
                    SET quantity = quantity - %s
                    WHERE region_id = %s AND product_id = %s
                    """,
                    (product_quantity, region_id, product_id)
                )
            conn.commit()
            messagebox.showinfo("Success", "The supply process was completed successfully")
        else:
            print(f"'{current_branch_name}' could not be found")
    except Exception as e:
        print(f"Error: {e}")
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

def supply_product_window(admin_id):
    supply_product_window = CTkToplevel(main_menu)
    supply_product_window.title("supply Product")
    supply_product_window.geometry("1500x600")
    supply_product_window.resizable(False, False)
    center_window(supply_product_window, 1500, 600)
    supply_product_window.transient(main_menu)
    
    left_frame = CTkFrame(master=supply_product_window, width=1000, border_width=1, border_color='white', corner_radius=0)
    left_frame.pack(side="left", fill="y")
    right_frame = CTkFrame(master=supply_product_window, width=500, border_width=1, border_color='white', corner_radius=0)
    right_frame.pack(side="right", fill="y")
    
    
    conn = get_connection()
    cursor = conn.cursor()
    
    cursor.execute("SELECT * FROM get_region_stock_data(%s);", (admin_id))
    rows = cursor.fetchall()  # Veriyi al örn: rows = [(1, "Ali", 25),(2, "Fatih", 30)]
    columns = [desc[0] for desc in cursor.description]  # Sütun adlarını al örn: columns = ['id', 'name', 'age']
    
    style = ttk.Style(supply_product_window)
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
    frame = ttk.Frame(left_frame)
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
        
    tree.column(columns[0], anchor="center", width=130)
    tree.column(columns[1], anchor="center", width=70)
    tree.column(columns[2], anchor="center", width=180)
    tree.column(columns[3], anchor="center", width=120)
    tree.column(columns[4], anchor="center", width=200)
    tree.column(columns[5], anchor="center", width=200)
    tree.column(columns[5], anchor="center", width=150)
    tree.column(columns[6], anchor="center", width=100)
    
        
    tree.heading(columns[0], text="Region Name")
    tree.heading(columns[1], text="Product ID")
    tree.heading(columns[2], text="Product Name")
    tree.heading(columns[3], text="Product Cost")
    tree.heading(columns[4], text="Category Name")
    tree.heading(columns[5], text="Category Type")
    tree.heading(columns[6], text="Quantity")

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
    
    cursor.execute("SELECT name FROM Region WHERE admin_id=%s", (admin_id,))
    region_name = cursor.fetchone()
    region_name_label = CTkLabel(master=right_frame, text=f"{region_name[0].upper()}", font=FONT)
    region_name_label.place(x=180, y=10)
    
    cities = fetch_city_names(admin_id) # kategori isim listesi
    city_var = StringVar(value=cities[0])
    city_name_label = CTkLabel(right_frame, text="City = ", font=FONT)
    city_name_label.place(x=40, y=80)
    city_optionmenu = CTkOptionMenu(right_frame, values=cities, variable=city_var, width=100)
    city_optionmenu.place(x=100, y=80)
    
    branches = fetch_branch_names(city_var)
    branch_var = StringVar(value=branches[0])
    branch_name_label = CTkLabel(right_frame, text="Branch = ", font=FONT)
    branch_name_label.place(x=260, y=80)
    branch_optionmenu = CTkOptionMenu(right_frame, values=branches, variable=branch_var, width=100)
    branch_optionmenu.place(x=350, y=80)
    
    def on_city_change(*args):
        update_branches_menu(city_var, branch_optionmenu, branch_var)
    city_var.trace("w", on_city_change)
    
    
    def clear_listbox():
        listbox.clear_items()
        selected_products.clear()
    
    listbox = CustomListbox(right_frame, width=390, height=300)
    listbox.place(x=40, y=150)
    selected_products = [] #Listbox'a eklenen ürünlerin (id, name, quanitity) şeklinde tutulacağı liste 
    
    reset_button = CTkButton(right_frame, text="Reset", command=lambda: clear_listbox(), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200)
    reset_button.place(x=40, y=500)
    
    supply_button = CTkButton(right_frame, text="Supply", command=lambda: supply_products(admin_id, branch_var.get(), selected_products), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200)
    supply_button.place(x=250, y=500)
    
    def on_treeview_double_click(event):
        selected_item = tree.selection()[0]
        product_id, product_name, product_quantity = tree.item(selected_item, 'values')[1], tree.item(selected_item, 'values')[2], tree.item(selected_item, 'values')[-1] 
        add_product_to_list(product_id, product_name, int(product_quantity))
    tree.bind("<Double-1>", on_treeview_double_click)
    
    def add_product_to_list(product_id, product_name, product_quantity):
        
        def add_or_update_item(data, new_item):
            item_id = new_item[0]
            item_name = new_item[1]
            item_quantity = new_item[2]

            # Aynı id'ye sahip item varsa, miktarını toplarız
            for i, item in enumerate(data):
                if item[0] == item_id:  # Aynı id'ye sahip item bulunduysa
                    new_quantity = item[2] + item_quantity
                    if new_quantity <= product_quantity:
                        data[i] = (item_id, item_name, new_quantity)
                        listbox.update_item(i, new_quantity)
                        return
                    else:
                        messagebox.showerror("Error", "The requested quantity exceeds the available stock.")
                        return
            
            # Eğer aynı id'ye sahip item bulunmazsa, yeni item'ı listeye ekleriz
            data.append(new_item)
            listbox.add_item(product_name, new_item[2])
            return 
        
        def on_confirm_quantity():
            quantity = quantity_entry.get()
            if quantity.isdigit() and int(quantity) > 0 and product_quantity >= int(quantity): 
                add_or_update_item(selected_products, (product_id, product_name, int(quantity)))
                quantity_window.destroy()
            else:
                error_label.configure(text="Please enter a valid quantity!")
                
        quantity_window = CTkToplevel(supply_product_window)
        quantity_window.geometry("300x300")
        center_window(quantity_window, 250, 200)
        quantity_window.title("Enter Quantity")

        # Miktar giriş penceresi
        CTkLabel(quantity_window, text="Quantity:").pack(padx=10, pady=10)
        quantity_entry = CTkEntry(quantity_window)
        quantity_entry.pack(padx=10, pady=10)

        error_label = CTkLabel(quantity_window, text="", text_color="red")
        error_label.pack()

        CTkButton(quantity_window, text="Enter", command=on_confirm_quantity).pack(padx=10, pady=10)
    
#-----------------------------------------------------------------------------------------------------
    
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
      
 #-----------------------------------------------------------------------------------------------------           
            
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
        open_admin_menu(username, admin_id)  
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
    
#----------------------------------------------------------------------------------------       
        
def select_option_window(): #ilk menü
    select_option_window = CTkToplevel(main_menu)
    select_option_window.title("Stock Management System")
    select_option_window.geometry("350x450")
    select_option_window.resizable(False, False)
    center_window(select_option_window, 350, 450)
    
    select_option_window.protocol("WM_DELETE_WINDOW", destroy_program) # ilk menü kapanırsa programı kapat
      
    customer_login_button = CTkButton(select_option_window, text="Customer Login", fg_color=button_color, command=lambda: customer_select_window(select_option_window), hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white", width=180, height=80)
    
    admin_login_button = CTkButton(select_option_window, text="Admin Login", fg_color=button_color, command=lambda: admin_login(select_option_window),hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white", width=180, height=80)
    
    select_option_window.columnconfigure(0, weight=1)
    select_option_window.rowconfigure(0, weight=1)
    select_option_window.rowconfigure(1, weight=1)
    
    customer_login_button.grid(row=0, column=0, ipadx=20, ipady=30)
    admin_login_button.grid(row=1, column=0, ipadx=20, ipady=30)
    
def admin_login(select_option_window): 
    select_option_window.destroy()# control
    login_menu()
    
#---------------------------------------------------------------------------------------------------

def open_admin_menu(username, admin_id):# Ana Menu
    main_menu.deiconify()# Ana menü penceresini tekrar görünür hale getir
    left_frame = CTkFrame(master=main_menu, border_width=1, border_color='white', width=280, corner_radius=0)
    left_frame.pack(side='left', fill=BOTH, expand=True)
    right_frame = CTkFrame(master=main_menu, border_width=1, border_color='white', width=720, corner_radius=0)
    right_frame.pack(side='right', fill=BOTH, expand=True)
    
    img = CTkImage(Image.open("user.png"),size=(180, 180))
    imagelabel = CTkButton(left_frame, image=img, text="", fg_color="transparent", hover=False)
    imagelabel.pack(pady=40)
    
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
    
    button_supply_product = CTkButton(right_frame, text='Supply Product', command=lambda: supply_product_window(admin_id),fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_supply_product.grid(row=1, column=0, ipadx=5, ipady=15)
    
    button_update_product = CTkButton(right_frame, text='Update Product', command=lambda: update_product_window(admin_id), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_update_product.grid(row=1, column=1, ipadx=5, ipady=15)
    
    button_add_product = CTkButton(right_frame, text='Change password',command=lambda: change_password(admin_id), fg_color=button_color, hover=False, font=FONT, border_width=2, border_color="white", width=200) 
    button_add_product.grid(row=1, column=2, ipadx=5, ipady=15)

#--------------------------------------------------------------------------------------------------------------
def customer_select_window(select_option_window):
    select_option_window.destroy()
    customer_select_window = CTkToplevel(main_menu)
    customer_select_window.title("Customer")
    customer_select_window.geometry("350x450")
    customer_select_window.resizable(False, False)
    center_window(customer_select_window, 350, 450)
    
    customer_select_window.protocol("WM_DELETE_WINDOW", destroy_program) # ilk menü kapanırsa programı kapat
      
    login_button = CTkButton(customer_select_window, text="Login", fg_color=button_color, hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white", width=180, height=80)
    
    register_button = CTkButton(customer_select_window, text="Register", fg_color=button_color, command=lambda: customer_register(customer_select_window), hover=False, font=FONT, corner_radius=20, border_width=2, border_color="white", width=180, height=80)
    
    customer_select_window.columnconfigure(0, weight=1)
    customer_select_window.rowconfigure(0, weight=1)
    customer_select_window.rowconfigure(1, weight=1)
    
    login_button.grid(row=0, column=0, ipadx=20, ipady=30)
    register_button.grid(row=1, column=0, ipadx=20, ipady=30)
    
    customer_select_window.protocol("WM_DELETE_WINDOW", destroy_program)
    
def customer_register(customer_select_window):
    customer_select_window.withdraw()
    customer_register_window = CTkToplevel(main_menu)
    customer_register_window.title("Register")
    customer_register_window.geometry("800x400")
    customer_register_window.resizable(False, False)
    center_window(customer_register_window, 800, 400)
    
    username_label = CTkLabel(master=customer_register_window, text="Username", font=FONT)
    username_label.place(x=40, y=70)
    username_entry = CTkEntry(master=customer_register_window, width=200)
    username_entry.place(x=150, y=70)
    
    password_label = CTkLabel(customer_register_window, text="Password", font=FONT)
    password_label.place(x=40, y=180)
    password_entry = CTkEntry(customer_register_window, width=200)
    password_entry.place(x=150, y=180)
    
    TC_label = CTkLabel(customer_register_window, text="TC", font=FONT)
    TC_label.place(x=40, y=290)
    TC_entry = CTkEntry(customer_register_window, width=200)
    TC_entry.place(x=150, y=290)
    
    Email_label = CTkLabel(customer_register_window, text="Email", font=FONT)
    Email_label.place(x=450, y=70)
    Email_entry = CTkEntry(customer_register_window, width=200)
    Email_entry.place(x=520, y=70)
    
    def get_cities():
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""SELECT name FROM City ORDER BY name ASC""")
        cities = [row[0] for row in cursor.fetchall()]
        conn.close()
        return cities
    
    cities = get_cities() # kategori isim listesi
    city_var = StringVar(value=cities[0])
    city_name_label = CTkLabel(customer_register_window, text="City", font=FONT)
    city_name_label.place(x=450, y=180)
    city_optionmenu = CTkOptionMenu(customer_register_window, values=cities, variable=city_var, width=200)
    city_optionmenu.place(x=520, y=180)
    
    def go_select_window():
        try:
            conn = get_connection()
            cursor = conn.cursor()
            cursor.execute("""
                       INSERT INTO customer (username, password, TC, email, city)
                       VALUES (%s, %s, %s, %s, %s);
                       """, (username_entry.get(), password_entry.get(), TC_entry.get(), Email_entry.get(), city_var.get()))
            conn.commit()
            messagebox.showinfo("Success", "Your account has been successfully created")
            customer_register_window.destroy()
            customer_select_window.deiconify()
        except IntegrityError as e:
            if 'duplicate key value violates unique constraint' in str(e):
                if 'customer_tc_key' in str(e): 
                    messagebox.showerror("Error", "This TC number is already registered")
                elif 'customer_email_key' in str(e):  
                    messagebox.showerror("Error", "This email address is already in use")
                elif 'customer_username_key' in str(e):
                    messagebox.showerror("Error", "This username is already in use")
                elif 'customer_password_key' in str(e):
                    messagebox.showerror("Error", "This password is already in use")
            else:
                print("An unexpected error occurred:", e)
        finally:
            if conn:
                conn.close()
        
    
    register_button = CTkButton(customer_register_window, text="Register", fg_color=button_color, command=lambda: go_select_window(), hover=False, font=FONT, corner_radius=2, border_width=2, border_color="white", width=150)
    register_button.place(x=540, y=300)
    
    customer_register_window.protocol("WM_DELETE_WINDOW", destroy_program)
    
# Başlangıç
main_menu = CTk()
main_menu.title("Stock Management System")
main_menu.geometry("1200x350")
main_menu.resizable(False, False)
main_menu.withdraw() # Başlangıçta ana menüyü gizle
center_window(main_menu, 1200, 350) # Ana menüyü ortala
FONT=('Arial', 20)
button_color = "#3B8E62"
set_appearance_mode("dark") # Genel tema 
select_option_window() # Giriş penceresi
set_default_color_theme("green") # Widget'ların teması
main_menu.mainloop()