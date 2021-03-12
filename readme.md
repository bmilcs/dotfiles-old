## bmilcs/dotfiles

![desktop](img/rice-2020-03-08.png)

---

- [i3-gaps](/opt/i3/.config/i3) (window manager)
- [picom](/opt/picom/.config/picom/config) (compositor)
- [polybar](/opt/polybar/.config/polybar/)(/polybar/.config/polybar/) (*task/status bar*)
- [rofi](/opt/rofi/.config/rofi/config.rasi) (dmenu replacement)
- [tmux](/opt/tmux/.tmux.conf) (ide )
- [vim](/vim/) (text editor)
- [zsh](/zsh/.zsh/) (shell)
- [goals](#goals)
- [to do](#todo)
---
## BACKGROUND

**Welcome to version 2 of my dotfiles.** 

Established in December of 2020 with 2 years of [***light* Debian experience**](https://github.com/bmilcs/linux) under my belt, this GitHub repository became the official home for my personal configuration files. Putting food on the table binds me to Microsoft Windows for 40 hours a week. However, I took the plunge and installed ArchLinux as my primary operating system within a dual-boot configuration and vow to use nothing else in my leisure time. 
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
- [x] autocomplete git status > diff > to add workflow
- [ ] ssh keys > private repo

**VIM** [ref: youtube vim super powers]
- [ ] npm
- [ ] nettree
- [x] vim autocomplete
    - [x]  all stuff within file 
    - [x]  /path/to autocomplete
    - [x] coc.vim [visual studio-like]
- [ ] ctrlsf - 'command line searching"
- [ ] fzf fuzzy find - to "//"
- [ ] rip grep
- [ ] bcommits? git history-like plugin
- [ ] lazygit, lazydocker, lazynpm
- [ ] anyjump search across workspace

---

### inspirations & help

- [**xero's dotfiles**](https://github.com/xero/dotfiles)
- [**dotfile organization reddit (3yrs)**](https://www.reddit.com/r/linux/comments/61dbym/managing_dotfiles_a_survey/) 
  > One git repository for using with stow (eg. ~/.dotfiles). Git submodules for vim plugins etc. Branches for host-specific configuration, rebasing on master. Share master publicly.
  > ~/.git/ for some stuff that does not fit to the above.
  > ansible for other things that can't be done with the above.
- [**markdown help**](https://guides.github.com/features/mastering-markdown/)
- [**color theming via xresources**](https://www.reddit.com/r/unixporn/comments/8giij5/guide_defining_program_colors_through_xresources/)

