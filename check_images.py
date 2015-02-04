import os
import sys
import json
import shutil

if __name__ == "__main__":

  if len(sys.argv)<1:
    print "Please provide arguments."
    sys.exit(1)

  font_name=sys.argv[1]

  files=[]

  src_dir = os.listdir('svgs/' + font_name)
  original_dir = os.listdir('original/' + font_name)

  for src_file in src_dir:
    if src_file.endswith('.svg'):
      if src_file .find('.layer') == -1:
        files.append(src_file.replace('.svg','')[1:])

  for original_file in original_dir:
    if original_file.endswith('.ai'):
      current_file = original_file.replace('.ai','')
      if current_file not in files:
        if os.path.exists('original/' + font_name + '/' + current_file + '.ai'):
          shutil.copy('original/' + font_name + '/' + current_file + '.ai', 'tbd/' + font_name)
