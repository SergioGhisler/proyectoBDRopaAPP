import json
import pandas as pd
from PIL import Image
import os
import random 

dataset = dict()
dataset["set"] =list()
dataset["class_name"] = list()
dataset["image_name"] = list()

dataset["x_min"] = list()
dataset["y_min"] = list()
dataset["x_max"] = list()
dataset["y_max"] = list()



Train_directory1 = '/Users/sergioghislergomez/Downloads/validation/test'
Train_directory2 = '/Users/sergioghislergomez/Downloads/validation/annos'
Train_images=os.listdir(Train_directory1)
Train_annos=os.listdir(Train_directory2)


counter = 0

for filename in Train_images:
    numero=random.random() 
    if(numero<0.5):
        tipo='TEST'
    else:
        tipo='VALIDATE'
    nombre=filename[:-4]
    im =Image.open('/Users/sergioghislergomez/Downloads/validation/test/'+filename)
    width, height = im.size
    with open('/Users/sergioghislergomez/Downloads/validation/annos/'+nombre+'.json') as f:
      data = json.load(f)

    all_boxes=[]
    for key, value in data.items():
      if('item' in key):
        value['bounding_box'].append(value['category_name'])
        all_boxes.append(value['bounding_box'])

    for i in all_boxes:
        dataset["set"].append(tipo)
    
        ruta=str('gs://flying-ropa/test/'+filename)
        dataset["image_name"].append(ruta)
        dataset["class_name"].append(i[4])
        dataset["x_min"].append((i[0]*1.0)/width)
        dataset["y_min"].append((i[1]*1.0)/height)
        dataset["x_max"].append((i[2]*1.0)/width)
        dataset["y_max"].append((i[3]*1.0)/height)
  
    counter=1+counter
    print("Foto "+str(counter)+" de "+ str(len(Train_images)))
    print(height)
    print(width)
    

df = pd.DataFrame(dataset)
print(df.head())
#[set,]image_path[,label,x1,y1,x2,y1,x2,y2,x1,y2]
df = pd.DataFrame(dataset)

df = df.drop(df[(df['x_min'] == 0) & (df['y_min'] == 0.0) & (df['x_max'] == 0.0) & (df['y_max'] == 0.0)].index)

df = df[["set", "image_name", "class_name","x_min","y_min","x_max","y_min","x_max","y_max","x_min","y_max"]]
print(df.head())

df.to_csv("annotations_test.csv", index=False, header=None)