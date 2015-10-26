import os
import sys
import natsort
import glob
import json

if __name__ == "__main__":

  if len(sys.argv)<1:
    print "Please provide arguments."
    sys.exit(1)

  font_name=sys.argv[1]

  icons={}
  layers={}
  svgs_path=[]
  svgs_path_sorted=[]
  json_output=[]


  data_dir = 'svgs/' + font_name + '/'
  file_dir_extension = os.path.join(data_dir, '*.svg')

  for file_name in glob.glob(file_dir_extension):
    if file_name.endswith('.svg'):
      svgs_path.append(file_name.replace('svgs/' + font_name + '/',''))

  for files in natsort.natsorted(svgs_path, key=lambda y: y.lower()):
    svgs_path_sorted.append(files)

  for file in svgs_path_sorted:

    if file .find('-') > -1:
      file_name=file.replace('.svg','').split('-')
      icons[file_name[0]]=file_name[1]

    if file .find('flag.') > -1 and not file .find('layer') > -1:
      file_name=file.replace('.svg','').split('.')
      icons[file_name[0]]=file_name[0]


    if file .find('.layer') > -1:

      #get color from file
      raw_svg=open('svgs/' + font_name + '/' + file).read()
      color=raw_svg.split('fill="#')[1].split('"')[0]


      if len(color) == 3:  # short group
        value = [c + c for c in color]
        color = value[0] + value[1] + value[2]


      #get codes and layer index
      file_name=file.replace('.svg','').split('layer')
      key=file_name[0].replace('.','')
      if key not in layers:
        layers[key]=[]

      layers[key].append({'order': int(file_name[1]) ,'color' : color, 'name':file_name[0] + 'layer' + file_name[1]})

  for icon in icons:
    icon_glyph={
      'icon' : {
        'glyph': {
          'code'   : icon,
          'name'   : icons[icon]
        },'layers' : layers[icon]
      }
    }

    json_output.append(icon_glyph)

  f=open(font_name + '.json','w+')
  f.write(json.dumps(json_output, sort_keys=True, indent=2, separators=(',', ': ')))
  f.close()

