#!/bin/bash

generate_font() {
  font_name=${1}
  tbd_dir="tbd/${1}"

  svgs_dir="svgs"

  mkdir ${tbd_dir} || exit

  gulp --font ${font_name} || exit
  rm -f tmp/${font_name}/{*.eot,*.svg,*.woff} || exit

  python generate_json.py ${font_name} || exit


  #Dumping 'cmap' table
  ttx -o tmp/${font_name}/${font_name}.ttx -t cmap tmp/${font_name}/${font_name}.ttf || exit

  # Remove Glyphs from 'cmap' table
  for file in `find ${svgs_dir}/${font_name}/ -name "*.svg"`
    do
      filename=$(basename $file);

      if [[ $filename == *layer* ]]
        then
          code=${filename%.*}
          sed /$code/d tmp/${font_name}/${font_name}.ttx > tmp/${font_name}/output.tmp || exit
          mv tmp/${font_name}/output.tmp tmp/${font_name}/${font_name}.ttx || exit
      fi

      # if [[ $filename == *flag* ]]
      #   then
      #     code=${filename%.*}
      #     sed /$code/d tmp/${font_name}/${font_name}.ttx > tmp/${font_name}/output.tmp || exit
      #     mv tmp/${font_name}/output.tmp tmp/${font_name}/${font_name}.ttx || exit
      # fi
  done

  #Merge 'cmap' table back to font
  ttx -o tmp/${font_name}/${font_name}-cmap.ttf -m tmp/${font_name}/${font_name}.ttf tmp/${font_name}/${font_name}.ttx || exit

  python generate_colr_ttx_from_json.py ${font_name}.json templates/colr.ttx tmp/${font_name}/${font_name}-colr.ttx || exit

  mv ${font_name}.json dist/${font_name}/

  #Merge 'COLR' table to font
  ttx -o tmp/${font_name}/${font_name}-colr.ttf -m tmp/${font_name}/${font_name}-cmap.ttf tmp/${font_name}/${font_name}-colr.ttx || exit


  if [[ ${font_name} == 'FirefoxEmoji' || ${font_name} == 'flags' ]]
    then
      #Merge 'GSUB' table to font
      ttx -o tmp/${font_name}/${font_name}-gsub.ttf -m tmp/${font_name}/${font_name}-colr.ttf templates/gsub.ttx || exit

      #move final font to 'dist' folder
      mv tmp/${font_name}/${font_name}-gsub.ttf dist/${font_name}/${font_name}.ttf || exit
    else
      #move final font to 'dist' folder
      mv tmp/${font_name}/${font_name}-colr.ttf dist/${font_name}/${font_name}.ttf || exit

  fi

  if [[ ${font_name} == 'FirefoxEmoji' ]]
    then
    mv dist/${font_name}/${font_name}.ttf dist/${font_name}/${font_name}-tmp.ttf || exit
    ttx -o dist/${font_name}/${font_name}.ttf -m dist/${font_name}/${font_name}-tmp.ttf templates/name.ttx || exit
    rm dist/${font_name}/${font_name}-tmp.ttf || exit
  fi

  clean "tmp"
}

#Clean tmp
clean() {
  rm -rf ${1} || exit
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

