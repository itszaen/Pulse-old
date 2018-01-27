# Conky (name suggestions are welcome)
This conky setup is hugely inspired by this great work : https://github.com/davidrlunu/dots-and-dashes

Since some updates on conky changed the syntax (!?) and made his work not working properly, I decided to make a knockoff myself.

Yep, I borrowed the wallpaper, and the general design ... well, he would understand. (It's open source baby!)

The codes are **abhorrent**. definitely something you would expect from a coding noobie. which I am. Hooray!

Some to note
* It is meant to be projected on a 1920x1080 display.
* It's using Inconsolata, Z003 & Roboto font, and the fallback font is not pretty.

## Installation
I am using ArchLinux (with KDE, not sure if that matters) , and that's all. So I am not sure how some implemention on other distros would vary. (the location of the conky folder and whatnot)
If you're using arch too, then lucky you!
* Oh and tested on ubuntu, works too! I'll test this on more distros (on virtual machine anyway)
### Lua
Conky (not my script, the system this is based on) actually uses lua 5.1 still! WOW!
* Arch
```
sudo pacman -S lua
```
#### Lua file system
* Arch
```
sudo pacman -S lua51-filesystem
```

### Conky
To display svg natively in conky (to change colors and whatnot), it uses part of the svg2cairo converter : https://github.com/akrinke/svg2cairo
BUTT! for some reason, the regular cairo packages in most of the distros' repos wouldn't support svg to xml conversion. So you have to manually build it.
Which is really a pain in the butt. PUN INTENDED

(in the future i will consider if to replace the svg images with already converted xml files. that would be nice, but a bit weird)

* Arch
1. To manually build cairo, this is the only way I know. Pacaur users, sorry, would you mind installing yaourt with pacaur? ;)
```
yaourt -S customizepkg
mkdir ~/.customizepkg
touch ~/.customizepkg/cairo
yaourt -S cairo
```
then during the installation, yaourt will ask you if you want to edit PKGBUILD, hit y
in the build() function, add "--enable-xml"
Before:
```
...
--enable-gobject \
--enable-gtk-doc
...
```
After:
```
...
--enable-gobject \
--enable-gtk-doc \
--enable-xml
...
```
then proceed to build the package(it will take a while), and install. Done!

2. Install the conky package with lua support. (nvidia, either way.)
```
yaourt -S conky-lua(-nv)
```
* Ubuntu
1. Go to :https://cairographics.org/releases/ and check what's the latest release and wget it. (should be called something like "cairo-1.14.6.tar.xz")
And do the following.
```
wget https://cairographics.org/releases/cairo-[something]
tar -xvf cairo-[something] (Use <tab>!)
cd cairo-[something]
./autogen.sh --enable-xml
make
sudo make install
```
If you encounter any error, there might be some packages missing for autobuild. Please open an issue.

2. Conky
```
sudo apt-get install conky-all
```
On other distros, make sure to have lua bindings support.
### Clone
* Arch, Ubuntu
```
git clone https://github.com/zaen323/conky.git ~/.config/conky
```
On other distros, follow the instructions on respective wikis.
### Fonts
Although it will work without, the fallback is not something desirable.
* Arch
```
sudo pacman -S ttf-inconsolata gsfonts ttf-roboto
```
* Ubuntu
```
sudo apt-get install fonts-inconsolata gs-fonts font-roboto
```

### Features
The feature requires active internet connection will tell you that it's not working when disconnected from the internet.

##### Configuration
Before you run conky, **you have to rename default_conky.lua -> conky.lua**

You can turn on or off any feature with config.lua now. Just set the "enabled" value to true or false. (with no quotation marks)
Like here: 
``` lua
...
gmail = {
  enabled = true,-- set to false to disable unread email counts.
  address = "xxx"
  ...
}
...
```
#### Speedtest
It's a bit heavy to be honest. (So if you would like to, turn it off)
* Arch
```
sudo pacman -S speedtest-cli
```
* Ubuntu
```
sudo apt-get install speedtest-cli
```
#### Weather
Uses pywapi.

```
(sudo) pip install pywapi
```

Change the areacode in config.lua if you don't live in Tokyo. (99.88% of the chance)

You can find the code for your area with https://weather.codes/

* Since I couldn't find anywhere that has weather.com's weather condition list, I am still trying to match every weather condition to a weather icon.

So please, if you have time, and ever encounter a missing icon (now it's just the whole thing glitches and shows error in the terminal)

1. uncomment the line "--print(summary,second_summary,third_summary,fourth_summary)" by removing the leading 2 hyphens.
2. restart conky.
3. copy the outcome.
4. file a issue or better off a pull request (if you know what to do).
> The matching table is at src/weather.lua's weather_icon_name() and forecast_icon_name().


#### Info
##### Package needing update
Only on Arch Linux & Ubuntu
##### Timetable
Tells you what the next class is, and how much time is left till that.
** It's off default, change it in the config file**

There's a timetable_example.txt file, write your schedules into it, rename it to timetable.txt (or whatever name you prefer, place it whereever you want, but do not forget to tell conky in the configurtion file) .

* Do not delete or modify the weekday line ("MONDAY","TUESDAY", ...)
* Go look into the config file before you start

##### Unread email
Supported: Gmail

###### Gmail
Uses curl to read gmail's atom API feed.

Don't forget to replace the address & password placeholder with your own in the configuration file.

* **If you are using 2-factor authentication method, the password must be the one you generate at :https://myaccount.google.com/apppasswords**
* **If not, go here:https://myaccount.google.com/lesssecureapps and enable less secure apps. (It's okay.)**

#### Calendar
Supported: Google Calendar
Uses google's calendar API with python.

*Arch
```
sudo pacman -S python-google-api-python-client python-dateutil
```

*Others
```
(sudo) pip install google-api-python-client python-dateutil
```

#### Word of the day (Powered by Dictionary.com)
what is "decathect"? (the first one I got)

Everything is set! Run conky in terminal! or somewhere else!


## Screenshot
not updated regularly.
![Screenshot](Screenshot.png)

## License
[APACHE](LICENSE)

## Special thanks to
* [davidrlunu](https://github.com/davidrlunu)

Idea, design philosophy

* My father

Maths

* [akrinke](https://github.com/akrinke)

svg2cairo

* [houranos](https://github.com/houranos)

Google Calendar API
