import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from PIL import Image, ImageTk
from gtts import gTTS
import pygame
import platform
import math
import random
import pyttsx3
import threading
import time
import urllib.request
import os
import urllib.parse
import socket
import cv2
import playsound3
import queue
import subprocess
from tkinter import PhotoImage
pygame.mixer.init()
print("SISTEMA CARGADO CON EXITO..")
sonido_click = pygame.mixer.Sound("sonidos/click.wav")
sonido_soltar = pygame.mixer.Sound("sonidos/soltar.wav")
sonido_break= pygame.mixer.Sound("sonidos/break.wav")
sonido_burbujas=pygame.mixer.Sound("sonidos/burbujas.mp3")
sonido_idea=pygame.mixer.Sound("sonidos/idea.mp3")
sonido_tema=pygame.mixer.Sound("sonidos/tema.mp3")
sonido_lectura=pygame.mixer.Sound("sonidos/lectura.mp3")
sonido_exportar=pygame.mixer.Sound("sonidos/exportar.mp3")
sonido_voice=pygame.mixer.Sound("sonidos/voice.mp3")
sonido_power=pygame.mixer.Sound("sonidos/power.mp3")
sonido_change=pygame.mixer.Sound("sonidos/change.mp3")
sonido_next=pygame.mixer.Sound("sonidos/next.mp3")
global SONIDO_CLICK, SONIDO_SOLTAR, SONIDO_BREAK, SONIDO_BURBUJAS, SONIDO_IDEA, SONIDO_TEMA, SONIDO_EXPORTAR, SONIDO_LECTURA, SONIDO_VOICE, SONIDO_POWER, SONIDO_CHANGE, SONIDO_NEXT
SONIDO_CLICK = sonido_click
SONIDO_SOLTAR = sonido_soltar
SONIDO_BREAK = sonido_break
SONIDO_BURBUJAS = sonido_burbujas
SONIDO_IDEA = sonido_idea
SONIDO_TEMA = sonido_tema
SONIDO_EXPORTAR=sonido_exportar
SONIDO_LECTURA=sonido_lectura
SONIDO_VOICE=sonido_voice
SONIDO_POWER=sonido_power
SONIDO_CHANGE=sonido_change
SONIDO_NEXT=sonido_next