dotfiles-mac
============
:snowflake: MacOS dotfiles and quick-start for software development.


Automated Install
-----------------

```
make install
make entertainment # optionally install entertainment software
```

See the [Makefile](Makefile) and [Brewfile](Brewfile) for details about what exactly is installed.


Manual Customizations
---------------------

### Alfred

1. Disable data-gathering Spotlight behaviors: System Preferences > Spotlight, then un-check "Spotlight Suggestions" and "Allow Spotlight Suggestions in Look up".
2. Disable the Spotlight keyboard shortcut (so that Alfred can take it): System Preferences > Spotlight, then click "Keyboard Shortcuts…", then un-check "Show Spotlight search"
3. Alfred > Preferences > General, check "Launch Alfred at login", the set the Alfred Hotkey to Command-Space.
4. [Neuter the Dock](https://medium.com/@rurka/kill-the-dock-for-macos-dcb1d4ba8c8c) (you can manually show/hide it using `cmd + option - d`):

        defaults write com.apple.dock autohide-delay -float 500
        killall Dock
5. Install the [Dracula theme](https://github.com/dracula/alfred).
6. Install the [Emoji Snippet Pack](http://joelcalifa.com/blog/alfred-emoji-snippet-pack/)

### Firefox Add-Ons

* HTTPS Everywhere
* Privacy Badger
* uBlock Origin
* 1Password
* Facebook Container
* Firefox Multi-Account Containers (Ctrl + . > Tab > 1-n for new container tab)
* Temporary Containers

### Fonts

I use [Operator Mono](https://www.typography.com/fonts/operator/styles/screensmart/) for programming. For a free alternative, check out [Matt McFarland's write-up](https://medium.com/@docodemore/an-alternative-to-operator-mono-font-6e5d040e1c7e).

### git

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

### iTerm2

[Dracula theme](https://github.com/dracula/iterm.git) for iTerm2.

### Privacy settings

This [lifehacker post](https://lifehacker.com/how-to-configure-os-x-to-protect-your-privacy-1716352334) is a good start.


Gaming
------

### Bluestacks

Android emulator. Does not play nicely with Docker (as of 2020-07).

    brew cask install bluestacks

### Minecraft

2. Download [Optifine](https://optifine.net/home), then open and run the .jar file to install it.
3. Download [BSL Shaders](https://bitslablab.com/).
4. Download [ChromaHills](https://www.chromahills.com/).
5. Run Minecraft, select the OptiFine profile.
6. In Minecraft, click Options > Video Settings > Shaders, then click the Shaders Folder button in the lower left corner. This will open the shaderpacks folder in Finder.Open a new Finder window (File > New or command-n, then Go > Downloads in the new window) and go to your Downloads folder. Drag the BSL Shaders .zip file from the Downloads folder to the Minecraft shaderpacks folder.
7. In Minecraft, select the newly displayed BSL shaders .zip. Minecraft will relaunch the UI. Click Done. And the click Done again.
8. In Minecraft, click Resource Packs from the Options screen. Next click Open Resource Pack Folder. As with the shaders, open your downloads folder, and drag the Chroma Hills .zip file to the Minecraft resourcepacks folder.
9. In Minecraft, click Done, then click Resource Packs again. Next mouse over ChromaHills, and click the Right/Play button. Then click Done. The UI will relaunch again. Click Done again.
10. Voila! Minecraft's UI isn't awful anymore!


TODO
----

* CLI to set desktop image for current space: http://osxdaily.com/2015/08/28/set-wallpaper-command-line-macosx/#comments
