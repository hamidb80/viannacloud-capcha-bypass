# viannacloud.ir capcha solver

# Usage

# How does this work?
the capcha imagees that are used in  [viannacloud.ir](viannacloud.ir), are:
1. same image size
2. the numbers have the same font familty & size
3. position of the numbers do not vary from image to image

and this properties makes it so vulnerable to hack

### NOTE
> this repository is just for educational purposes and the owner does not take any responsibility about the users' puporses, the purpose of the reader/user may be different


## steps
nimble install

`nim -d:ssl r .\src\prepare.nim download 4`
`nim -d:pixieUseStb r .\src\prepare.nim extract`
 
### gathering data

#### download the image