import unittest, os, strutils, sequtils, macros
import pixie
import detector

macro genCapchaTest(capchasDir: static[string]): untyped =
  result = newStmtList()
  
  for (fkind, fpath) in walkDir capchasDir:
    let fname = `fpath`.splitFile.name
    result.add quote do:
      test `fname`:
        let ans = [`fname`[0..1], $`fname`[3]].map(parseInt).sum
        check ans == solveEquation readImage `fpath`


suite "e2e":
  genCapchaTest "./lib/raw/"