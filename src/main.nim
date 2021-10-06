import os
import pixie
import detector

if isMainModule:
  if paramCount() != 1:
    quit "please enter a path to capcha", 1

  echo solveEquation readimage paramStr(1)
