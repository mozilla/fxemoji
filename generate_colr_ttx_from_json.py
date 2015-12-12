from __future__ import print_function

import sys
import json
from lxml import etree

if __name__ == "__main__":

  if len(sys.argv)<3:
    print("Please provide arguments.")
    sys.exit(1)

  json_file=sys.argv[1]
  template_file=sys.argv[2]
  output_file=sys.argv[3]

  with open(json_file) as json_file:
    json_data = json.load(json_file)

  #colors
  all_colors=[]
  for elem in json_data:
    for layer in elem['icon']['layers']:
      if layer['color'] not in all_colors:
        all_colors.append(layer['color'])


  #colors paletes
  with open(template_file) as xml_file:
    tree = etree.parse(xml_file)

  palettes=tree.findall('CPAL/palette')

  for palette in palettes:
    for color in palette:
      color.getparent().remove(color)
    for index,color in enumerate(all_colors):
      color=etree.Element("color", index=str(index),value=str(color))
      palette.append(color)
  num_palet_entities=tree.find('CPAL/numPaletteEntries')
  num_palet_entities.attrib['value']=str(len(all_colors))


  #glyphs
  ColorGlyphs=tree.findall('COLR/ColorGlyph')
  COLR=tree.find('COLR')
  for el in ColorGlyphs:
    el.getparent().remove(el)
  for icon in json_data:
    ColorGlyph=etree.Element("ColorGlyph", name=str(icon['icon']['glyph']['name']))
    for index,name in enumerate(icon['icon']['layers']):
      for index,color in enumerate(all_colors):
        if color == name['color']:
          layer=etree.Element("layer", colorID=str(index),name=str(name['name']))
          ColorGlyph.append(layer)
    COLR.append(ColorGlyph)


  xml = etree.tostring(tree)
  if not isinstance(xml, str):
      xml = xml.decode("utf-8")

  f=open(output_file,'w+')
  f.write('<?xml version="1.0" encoding="utf-8"?>\n')
  f.write(xml)
  f.close()
