fxemoji 
=================================

#Firefox OS Emojis
http://mozilla.github.io/fxemoji/

##Requirements

* bash
* TTX/FontTools - please use https://github.com/behdad/fonttools/
* python
  - lxml (pip install lxml)

## Installation
```
$ git clone https://github.com/mozilla/fxemoji.git
$ cd fxemoji/
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

##How to Contribute
Please contact Patryk Adamczyk (padamczyk@mozilla.com) about contribution. 
For more information about upcoming releases please refer to our 
<a href="https://docs.google.com/a/mozilla.com/document/d/12wllN1NAJkS91VYLdCTHQ6FBb15VJTU8m0nPqaFOI5M/edit?usp=sharing">Firefox OS Emoji Roadmap</a>.

