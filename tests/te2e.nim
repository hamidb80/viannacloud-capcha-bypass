import unittest, os, strutils, sequtils, macros
import pixie
import detect_equation


macro genCapchaTest(capchasDir: static[string]): untyped =
  result = newStmtList()
  
  for (fkind, fpath) in walkDir capchasDir:
    let fname = `fpath`.splitFile.name
    result.add quote do:
      test `fname`:
        let eq = extractEquation readImage `fpath`
        check [`fname`[0..1], $`fname`[3]].map(parseInt).sum == (eq[0] * 10 + eq[1] + eq[2])


suite "e2e":
  genCapchaTest "./lib/raw/"