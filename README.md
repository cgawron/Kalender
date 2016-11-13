# Kalender
Files to create a calendar with images by means of XXSL:FO.

## Prerequisites
To use it, you need [Apache FOP](https://xmlgraphics.apache.org/fop) and Java.

## Usage
To create a calendar, you

1. create a subdirectory `images` with files `01.jpg` through `12.jpg` and `title.jpg`. If you plan to print the calendar via a professional print service (I usually use [Laserline](http:laser-line.de)), the images should be CMYK images (see below),
2. create a subdirectory `fonts` containing necessary font files (i.e. Futura.ttf),
3. Edit the `kalender.xml` to, edit image captions, add holidays and specify the first day of week for each month (yes, this should be factored out in a separate file, and much of this could actually be calculated).
4. call 
`fop -c config.xml -xsl kalender.xsl -xml kalender.xml -pdf kalender2017.pdf` 
to create the PDF. 

## Converting sRGB images to CMYK 
On Linux, you can convert sRGB iamges to CMYK using the command
```
/usr/bin/convert rgb.jpg -profile sRGB.icc -profile ISOcoated_v2_eci.icc cmyk.jpg
```
