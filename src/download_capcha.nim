import httpclient, xmltree, strformat
import nimquery, htmlparser

const baseUrl = "https://vshahed.viannacloud.ir/"

# ------------------------------

proc getCaptcha(n: int) =
  var client = newHttpClient()

  let res = client.get baseUrl
  # client.headers["Cookie"] = res.headers["Set-Cookie"]

  let
    xml = parseHtml res.bodyStream
    imgUrl = baseUrl & xml.querySelector("img[alt=captcha]").attr "src"

  writefile(fmt"./temp/c-{n}.png", client.getContent imgUrl)


for i in 0..10:
  getCaptcha(i)
