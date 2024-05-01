import tkinter as tk
from tkinter import ttk, messagebox
from PIL import Image, ImageTk
from gtts import gTTS
import os
import pygame
import time


# Define a dictionary mapping text to image file paths
image_map = {
    "A": "Lips/A_E_I.png",
    "B": "Lips/B_M_P.png",
    "C": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "D": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "E": "Lips/A_E_I.png",
    "F": "Lips/F_V.png",
    "G": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "H": "Lips/TH.png",
    "I": "Lips/A_E_I.png",
    "J": "Lips/CH_J_SH.png",
    "K": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "L": "Lips/L.png",
    "M": "Lips/B_M_P.png",
    "N": "Lips/N.png",
    "O": "Lips/O.png",
    "P": "Lips/B_M_P.png",
    "Q": "Lips/Q_W.png",
    "R": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "S": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "T": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "U": "Lips/U.png",
    "V": "Lips/F_V.png",
    "W": "Lips/Q_W.png",
    "X": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "Y": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "Z": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "CH": "Lips/CH_J_SH.png",
    "SH": "Lips/CH_J_SH.png",
    "TH": "Lips/TH.png",
    "a": "Lips/A_E_I.png",
    "b": "Lips/B_M_P.png",
    "c": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "d": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "e": "Lips/A_E_I.png",
    "f": "Lips/F_V.png",
    "g": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "h": "Lips/TH.png",
    "i": "Lips/A_E_I.png",
    "j": "Lips/CH_J_SH.png",
    "k": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "l": "Lips/L.png",
    "m": "Lips/B_M_P.png",
    "n": "Lips/N.png",
    "o": "Lips/O.png",
    "p": "Lips/B_M_P.png",
    "q": "Lips/Q_W.png",
    "r": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "s": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "t": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "u": "Lips/U.png",
    "v": "Lips/F_V.png",
    "w": "Lips/Q_W.png",
    "x": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "y": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "z": "Lips/C_D_G_K_N_R_S_T_X_Y_Z.png",
    "ch": "Lips/CH_J_SH.png",
    "sh": "Lips/CH_J_SH.png",
    "th": "Lips/TH.png",

}


# Get the current script's directory
script_dir = os.path.dirname(os.path.abspath(__file__))  # Correct the reference to __file__
audio_folder = os.path.join(script_dir, "Audio")

# Variable to store the last entered text
last_entered_text = ""


def speech_update():
    global last_entered_text
    text = text_entry.get()

    if text != last_entered_text:
        last_entered_text = text

        # Create the "Audio" folder if it doesn't exist
        try:
            if not os.path.exists(audio_folder):
                os.makedirs(audio_folder)
        except OSError as e:
            messagebox.showerror("Error", f"Failed to create 'Audio' folder: {e}")
            return

        # Create a unique audio filename based on a timestamp
        timestamp = int(time.time())
        audio_filename = os.path.join(audio_folder, f"output_{timestamp}.mp3")

        # Create a gTTS object and save the text as audio
        try:
            tts = gTTS(text)
            tts.save(audio_filename)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to create audio: {e}")


def show_lips():
    text = text_entry.get()
    lip_sync(text)
    play_audio()


def lip_sync(text):
    # Remove any existing images
    image_label.pack_forget()

    # Split the text into individual letters
    letters = [letter for letter in text if letter in image_map]

    if letters:
        display_images(letters, 0)


def display_images(letters, index):
    if index < len(letters):
        letter = letters[index]
        image_path = image_map.get(letter)
        if image_path:
            try:
                image = Image.open(image_path)
                photo = ImageTk.PhotoImage(image)

                image_label.config(image=photo)
                image_label.image = photo
                image_label.pack()

                # Schedule the next image after a delay (e.g., 500 milliseconds)
                app.after(100, display_images, letters, index + 1)
            except Exception as e:
                messagebox.showerror("Error", f"Failed to display image: {e}")
        else:
            messagebox.showerror("Error", f"No image found for letter: {letter}")


def play_audio():
    speech_update()
    play_speech()


def play_speech():
    # List audio files in ascending order
    audio_files = sorted([f for f in os.listdir(audio_folder) if f.endswith(".mp3")])

    if audio_files:
        latest_audio_file = os.path.join(audio_folder, audio_files[-1])
        try:
            pygame.mixer.init()
            pygame.mixer.music.load(latest_audio_file)
            pygame.mixer.music.play()
        except Exception as e:
            messagebox.showerror("Error", f"Failed to play audio: {e}")


# Create the main application window
app = tk.Tk()
app.title("Modern Image Viewer")

# Set the initial size of the window
app.geometry("600x400")  # Width x Height

# Use themed widgets (ttk)
style = ttk.Style()
style.configure('TButton', foreground='blue', padding=10)
style.configure('TLabel', foreground='green')

# Create a text input field
text_label = ttk.Label(app, text="Enter text:")
text_label.pack()
text_entry = ttk.Entry(app)
text_entry.pack()

# Bind the update_audio function to the <<FocusOut>> event
text_entry.bind("<FocusOut>", lambda e: speech_update())

# Create a label to display the image
image_label = ttk.Label(app)

# Create a button with updated style
speak_button = ttk.Button(app, text="Speak", command=show_lips, style='TButton')
speak_button.pack()

app.mainloop()