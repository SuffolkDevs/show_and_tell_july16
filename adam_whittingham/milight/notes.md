0        blue
30       light blue
60       cyan
90       green
120      lime
150      orange
180      pink
210      magenta
240      lilac
270      blue
300      cyan
330      aquamarine
360      green

0  = 255
25 = 280
50 = 305


Need to add:
H / 360 * 255

red =   H  0, M 170
green = H120, M  85
blue =  H240, M   0


0 / 360 * 255 + 170



  :blue    =>   0, "0000FF"                          : 00000000
  :cyan    =>  64, "00FFFF"        64                : 01000000
  :green   =>  96, "00FF00",       64 + 32           : 01100000
  :yellow  => 128, "FFFF00", 128            + 8      : 10000100
  :red     => 170, "FF0000", 128 +       32 + 8  + 2 : 10101010
  :magenta => 202, "FF00FF", 128 + 64                : 11000000

blue  -> cyan = 0   ->  64  = 64
cyan  -> gre  = 64  ->  96  = 32
green -> yel  = 96  -> 128  = 32
yel   -> red  = 128 -> 170  = 42
red   -> mag  = 170 -> 202  = 32
mag   -> blu  = 202 -> 255  = 54
