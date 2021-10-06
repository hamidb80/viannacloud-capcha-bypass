import os, strutils, strformat
import pixie
import detector, prepare

if isMainModule:
  if paramCount() == 0:
    quit """
commands:
  download N  |  N is a number
  extract
  solve PATH  | PATH is a relative or absolute path to the capcha picture
    """

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