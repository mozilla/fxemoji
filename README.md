FirefoxOS-Colored-Emoji-Font-Tool
=================================

##Requirements

* bash
* TTX/FontTools - please use https://github.com/behdad/fonttools/
* python
  - lxml (pip install lxml)

## Installation
```
$ git clone https://github.com/pivanov/FirefoxOS-Colored-Emoji-Font-Tool.git
$ cd FirefoxOS-Colored-Emoji-Font-Tool/
$ npm install
```

## Quick start
Change permissions of `run.sh` with `chmod +x run.sh`
```
$./run.sh
```

## Prepare SVG's
We need few SVG's per icon.
  - SVG file for each color layer
  - SVG that contains the complete glyph.

The files need to be named with uni code prefix.

###First Icon :
- u1F60A-smileeyes.svg (complete glyph)
- u1F60A.layer1.svg (Layer 1)
- u1F60A.layer2.svg (Layer 2)
- etc.

###Second Icon :
- u1F60B-smiletongue.svg (complete glyph)
- u1F60B.layer1.svg (Layer 1)
- u1F60B.layer2.svg (Layer 2)
- etc.


###SVG with opacity
we need to use HEX + opacity to hex value
e.g. #ff0000CC (red with 80% opacity)

- 100% — FF
- 95%  — F2
- 90%  — E6
- 85%  — D9
- 80%  — CC
- 75%  — BF
- 70%  — B3
- 65%  — A6
- 60%  — 99
- 55%  — 8C
- 50%  — 80
- 45%  — 73
- 40%  — 66
- 35%  — 59
- 30%  — 4D
- 25%  — 40
- 20%  — 33
- 15%  — 26
- 10%  — 1A
- 5%   — 0D
- 0%   — 00
