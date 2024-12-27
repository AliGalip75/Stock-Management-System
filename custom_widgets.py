from customtkinter import *
class CustomListbox(CTkScrollableFrame):
    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)
        self.items = []

    def add_item(self, product_name, quantity):
        # Her satıra bir çerçeve ekleyerek butonları içine yerleştiriyoruz
        frame = CTkFrame(self)
        frame.pack(fill="x", pady=2, padx=5)

        # Sol buton
        left_button = CTkButton(frame, text=f"{product_name}", width=240, hover=False, border_width=1, fg_color="transparent", border_color="white", font=('Arial', 20))
        left_button.pack(side="left", fill="x", expand=True)

        # Sağ buton
        right_button = CTkButton(frame, text=f"{quantity}", width=150, hover=False, border_width=1, fg_color="transparent", border_color="white", font=('Arial', 20))
        right_button.pack(side="left", fill="x", expand=True)

        # Çerçeveyi öğeler listesine ekle
        self.items.append((frame, left_button, right_button))
    def update_item(self, i, new_quantity):
        self.items[i][2].configure(text=f"{new_quantity}")

    def clear_items(self):
        for item in self.items:
            item.destroy()
        self.items.clear()