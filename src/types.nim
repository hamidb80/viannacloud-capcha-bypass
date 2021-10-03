type Point* = tuple
  x, y: int

func seq2point*(s: seq[int]): Point =
  (s[0], s[1])
