# Logitech G510 and G710+ G button support for MacOS

gmac writes via USB a new keymap for your G buttons directly on your Keyboard until to the next reboot **with** key-repeat support!

### Support
- Logitech G510
- Logitech G710+

### Usage
    gmac -m MODEL -r
    gmac -m MODEL -w KEYMAP
    gmac (-t | --table)
    gmac (-d | --donate)
    gmac (-h | --help)
    gmac --version

### Options
    -m --model    Logitech G510 and G710 are currenty supported.
    -r --read     Read keymap from the keyboard
    -w --write    Write keymap to the keyboard
    -t --table    Show USB HID usage table for keyboards
    -d --donate   Makes me happy
    -h --help     Show this screen

### Example
    gmac -m G710 -w 0x3a,0x3b,0x3b,0x3d,0x0e,0x13
    writes G1=F1, G2=F2, G3=F3, G4=F4, G5=K G6=P

### Keymap
    G710 format: 0xff,0xff,0xff,0xff,0xff,0xff
    G510 format: 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
                 0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff

### License

Copyright (c) 2016 Oliver Cermann, MIT License
