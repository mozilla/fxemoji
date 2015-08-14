#!/bin/bash

generate_font() {
  font_name=${1}
  tbd_dir="tbd/${1}"

  svgs_dir="svgs"

  mkdir ${tbd_dir}

  gulp --font ${font_name}
  rm -f tmp/${font_name}/{*.eot,*.svg,*.woff}

  python generate_json.py ${font_name}


  #Dumping 'cmap' table
  ttx -o tmp/${font_name}/${font_name}.ttx -t cmap tmp/${font_name}/${font_name}.ttf


  # Remove Glyphs from 'cmap' table
  for file in `find ${svgs_dir}/${font_name}/ -name "*.svg"`
    do
      #get first 2 characters after first 4 characters
      filename=$(basename $file);
      if [[ $filename == *layer* ]]
        then
          code=${filename%.*}
          sed /$code/d tmp/${font_name}/${font_name}.ttx > tmp/${font_name}/output.tmp
          mv tmp/${font_name}/output.tmp tmp/${font_name}/${font_name}.ttx
      fi
  done


  #Merge 'cmap' table back to font
  ttx -o tmp/${font_name}/${font_name}-cmap.ttf -m tmp/${font_name}/${font_name}.ttf tmp/${font_name}/${font_name}.ttx

  python generate_ttx_from_json.py ${font_name}.json templates/colr.ttx tmp/${font_name}/${font_name}-colr.ttx


  #Merge 'COLR' table to font
  ttx -o tmp/${font_name}/${font_name}-colr.ttf -m tmp/${font_name}/${font_name}-cmap.ttf tmp/${font_name}/${font_name}-colr.ttx

  #move final font to 'dist' folder
  mv tmp/${font_name}/${font_name}-colr.ttf dist/${font_name}/${font_name}.ttf

  if [[  ${font_name} == 'FirefoxEmoji' ]]
    then
    mv dist/${font_name}/${font_name}.ttf dist/${font_name}/${font_name}-tmp.ttf
    ttx -o dist/${font_name}/${font_name}.ttf -m dist/${font_name}/${font_name}-tmp.ttf templates/name.ttx
    rm dist/${font_name}/${font_name}-tmp.ttf
  fi

  clean "tmp"
}

#Clean tmp
clean() {
  rm -rf ${1}
}

clean tbd
mkdir tbd

if [[ -z ${1} ]]
  then
    for i in $(ls -d svgs/*); do
      generate_font ${i##*/}
    done
  else
    generate_font ${1}
fi

