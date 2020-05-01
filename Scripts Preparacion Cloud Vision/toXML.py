import json
import xml.etree.cElementTree as ET
import os, zipfile
from gluoncv import utils
import mxnet as mx
import numpy as np
from matplotlib import pyplot as plt

directory1 = '/Users/sergioghislergomez/Desktop/train/image'
directory2 = '/Users/sergioghislergomez/Desktop/train/annos'
images=os.listdir(directory1)
annos=os.listdir(directory2)

for filename in images:
    nombre=filename[:-4]
    foto= filename.startswith(nombre)
    foto = mx.image.imread('/Users/sergioghislergomez/Desktop/train/image/'+filename)
  

    with open('/Users/sergioghislergomez/Desktop/train/annos/'+nombre+'.json') as f:
      data = json.load(f)


    dtc= {}
    for key, value in data.items():
      if('item' in key):
        dtc[key]=key =	{
        "bounding_box": value['bounding_box'],
        "category_name": value['category_name'],
        "category_id" :value['category_id']
        }     
    all_boxes=list()
    all_ids=list()
    class_names=list()
    contador=0
    for aux in dtc.keys():
        class_names.append(dtc[aux]['category_name'])
        all_ids.append(contador)
        contador+=1
        all_boxes.append(dtc[aux]['bounding_box'])

    annotation = ET.Element("annotation")
    folder = ET.SubElement(annotation, "folder").text="images"
    filename=ET.SubElement(annotation, "filename").text=filename
    path=ET.SubElement(annotation, "path").text= os.path.abspath(filename)
    source = ET.SubElement(annotation, "source")
    database=ET.SubElement(source, "database").text= 'Unknown'
    size=ET.SubElement(annotation,'size')
    
    width=ET.SubElement(size,'width').text=str(foto.shape[1])
    height=ET.SubElement(size,'height').text=str(foto.shape[0])
    depth=ET.SubElement(size,'widdepthth').text=str(foto.shape[2])
    segmented= ET.SubElement(annotation,'segmented').text='0'
    contador2=0
    for cajas in all_boxes:
      object= ET.SubElement(annotation,'object')
      name=ET.SubElement(object,'name').text=class_names[contador2].replace(" ", "_")
      contador2+=1
      pose=ET.SubElement(object,'pose').text='Unspecified'
      truncated=ET.SubElement(object,'truncated').text='0'
      difficult=ET.SubElement(object,'difficult').text='0'
      bndbox=ET.SubElement(object,'bndbox')
      xmin=ET.SubElement(bndbox,'xmin').text=str(cajas[0])
      ymin=ET.SubElement(bndbox,'ymin').text=str(cajas[1])
      xmax=ET.SubElement(bndbox,'xmax').text=str(cajas[2])
      yman=ET.SubElement(bndbox,'yman').text=str(cajas[3])

    tree = ET.ElementTree(annotation)
    tree.write('/Users/sergioghislergomez/Desktop/train/image'+nombre+".xml")