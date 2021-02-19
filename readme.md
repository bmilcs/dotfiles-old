# BMILCS: DOTFILES
> A few weeks into my journey... 01.02.2021

![desktop](img/rice.png)
 
**Welcome to version 2 of my dotfiles.** 

Established in December of 2020 with 2 years of [***light* Debian experience**](https://github.com/bmilcs/linux) under my belt, this GitHub repository became the official home for my personal configuration files. Putting food on the table binds me to Microsoft Windows for 40 hours a week. However, I took the plunge and installed ArchLinux as my primary operating system within a dual-boot configuration and vow to use nothing else in my leisure time. 

---

## **NAVIGATION**
- [**zsh**](/zsh/.zsh) : shell
- [**vim**](/vim/.vim) : text editor
- [**.tmux.conf**](/tmux/.tmux.conf) : ide 
- [**bspwm**](/bspwm/.config/bspwm/bspwmrc) :  *window manager*
- [**sxhkd**](/sxhkd/.config/sxhkd/sxhkdrc) : *keyboard shortcuts*
- [**polybar**](/polybar/.config/polybar/bspwm.conf) [[**sh**]](/polybar/.config/polybar/bspwm.sh) : *task/status bar*
- [**rofi**](/rofi/.config/rofi/config.rasi) : dmenu replacement
- [**picom.conf**](/picom/.config/picom/config) : compositor
- [**to do**](#todo)
- [**my goals**](#goals)
---

<a name="todo"/>

## TODO

- [ ] **sxiv - image viewer**
- [ ] **mailspring** 
- [ ] **qtile**
- [ ] **entr**
- [ ] github.com/chubin/rate.sx
- [ ] dunst notifications
- [x] udisk2 / udiskie automount

**rust**

- [ ] tldr
- [ ] fd
- [ ] bat
- [ ] prox
- [ ] exa
- [ ] ripgrep
- [x] github aliases

**misc**
- [x] dotfiles: segment essentials | vm | workstation
- [ ] autocomplete git status > diff > to add workflow
- [ ] ssh keys > private repo
- [x] research best, quickest method for dotfile use

**VIM** [ref: youtube vim super powers]
- [ ] npm
- [ ] nettree
- [ ] vim shortcut: auto :%s/VISUAL//g
- [ ] vim autocomplete
    - [ ]  all stuff within file 
    - [ ]  /path/to autocomplete
    - [ ] coc.vim [visual studio-like]
- [ ] ctrlsf - 'command line searching"
- [ ] fzf fuzzy find - to "//"
- [ ] rip grep? same thing?
- [ ] bcommits? git history-like plugin
- [ ] lazygit, lazydocker, lazynpm
- [ ] tmux - learn tabs, buffers, etc.
- [ ] anyjump -- search across workspace
- [ ] functions() - ie: centered title bar w/ ascii characters

**BSPWM**
  - [ ] ergonomic shortcuts

**POLYBAR**
  - [ ] pkg update watcher notifications - distro/packages
  - [ ] add networking up/down

---

<a name="goals"/>
<img align="right" src="img/gw.jpeg" width=200 style="border: 25px solid white">

## GOALS

> In the mid-1990's, a box arrived in beautiful black & white cow print. It was love at first sight. It's now 24 years later and very little has changed. 

---

**VIM**
- Adapt to, Learn & Master 
- Combine Visual Studio Code's visual appeal & functionality via plugins, vimrc, shortcuts, etc.
- Universally adopt VIM-functionality across most applications
  - IE: zsh, ranger, mutt, etc.

**GitHub**
 - Learn & adopt all common functions
 - Learn & practice version control w/ dotfiles

 **Dotfiles**
 - Automate installation & backup w/o third party tool
 - Review 100's of published repo's
 - Adopt favorite means of management
 - CAT bmilcs/linux bmilcs/dotfiles >> bmilcs/bm
  - Combine Debian-based VM dotfiles with Archlinux based workstation dotfiles, achieving uniform functionality across all Linux platforms.

**Programming | Scripting**
 - Setup a proper IDE 
 - Dive into Python
 - Increase exposure to BASH syntax

---

### inspirations & help

- [**xero's dotfiles**](https://github.com/xero/dotfiles)
- [**dotfile organization reddit (3yrs)**](https://www.reddit.com/r/linux/comments/61dbym/managing_dotfiles_a_survey/) 
  > One git repository for using with stow (eg. ~/.dotfiles). Git submodules for vim plugins etc. Branches for host-specific configuration, rebasing on master. Share master publicly.
  > ~/.git/ for some stuff that does not fit to the above.
  > ansible for other things that can't be done with the above.
- [**markdown help**](https://guides.github.com/features/mastering-markdown/)
- [**color theming via xresources**](https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/)

