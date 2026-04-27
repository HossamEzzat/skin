import re

valid_main_images = [
    "https://images.unsplash.com/photo-1616391182219-e080b4d1043a?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1555252333-9f8e92e65df9?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1559757175-5700dde675bc?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1570554886111-e80fcca6a029?w=400&h=400&fit=crop",
]

valid_scanned_images = [
    "https://images.unsplash.com/photo-1579154204601-01588f351e67?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1631815588090-d4bfec5b1ccb?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=400&h=400&fit=crop",
    "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=400&h=400&fit=crop",
]

valid_med_images = [
    "https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=300&h=300&fit=crop",
    "https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=300&fit=crop",
    "https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=300&fit=crop",
]

file_path = r'g:\androidapps\skin\lib\features\disease\data\disease_data.dart'

with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

idx1 = 0
def repl1(m):
    global idx1
    v = valid_main_images[idx1 % len(valid_main_images)]
    idx1 += 1
    return f'mainImage:\n        "{v}",'

content = re.sub(r'mainImage:\s*"[^"]*",', repl1, content)

idx2 = 0
def repl2(m):
    global idx2
    v = valid_scanned_images[idx2 % len(valid_scanned_images)]
    idx2 += 1
    return f'scannedImage:\n        "{v}",'

content = re.sub(r'scannedImage:\s*"[^"]*",', repl2, content)

idx3 = 0
def repl3(m):
    global idx3
    v = valid_med_images[idx3 % len(valid_med_images)]
    idx3 += 1
    return f'image:\n            "{v}",'

content = re.sub(r'image:\s*"[^"]*",', repl3, content)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
