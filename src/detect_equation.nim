import strformat, sequtils, os, oids
import pixie

const
  numberXStarts = [6, 17, 55]
  numberWidth = 9
  numberYRange = 8..22


func extractNumberPics(img: Image): seq[Image] =
  numberXStarts.mapIt img.subImage(it, numberYRange.a, numberWidth, numberYRange.len)


proc genNumbersFromImages =
  for fkind, fname in walkDir "./lib/raw":
    if fkind != pcFile: continue

    let
      numbers = fname.splitFile.name.filterIt(it in '0'..'9')
      images = extractNumberPics readImage fname

    for (i, n) in numbers.pairs:

      let dirName = fmt"./lib/numbers/{n}"
      if not dirExists dirName:
        createDir dirName

      writeFile images[i], fmt"{dirname}/{i}-{($genoid())[^6..^1]}.png"


if isMainModule:
  genNumbersFromImages()