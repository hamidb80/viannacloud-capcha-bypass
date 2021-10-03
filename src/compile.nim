import sequtils, strutils
import types

proc parsePatternPoints*(pattern: string): seq[Point] =
  # [[1,2], [3,2]]
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

