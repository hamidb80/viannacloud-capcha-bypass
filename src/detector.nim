import strformat, sequtils, sugar
import pixie
import utils, compile, types

const
  numberXStarts = [6, 17, 55]
  numberWidth = 9
  numberYRange = 8..22

  matchPriority = [8, 9, 6, 0, 3, 5, 2, 4, 7, 1]
  maxValidColorPart = 210

  patterns = collect newseq:
    for n in 0..9:
      parsePatternPoints readFile fmt"./patterns/{n}.json"

# ---------------------------------

func extractNumberPics*(img: Image): seq[Image] =
  numberXStarts.mapIt img.subImage(it, numberYRange.a, numberWidth, numberYRange.len)

proc matchColor(c: ColorRGBX): bool =
  return not (c.r > maxValidColorPart or c.b > maxValidColorPart or c.g > maxValidColorPart)

proc matchProbabilty(img: Image): seq[bool] =
  collect newseq:
    for i in matchPriority:
      patterns[i].allIt matchColor img[it.x, it.y]

proc extractNumbers*(img: Image): seq[int] =
  for numberImage in extractNumberPics img:
    let
      matches = matchProbabilty numberImage
      firstPriorityIndex = matches.findItIndex it

    result.add matchPriority[firstPriorityIndex]

proc solveEquation*(img: Image): int {.inline.}=
  let numbers = extractNumbers(img)
  (numbers[0] * 10 + numbers[1]) + numbers[2]