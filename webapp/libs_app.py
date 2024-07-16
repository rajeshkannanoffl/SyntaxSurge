import tkinter as tk
from tkinter import filedialog
import subprocess

# Function to run the bash script
def run_bash_script():
    bash_script_path = file_path.get().replace('\\', '/')  # Convert Windows path to Unix-like path
    bash_command = f'C:/msys64/ucrt64.exe /bin/bash -lc "sh \'{bash_script_path}\' && exit"'
    subprocess.Popen(bash_command, shell=True)

# Function to get the file path from the user
def browse_file():
    file_path.set(filedialog.askopenfilename())

# Create the main window
root = tk.Tk()
root.title("Run Bash Script")

# Set default window size and position
window_width = 400
window_height = 200
screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
x_coordinate = (screen_width/2) - (window_width/2)
y_coordinate = (screen_height/2) - (window_height/2)
root.geometry(f"{window_width}x{window_height}+{int(x_coordinate)}+{int(y_coordinate)}")

# Add app logo (replace with your actual logo path)
logo_path = "../assets/favicon_io/android-chrome-192x192.png"
logo = tk.PhotoImage(file=logo_path)
root.iconphoto(True, logo)

# Disable resizing of the window
root.resizable(width=False, height=False)

# Create a StringVar to hold the file path
file_path = tk.StringVar()

# Create a label and entry to display the file path
file_label = tk.Label(root, text="Bash Script Path:")
file_label.pack(pady=5)
file_entry = tk.Entry(root, textvariable=file_path, width=50)
file_entry.pack(pady=5)

# Create a button to browse for the file
browse_button = tk.Button(root, text="Browse", command=browse_file)
browse_button.pack(pady=5)

# Function to change button color when clicked and revert after some time
def change_button_color(button):
    button.config(bg="green")
    root.after(200, lambda: button.config(bg=root.cget('bg')))  # Revert color after 200 milliseconds

# Create an OK button
ok_button = tk.Button(root, text="RUN", command=lambda: (run_bash_script(), change_button_color(ok_button)))
ok_button.pack(pady=20)

# Start the Tkinter event loop
root.mainloop()
