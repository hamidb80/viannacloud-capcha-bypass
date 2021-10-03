import os

template walkDirFiles*(dir, fpath, fname, body: untyped): untyped=
  for (fkind, fpath) in walkDir dir:
    if fkind != pcFile: continue

    let
      sfp = fpath.splitFile()
      fname = sfp.name & sfp.ext

    body