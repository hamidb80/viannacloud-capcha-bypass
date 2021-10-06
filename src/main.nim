import os, strutils, strformat
import pixie
import detector, prepare

if isMainModule:
  if paramCount() == 0:
    quit "please enter a path to capcha", 1

  let params = commandLineParams() 

  case params[0]:
    of "download":
      let times = parseint params[1]
      for n in 1..times: 
        writefile fmt"./lib/temp/{n}.jpg", downloadCaptcha()

    of "extract":
      extractNumbersFromImages()

    of "solve":
      echo solveEquation readimage params[1]