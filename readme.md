# viannacloud.ir capcha solver

# Usage

# How does this work?
the capcha imagees that are used in  [viannacloud.ir](viannacloud.ir), are:
1. same image size
2. the numbers have the same font familty & size
3. position of the numbers do not vary from image to image
4. all of the capchas are sum of a 2 digits number plus an one digit number ::  `ab + c =`

and this characteristics makes it so vulnerable to hack

### NOTE
> this repository is just for educational purposes and the owner does not take any responsibility about the users' puporses, the purpose of the reader/user may be different


## steps
### finding the extact place of each number
**note**: if you wanna execute the correcspoding code of each section you must have nim >= 1.4.8 installed. then install the dependecies with this command:
```
nimble install
```


because the font and the position of the numbers do not change, we can easily find them.

I've downloaded `80` capchas located in `/lib/raw/` 
but you can download it with these command [you can replace the number `4` with what number of downloads you want]:
```
nim -d:ssl r .\src\prepare.nim download 4
```

[you can find them for yourself using another [software of mine](https://hamidb80.github.io/image-pixel-marker/). the guidence of this software exaplned [here](https://github.com/hamidb80/image-pixel-marker)]


![finding pixels](./docs/pixel-finding.png)
after examining some capchas, I found the exact position of each number

- **height**: each number starts from pixel 8 to 22 in Y-axis [the blue lines]
- **width**: they're all 9 pixels in width [the orange lines ]
- **x**: numbers start at these pixels in X-axis: 6, 17, 55

I crop them to examine them individually.

**note**: these cropped images are not in the repository, if you want them, you can enter the following command, it will generated some folders in `lib/numbers/` containing some images cropped from images in `lib/raw/`
```
nim -d:pixieUseStb r .\src\prepare.nim extract
```


<div style="display:flex; justify-content: space-evenly">
  <img style="max-height: 300px" src="./docs/4.png">
  <img style="max-height: 300px" src="./docs/4-marked.png">
</div>

after examining some of `4`s that is placed in `lib/numbers/4` I figured out the must have pixels of number 4

i've exported the points using the software [that I put it's link earlier] and put them in `patterns/4.json`

I did the same for rest of the numbers...


```
 nim  -d:pixieUseStb r src/main.nim lib/raw/10+4.png
```

you can run tests using:
```
nimble test
```
