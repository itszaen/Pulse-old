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
* Oh and tested on ubuntu, works too! I'll test this on more distros (on virtual machine anyway)
### Conky
* Arch, install the conky package with lua support. (nvidia, either way.)
```
pacaur -S conky-lua(-nv)
```
* Ubuntu
```
sudo apt-get install conky-all
```
On other distros, make sure to have lua bindings support.
### Clone
* Arch, Ubuntu
```
git clone https://github.com/zaen323/conky.git ~/.config/conky
```
On other distros, follow the instructions on resoective wikis.
### Fonts
Although it will work without, the fallback is not something desirable.
* Arch
```
sudo pacman -S ttf-inconsolata gsfonts
```
* Ubuntu
```
sudo apt-get install fonts-inconsolata
should be installed from the get go(sudo apt-get install gsfonts)
```
### Features
* Speedtest
For some reasons, conky will hangs for some time everytime it does the speedtest.
Remove the feature then, wouldn't you say? NOOBIE POWER! YOU CAN'T! (soon you can!)
* Arch
```
sudo pacman -S speedtest-cli
```
* Ubuntu
```
sudo apt-get install speedtest-cli
```


Everything is set! Run conky in terminal! or somewhere else!
## Screenshot
not updated regularly.
![Screenshot](https://raw.githubusercontent.com/zaen323/conky/master/Screenshot.png)
