<kbd>
  <a href="img/rice-2021-05-30.png"><img src="img/rice-2021-05-30.png"></a>
</kbd>

### bmilcs/dotfiles

``` bash
# deploy my dotfiles
git clone --depth=1 https://dot.bmilcs.com bm && cd bm && ./install.sh
```

- [zsh](/zsh/.config/zsh/) (shell)
- [vim](/vim/.config/nvim) (text editor)
- [i3](/opt/i3/.config/i3) (window manager)
- [polybar](/opt/polybar/.config/polybar/) (*task/status bar*)
- [rofi](/opt/rofi/.config/rofi) (dmenu replacement)
- [picom](/opt/picom/.config/picom/config) (compositor)
- [to do](#todo)

### HISTORY
---
<img align="right" src="img/gw.jpeg" width=200 style="border: 25px solid white">

> In the mid-90's, a beautiful cow-print box arrived on my parents' door step.  It was love at first sight. Twenty-four years have passed and very little has changed. 

---

I was was an avid gamer for much of my twenties and *shamefully*, I must admit: **Linux never interested me.**

Microsoft Windows was always there for all my computing needs: from 3.1 & Win95, to 98 & 2000 Pro, to 7 and now 10. Linux was 
was always the barely-known and "inferior" alternative -- why would I bother?

Well... In 2016, network attached storage (NAS) became a personal obsession, and I stumbled my way into an UnRaid license.
It's storage functionality was appreciated, but the real kicker was Docker. One thing lead to the next, a few 
enterprise level networking devices later, and it's virtualization tab started calling my name.

[**I discovered Debian and my love for Linux was born.**](https://github.com/bmilcs/linux) Outside of work hours, I lived inside PuTTY, an SSH client. From the command line to the Linux philosophy, I was hooked.

Putting food on the table still binds me to Windows for 40 hours each week.

*However*, I decided to use Linux and nothing else in my leisure time. I took the plunge 
and installed Arch as my primary OS in December of 2020:

**Welcome to my dotfiles.** 

-- bmilcs

---

<a name="todo"/>

## TODO

- [ ] pywal
- [ ] **sxiv - image viewer**
- [ ] **mailspring** 
- [ ] **qtile**
- [ ] **entr**
- [ ] github.com/chubin/rate.sx
- [x] udisk2 / udiskie automount
  - [ ] android phone 
- [x] dunst notifications

**rust**

- [ ] tldr
- [ ] prox
- [ ] exa
- [x] fd
- [x] bat
- [x] ripgrep
- [x] github aliases

**misc**
- [ ] ssh keys > private repo
- [x] autocomplete git status > diff > to add workflow

**VIM** [ref: youtube vim super powers]
- [ ] npm
- [ ] nettree
- [ ] ctrlsf - 'command line searching"
- [ ] fzf fuzzy find - to "//"
- [ ] rip grep
- [ ] bcommits? git history-like plugin
- [ ] lazygit, lazydocker, lazynpm
- [ ] anyjump search across workspace
- [x] vim autocomplete
    - [x]  all stuff within file 
    - [x]  /path/to autocomplete
    - [x] coc.vim [visual studio-like]

---

### inspirations & help

- [**xero's dotfiles**](https://github.com/xero/dotfiles)
- [**dotfile organization reddit (3yrs)**](https://www.reddit.com/r/linux/comments/61dbym/managing_dotfiles_a_survey/) 
  > One git repository for using with stow (eg. ~/.dotfiles). Git submodules for vim plugins etc. Branches for host-specific configuration, rebasing on master. Share master publicly.
  > ~/.git/ for some stuff that does not fit to the above.
  > ansible for other things that can't be done with the above.
- [**markdown help**](https://guides.github.com/features/mastering-markdown/)
- [**color theming via xresources**](https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/)

