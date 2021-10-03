import strformat, sequtils, os, oids, sugar, strutils
import pixie
import utils

type Point = tuple
  x, y: int

func seq2point(s: seq[int]): Point =
  (s[0], s[1])

const
  numberXStarts = [6, 17, 55]
  numberWidth = 9
  numberYRange = 8..22

# ---------------------------------

func extractNumberPics(img: Image): seq[Image] =
  numberXStarts.mapIt img.subImage(it, numberYRange.a, numberWidth, numberYRange.len)

proc genNumbersFromImages =
  walkDirFiles "./lib/raw", fpath, fname:
    let
      numbers = fname.filterIt(it in '0'..'9')
      images = extractNumberPics readImage fname

    for (i, n) in numbers.pairs:

      let dirName = fmt"./lib/numbers/{n}"
      if not dirExists dirName:
        createDir dirName

      writeFile images[i], fmt"{dirname}/{i}-{($genoid())[^6..^1]}.png"

proc parsePatternPoints(pattern: string): seq[Point] =
  # [[1,2,3]]
  var
    opened = 0
    last_opened_i = -1

  for (i, c) in pattern.pairs:
    if c in [' ', ',']: continue
    elif c == '[':
      opened += 1
      last_opened_i = i
    elif c == ']':
      opened -= 1
      if opened != 0: # end of the json file
        result.add seq2point pattern[last_opened_i+1..<i].split(',').mapIt it.strip.parseInt


const
  patterns = collect newseq:
    for n in 0..9:
      parsePatternPoints readFile fmt"./patterns/{n}.json"

  matchPriority = [8, 9, 6, 0, 3, 5, 2, 4, 7, 1]
  maxValidColorPart = 210

proc matchColor(c: ColorRGBX): bool =
  return not (c.r > maxValidColorPart or c.b > maxValidColorPart or c.g > maxValidColorPart)

proc matchProbabilty(img: Image): seq[bool] =
  collect newseq:
    for i in matchPriority:
      patterns[i].allIt matchColor img[it.x, it.y]


proc extractEquation*(img: Image): seq[int] =
  for numberImage in extractNumberPics img:
    let
      matches = matchProbabilty numberImage
      firstPriorityIndex = matches.findItIndex it

    result.add matchPriority[firstPriorityIndex]


if isMainModule:
  # genNumbersFromImages()
  echo extractEquation readImage "./lib/raw/10+4.png"
