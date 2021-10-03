import strformat, sequtils, sugar
import pixie
import compile, types

const
  numberXStarts = [6, 17, 55]
  numberWidth = 9
  numberYRange = 8..22

  matchPriority = [8, 9, 6, 0, 3, 5, 2, 4, 7, 1]
  maxValidColorPart = 230 # 0..210 from 255 is valid in color

  patterns = collect newseq:
    for n in 0..9:
      parsePatternPoints readFile fmt"./patterns/{n}.json"

# ---------------------------------

proc matchColor(color: ColorRGBX): bool {.inline.} =
  [color.r, color.g, color.b].allIt it < maxValidColorPart

proc matchedNumber(img: Image): int =
  for i in matchPriority:
    if patterns[i].allIt matchColor img[it.x, it.y]:
      return i

func extractNumberPics*(img: Image): seq[Image] =
  numberXStarts.mapIt img.subImage(it, numberYRange.a, numberWidth,
      numberYRange.len)

proc extractNumbers*(img: Image): seq[int] =
  for numberImage in extractNumberPics img:
    result.add matchedNumber numberImage

proc solveEquation*(img: Image): int {.inline.} =
  let numbers = extractNumbers(img)
  (numbers[0] * 10 + numbers[1]) + numbers[2]
