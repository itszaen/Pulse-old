# Conky (name suggestions are welcome)
This conky setup is hugely inspired by this great work : https://github.com/davidrlunu/dots-and-dashes

Since some updates on conky changed the syntax (!?) and made his work not working properly, I decided to make a knockoff myself.

Yep, I borrowed the wallpaper, and the general design ... well, he would understand. (It's open source baby!)

The codes are **abhorrent**. definitely something you would expect from a coding noobie. which I am. Hooray!

Some to note
* It is meant to be projected on a 1920x1080 display.
* It's using Inconsolata & Z003 font, and the fallback font is not pretty.

## Installation
I am using ArchLinux (with KDE, not sure if that matters) , and that's all. So I am not sure how some implemention on other distros would vary. (the location of the conky folder and whatnot)
If you're using arch too, then lucky you!
### Conky
On Arch, install the conky package with lua support. (nvidia, either way.)
```
pacaur -S conky-lua(-nv)
```
On other distros, make sure to have lua bindings support.
### Clone
```
git clone https://github.com/zaen323/conky.git ~/.config/conky
```
### Fonts
Although it will work without, the fallback is not something desirable.
```
sudo pacman -S ttf-inconsolata gsfonts
```
### Features
* Speedtest
For some reasons, conky will hangs for some time everytime it does the speedtest.
Remove the feature then, wouldn't you say? NOOBIE POWER! YOU CAN'T! (soon you can!)
```
sudo pacman -S speedtest-cli
```

## Screenshot
not updated regularly.
![Screenshot](https://raw.githubusercontent.com/zaen323/conky/master/Screenshot.png)
