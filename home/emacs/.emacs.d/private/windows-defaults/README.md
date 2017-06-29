# windows-defaults

This package customizes Spacemacs with a set of keybindings and behaviours that
will be familiar to a Microsoft Windows user. The keybindings were created by
analysing shortcuts in Visual Studio, Notepad++, Windows itself, the CUA
standard, and to a small extent Microsoft Office.

A spreadsheet was then created summarising the differences. It can be
seen [here](windows_keys.ods) (ods format).

CUA-mode is used, so that the familiar C-x, C-c, C-v keybindings work. Some
Emacs functions have been moved to different keys (search is C-f, for example),
but a surprisingly large number remain on their default keys.

This layer installs a minimal set of small packages, it doesn't bring in
anything heavyweight, just enough to create some handy keybindings.

### Installation

The easiest way is to clone this repo directly into your Spacemacs *layers* folder:

    git clone https://github.com/PhilipDaniels/windows-defaults ~/.emacs.d/layers/windows-defaults

Alternatively, you can clone to an arbitrary folder, but you must add that
folder to your custom layer load path, for example:

    dotspacemacs-configuration-layer-path '("~/repos/spacemacs")

After either of the above, then just add `windows-defaults` to your
`dotspacemacs-configuration-layers` variable in your `.spacemacs` file in the usual way.

### CUA mode

[CUA mode](https://www.gnu.org/software/emacs/manual/html_node/emacs/CUA-Bindings.html) is
turned on. From the manual:

    When CUA mode is enabled, the keys C-x, C-c, C-v, and C-z invoke commands
    that cut (kill), copy, paste (yank), and undo respectively. The C-x and C-c
    keys perform cut and copy only if the region is active. Otherwise, they
    still act as prefix keys, so that standard Emacs commands like C-x C-c still
    work.

### Arrow keys

The standard meaning of the arrow keys is preserved:

    C-<arrow> means "move by words"
    S-<arrow> means "extend selection"
    C-S-<arrow> means "extend selection while moving by words"

In addition, the `windmove` and `buf-move` packages are used to make moving
around windows very quick and easy:

    M-<arrow> means "select window in that direction"
    M-S-<arrow> means "swap this buffer with that one"

### Buffer selection

The package `cycle-buffer` is used to quickly cycle the selected buffer within a
window.

    C-<PgUp>/<PgDn> means "select next/prev *interesting* buffer"
    S-<PgUp>/<PgDn> means "select next/prev buffer showing *all* buffers"

In addition, `C-<tab>` will bring up `helm-mini`, by analogy with the
quick-switch window in Visual Studio.

### Opening and Saving Files

    C-o means "open file" (via helm-find-files)
    M-o means "find alternate file" (e.g. flip from .cpp to .hpp)
    C-S-o means "reread file from disk"
    C-M-o means "reopen using sudo"
    C-n means "new file"
    C-s means "save file"
    M-s means "save as" (renames buffer and file)
    C-M-s means "save a copy" (saves a copy to a new file, keep working with current)
    C-S-s means "save all" (with prompting)

### Basic Editing

    C-' means "expand region". Also on F2 (by analogy with MS Excel).
    C-@ means "shrink region". Also on S-F2.

    C-S-a means "select all" (unfortunately `C-a` is too common to rebind)
    M-c means "copy current line or the region's line"
    C-M-c means "duplicate current line or the region's lines"
    M-g means "go to something" (Spacemacs default key)
    C-i means "indent buffer" a.k.a. "format document"
    C-j means "delete all whitespace around point EXCEPT for a newline" - "j = join"
    M-j means "delete all whitespace around point"
    C-S-j means "delete all whitespace around point EXCEPT for one space"
    C-l means "delete the entire line"
    M-q means "fill or unfill this paragraph" - repeated use toggles
    C-u means "toggle case" - switches between lowercase, UPPERCASE and Cap Case.
    M-v means "show pastable items"
    C-y means "repeat the last command"

    C-<return> means "select a rectangle"
    C-S-<return> means "new line below"
    C-M-<return> means "new line above"

`C-u` works on the region, or the whole word if no region is selected, removing
the need to go to the beginning of the word before invoking it.

### Searching

    C-f means "find"
    M-f means "regex find"

    C-r means "find backwards"
    M-r means "regex find backwards"

    C-h means "query replace"
    M-h means "query replace the entire buffer"
    C-S-h means "query replace regex"

### Shells and Dired

Two extremely useful keys, which work **even on remote (TRAMP) files**.

    C-S-t means "give me a terminal (shell) in the same directory as this file"
    C-S-d means "give me a dired in the same directory as this file"

The `recentf-ext` package is used to make `recentf-mode` also remember directories.

Shells are created using
the [better-shell](https://github.com/killdash9/better-shell) package, which
tries to find an idle shell to reuse, but creates a new one if none are available.

### Other

    M-S-<return> means "toggle full screen"
    F1 is the help key. e.g. "F1 f" gets help on functions.
    M-F5 means "redraw window"
    M-<backspace> means "undo" (Windows standard).

# TODO/BUGS

* Visual Studio function keys - or defer such things
  to [realgud](https://github.com/realgud/realgud), which has some VS-compatible
  keybindings?
* After exiting CUA rectangle mark mode C-z is no longer undo
* M-q doesn't always toggle paragraph filling
* Multiple cursors
* TAGS / GNU Global
* Code folding
* Registers?
* Bookmarks?
* See spreadsheet for others
