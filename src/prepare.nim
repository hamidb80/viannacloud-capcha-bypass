import os, sequtils, oids, strformat, strutils
import pixie
import detector, utils

import httpclient, xmltree
import nimquery, htmlparser


const baseUrl = "https://vshahed.viannacloud.ir/"
# ------------------------------

proc downloadCaptcha*(): string =
  var client = newHttpClient()
  let
    res = client.get baseUrl
    xml = parseHtml res.bodyStream
    imgUrl = baseUrl & xml.querySelector("img[alt=captcha]").attr "src"

  client.getContent imgUrl


proc genNumbersFromImages* =
  ## extract numbers from chapta images and save them in:
  ## ./lib/number/{n}/{uuid}.png

  walkDirFiles "./lib/raw", fpath, fname:
    let
      numbers = fname.filterIt it in '0'..'9'
      images = extractNumberPics readImage fname

    for (i, n) in numbers.pairs:

      let dirName = fmt"./lib/numbers/{n}"
      if not dirExists dirName:
        createDir dirName

      writeFile images[i], fmt"{dirname}/{i}-{($genoid())[^6..^1]}.png"
