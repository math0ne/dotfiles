;;; terminal-theme.el --- A fruity color theme for Emacs.

;; Copyright (C) 2011-2016

;; Author: Kelvin Smith <oneKelvinSmith@gmail.com>
;; URL: http://github.com/oneKelvinSmith/terminal-emacs
;; Package-Version: 20170314.1612
;; Version: 3.3.0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A port of the popular Textmate theme terminal for Emacs 24, built on top
;; of the new built-in theme support in Emacs 24.
;;
;;; Credits:
;;
;; Wimer Hazenberg created the original theme.
;; - http://www.terminal.nl/blog/2006/07/15/textmate-color-theme/
;;
;; Bozhidar Batsov created zenburn-theme.el and solarized-theme.el
;;  on which this file is based.
;; - https://github.com/bbatsov/zenburn-emacs
;;
;; Color Scheme Designer 3 for complementary colours.
;; - http://colorschemedesigner.com/
;;
;; Xterm 256 Color Chart
;; - https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
;;
;; K. Adam Christensen for his personal terminal theme that addresses 256 colours.
;; - https://github.com/pope/personal/blob/master/etc/emacs.d/terminal-theme.el
;;
;; Thomas Frössman for his work on solarized-emacs.
;; - http://github.com/bbatsov/solarized-emacs
;;
;;; Code:


(unless (>= emacs-major-version 24)
  (error "The terminal theme requires Emacs 24 or later!"))

(deftheme terminal "The terminal colour theme")

(defgroup terminal nil
  "terminal theme options.
The theme has to be reloaded after changing anything in this group."
  :group 'faces)

(defcustom terminal-distinct-fringe-background nil
  "Make the fringe background different from the normal background color.
Also affects 'linum-mode' background."
  :type 'boolean
  :group 'terminal)

(defcustom terminal-use-variable-pitch nil
  "Use variable pitch face for some headings and titles."
  :type 'boolean
  :group 'terminal)

(defcustom terminal-height-minus-1 0.8
  "Font size -1."
  :type 'number
  :group 'terminal)

(defcustom terminal-height-plus-1 1.1
  "Font size +1."
  :type 'number
  :group 'terminal)

(defcustom terminal-height-plus-2 1.15
  "Font size +2."
  :type 'number
  :group 'terminal)

(defcustom terminal-height-plus-3 1.2
  "Font size +3."
  :type 'number
  :group 'terminal)

(defcustom terminal-height-plus-4 1.3
  "Font size +4."
  :type 'number
  :group 'terminal)

;; Primary colors
(defcustom terminal-yellow "Yellow"
  "Primary colors - yellow"
  :type 'string
  :group 'terminal)

(defcustom terminal-orange "BrightRed"
  "Primary colors - orange"
  :type 'string
  :group 'terminal)

(defcustom terminal-red "BrightMagenta"
  "Primary colors - red"
  :type 'string
  :group 'terminal)

(defcustom terminal-magenta "Magenta"
  "Primary colors - magenta"
  :type 'string
  :group 'terminal)

(defcustom terminal-blue "Blue"
  "Primary colors - blue"
  :type 'string
  :group 'terminal)

(defcustom terminal-green "Green"
  "Primary colors - green"
  :type 'string
  :group 'terminal)

(defcustom terminal-cyan "BrightBlue"
  "Primary colors - cyan"
  :type 'string
  :group 'terminal)

(defcustom terminal-violet "Magenta"
  "Primary colors - violet"
  :type 'string
  :group 'terminal)

(defcustom terminal-gray "BrightBlack"
  "Primary colors - gray"
  :type 'string
  :group 'terminal)

(defcustom terminal-foreground "White"
  "Adaptive colors - foreground"
  :type 'string
  :group 'terminal)

(defcustom terminal-background nil
  "Adaptive colors - background"
  :type 'string
  :group 'terminal)

(defcustom terminal-comments "#75715E"
  "Adaptive colors - comments"
  :type 'string
  :group 'terminal)

(defcustom terminal-emphasis "#F8F8F0"
  "Adaptive colors - emphasis"
  :type 'string
  :group 'terminal)

(defcustom terminal-line-number "#8F908A"
  "Adaptive colors - line number"
  :type 'string
  :group 'terminal)

(defcustom terminal-highlight "#49483E"
  "Adaptive colors - highlight"
  :type 'string
  :group 'terminal)

(defcustom terminal-highlight-alt "#3E3D31"
  "Adaptive colors - highlight"
  :type 'string
  :group 'terminal)

(defcustom terminal-highlight-line "#3C3D37"
  "Adaptive colors - line highlight"
  :type 'string
  :group 'terminal)

(let* (;; Variable pitch
       (terminal-pitch (if terminal-use-variable-pitch
                          'variable-pitch
                        'default))

       ;; Definitions for guis that support 256 colors
       (terminal-class '((class color) (min-colors 257)))

       ;; Darker and lighter accented colors
       (terminal-yellow-d       "Green")
       (terminal-yellow-l       "Yellow")
       (terminal-orange-d       "BrightYellow")
       (terminal-orange-l       "BrightYellow")
       (terminal-red-d          "Red")
       (terminal-red-l          "BrightRed")
       (terminal-magenta-d      "BrightRed")
       (terminal-magenta-l      "BrightMagenta")
       (terminal-violet-d       "Magenta")
       (terminal-violet-l       "Magenta")
       (terminal-blue-d         "Blue")
       (terminal-blue-l         "BrightBlue")
       (terminal-cyan-d         "Cyan")
       (terminal-cyan-l         "BrightCyan")
       (terminal-green-d        "Green")
       (terminal-green-l        "BrightGreen")
       (terminal-gray-d         "BrightBlack")
       (terminal-gray-l         "BrightBlack")
       ;; Adaptive higher/lower contrast accented colors
       (terminal-foreground-hc  "Black")
       (terminal-foreground-lc  "Black")
       ;; High contrast colors
       (terminal-yellow-hc      "Yellow")
       (terminal-yellow-lc      "Green")
       (terminal-orange-hc      "Yellow")
       (terminal-orange-lc      "BrightYellow")
       (terminal-red-hc         "BrightMagenta")
       (terminal-red-lc         "Red")
       (terminal-magenta-hc     "BrightMagenta")
       (terminal-magenta-lc     "Red")
       (terminal-violet-hc      "Blue")
       (terminal-violet-lc      "Magenta")
       (terminal-blue-hc        "Cyan")
       (terminal-blue-lc        "Blue")
       (terminal-cyan-hc        "BrightCyan")
       (terminal-cyan-lc        "BrightBlue")
       (terminal-green-hc       "BrightGreen")
       (terminal-green-lc       "Green")

       ;; Distinct fringe
       (terminal-fringe-bg (if terminal-distinct-fringe-background
                              terminal-gray
                            terminal-background))

       ;; Definitions for terminals that do not support 256 colors
       (terminal-256-class '((class color) (min-colors 89)))
       ;; Primary colors
       (terminal-256-yellow         "Red")
       (terminal-256-orange         "Yellow")
       (terminal-256-red            "Red")
       (terminal-256-magenta        "Magenta")
       (terminal-256-violet         "BrightYellow")
       (terminal-256-blue           "Blue")
       (terminal-256-cyan           "Cyan")
       (terminal-256-green          "Green")
       (terminal-256-gray           "Black")
       ;; Darker and lighter accented colors
       (terminal-256-yellow-d       "Yellow")
       (terminal-256-yellow-l       "BrightYellow")
       (terminal-256-orange-d       "BrightRed")
       (terminal-256-orange-l       "BrightRed")
       (terminal-256-red-d          "Red")
       (terminal-256-red-l          "Magenta")
       (terminal-256-magenta-d      "BrightMagenta")
       (terminal-256-magenta-l      "BrightMagenta")
       (terminal-256-violet-d       "Magenta")
       (terminal-256-violet-l       "Magenta")
       (terminal-256-blue-d         "BrightYellow")
       (terminal-256-blue-l         "Blue")
       (terminal-256-cyan-d         "Blue")
       (terminal-256-cyan-l         "BrightBlue")
       (terminal-256-green-d        "BrightYellow")
       (terminal-256-green-l        "BrightYellow")
       (terminal-256-gray-d         "BrightBlack")
       (terminal-256-gray-l         "BrightBlack")
       ;; Adaptive colors
       (terminal-256-foreground     "White")
       (terminal-256-background     nil)
       (terminal-256-comments       "Cyan")
       (terminal-256-emphasis       "BrightWhite")
       (terminal-256-line-number    "BrightCyan")
       (terminal-256-highlight      "BrightBlack")
       (terminal-256-highlight-alt  "BrightBlack")
       (terminal-256-highlight-line "Black")
       ;; Adaptive higher/lower contrast accented colors
       (terminal-256-foreground-hc  "Black")
       (terminal-256-foreground-lc  "Black")
       ;; High contrast colors
       (terminal-256-yellow-hc      terminal-256-yellow-d)
       (terminal-256-yellow-lc      terminal-256-yellow-l)
       (terminal-256-orange-hc      terminal-256-orange-d)
       (terminal-256-orange-lc      terminal-256-orange-l)
       (terminal-256-red-hc         terminal-256-red-d)
       (terminal-256-red-lc         terminal-256-red-l)
       (terminal-256-magenta-hc     terminal-256-magenta-d)
       (terminal-256-magenta-lc     terminal-256-magenta-l)
       (terminal-256-violet-hc      terminal-256-violet-d)
       (terminal-256-violet-lc      terminal-256-violet-l)
       (terminal-256-blue-hc        terminal-256-blue-d)
       (terminal-256-blue-lc        terminal-256-blue-l)
       (terminal-256-cyan-hc        terminal-256-cyan-d)
       (terminal-256-cyan-lc        terminal-256-cyan-l)
       (terminal-256-green-hc       terminal-256-green-d)
       (terminal-256-green-lc       terminal-256-green-l)

       ;; Distinct fringe
       (terminal-256-fringe-bg (if terminal-distinct-fringe-background
                                  terminal-256-gray
                                terminal-256-background)))

  ;; Define faces
  (custom-theme-set-faces
   'terminal

   ;; font lock for syntax highlighting
   `(font-lock-builtin-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight normal))))

   `(font-lock-comment-delimiter-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(font-lock-comment-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(font-lock-constant-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(font-lock-doc-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(font-lock-function-name-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(font-lock-keyword-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight normal))))

   `(font-lock-negation-char-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(font-lock-preprocessor-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(font-lock-regexp-grouping-construct
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal))))

   `(font-lock-regexp-grouping-backslash
     ((,terminal-class (:foreground ,terminal-violet
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :weight normal))))

   `(font-lock-string-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(font-lock-type-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :italic nil))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :italic nil))))

   `(font-lock-variable-name-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(font-lock-warning-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold
                                   :italic t
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold
                                        :italic t
                                        :underline t))))

   `(c-annotation-face
     ((,terminal-class (:inherit font-lock-constant-face))
      (,terminal-256-class  (:inherit font-lock-constant-face))))





   ;; general colouring
   '(button ((t (:underline t))))

   `(default
      ((,terminal-class (:foreground ,terminal-foreground
                                    :background ,terminal-background))
       (,terminal-256-class  (:foreground ,terminal-256-foreground
                                         :background ,terminal-256-background))))

   `(highlight
     ((,terminal-class (:background ,terminal-highlight))
      (,terminal-256-class  (:background ,terminal-256-highlight))))

   `(lazy-highlight
     ((,terminal-class (:inherit highlight
                                :background ,terminal-highlight-alt))
      (,terminal-256-class  (:inherit highlight
                                     :background ,terminal-256-comments))))

   `(region
     ((,terminal-class (:inherit highlight
                                :background ,terminal-highlight))
      (,terminal-256-class  (:inherit highlight
                                     :background ,terminal-256-highlight))))

   `(secondary-selection
     ((,terminal-class (:inherit region
                                :background ,terminal-highlight-alt))
      (,terminal-256-class  (:inherit region
                                     :background ,terminal-256-highlight-alt))))

   `(shadow
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(match
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background
                                        :weight bold))))

   `(cursor
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-foreground
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-foreground
                                        :inverse-video t))))

   `(mouse
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-foreground
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-foreground
                                        :inverse-video t))))

   `(escape-glyph
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(escape-glyph-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(fringe
     ((,terminal-class (:foreground ,terminal-foreground
                                   :background ,terminal-fringe-bg))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :background ,terminal-256-fringe-bg))))

   `(link
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline t
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline t
                                        :weight bold))))

   `(link-visited
     ((,terminal-class (:foreground ,terminal-violet
                                   :underline t
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :underline t
                                        :weight normal))))

   `(success
     ((,terminal-class (:foreground ,terminal-green ))
      (,terminal-256-class  (:foreground ,terminal-256-green ))))

   `(warning
     ((,terminal-class (:foreground ,terminal-yellow ))
      (,terminal-256-class  (:foreground ,terminal-256-yellow ))))

   `(error
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(eval-sexp-fu-flash
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-green))))

   `(eval-sexp-fu-flash-error
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-red))))

   `(trailing-Whitespace
     ((,terminal-class (:background ,terminal-red))
      (,terminal-256-class  (:background ,terminal-256-red))))

   `(vertical-border
     ((,terminal-class (:foreground ,terminal-gray))
      (,terminal-256-class  (:foreground ,terminal-256-gray))))

   `(menu
     ((,terminal-class (:foreground ,terminal-foreground
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :background ,terminal-256-background))))

   `(minibuffer-prompt
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   ;; mode-line and powerline
   `(mode-line-buffer-id
     ((,terminal-class (:foreground ,"Black"
                                   :background "BrightYellow"))
      (,terminal-256-class  (:foreground ,"Black"
                                        :background "BrightYellow"))))

   `(mode-line
     ((,terminal-class (:inverse-video unspecified
                                      :underline unspecified
                                      :foreground ,"Black"
                                      :background ,"BrightYellow"
                                      :box (:line-width 1
                                                        :color ,terminal-gray
                                                        :style unspecified)))
      (,terminal-256-class  (:inverse-video unspecified
                                           :underline unspecified
                                           :foreground ,"Black"
                                           :background ,"BrightYellow"
                                           :box (:line-width 1
                                                             :color ,terminal-256-highlight
                                                             :style unspecified)))))

 ;; mode-line and powerline
 `(powerline-active1
   ((,terminal-class (:foreground ,"White"
                                 :background "Cyan"))
    (,terminal-256-class  (:foreground ,"White"
                                      :background "Cyan"))))


  `(powerline-active2
    ((,terminal-class (:foreground ,"Black"
                                  :background "Black"))
     (,terminal-256-class  (:foreground ,"Black"
                                       :background "Black"))))



   `(mode-line-inactive
     ((,terminal-class (:inverse-video unspecified
                                      :underline unspecified
                                      :foreground ,"Black"
                                      :background ,"BrightYellow"
                                      :box (:line-width 1
                                                        :color ,terminal-gray
                                                        :style unspecified)))
      (,terminal-256-class  (:inverse-video unspecified
                                           :underline unspecified
                                           :foreground ,"Black"
                                           :background ,"BrightYellow"
                                           :box (:line-width 1
                                                             :color ,terminal-256-highlight
                                                             :style unspecified)))))



   `(powerline-inactive1
     ((,terminal-class (:foreground ,"White"
                                   :background "Cyan"))
      (,terminal-256-class  (:foreground ,"White"
                                        :background "Cyan"))))

   `(powerline-inactive2
     ((,terminal-class (:foreground ,"Black"
                                   :background "Black"))
      (,terminal-256-class  (:foreground ,"Black"
                                        :background "Black"))))

   ;; header-line
   `(header-line
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-highlight
                                   :box (:color ,terminal-gray
                                                :line-width 1
                                                :style unspecified)))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-highlight
                                        :box (:color ,terminal-256-gray
                                                     :line-width 1
                                                     :style unspecified)))))

   ;; cua
   `(cua-global-mark
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-background))))

   `(cua-rectangle
     ((,terminal-class (:inherit region))
      (,terminal-256-class  (:inherit region))))

   `(cua-rectangle-noselect
     ((,terminal-class (:inherit secondary-selection))
      (,terminal-256-class  (:inherit secondary-selection))))

   ;; diary
   `(diary
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   ;; dired
   `(dired-directory
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(dired-flagged
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(dired-header
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background
                                        :inherit bold))))

   `(dired-ignored
     ((,terminal-class (:inherit shadow))
      (,terminal-256-class  (:inherit shadow))))

   `(dired-mark
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   `(dired-marked
     ((,terminal-class (:foreground ,terminal-violet
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :inherit bold))))

   `(dired-perm-write
     ((,terminal-class (:foreground ,terminal-foreground
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :underline t))))

   `(dired-symlink
     ((,terminal-class (:foreground ,terminal-cyan
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :slant italic))))

   `(dired-warning
     ((,terminal-class (:foreground ,terminal-orange
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :underline t))))

   ;; dropdown
   `(dropdown-list-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-blue))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-blue))))

   `(dropdown-list-selection-face
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background))))

   ;; ecb
   `(ecb-default-highlight-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(ecb-history-bucket-node-dir-soure-path-face
     ((,terminal-class (:inherit ecb-history-bucket-node-face
                                :foreground ,terminal-yellow))
      (,terminal-256-class  (:inherit ecb-history-bucket-node-face
                                     :foreground ,terminal-256-yellow))))

   `(ecb-source-in-directories-buffer-face
     ((,terminal-class (:inherit ecb-directories-general-face
                                :foreground ,terminal-foreground))
      (,terminal-256-class  (:inherit ecb-directories-general-face
                                     :foreground ,terminal-256-foreground))))

   `(ecb-history-dead-buffer-face
     ((,terminal-class (:inherit ecb-history-general-face
                                :foreground ,terminal-comments))
      (,terminal-256-class  (:inherit ecb-history-general-face
                                     :foreground ,terminal-256-comments))))

   `(ecb-directory-not-accessible-face
     ((,terminal-class (:inherit ecb-directories-general-face
                                :foreground ,terminal-comments))
      (,terminal-256-class  (:inherit ecb-directories-general-face
                                     :foreground ,terminal-256-comments))))

   `(ecb-bucket-node-face
     ((,terminal-class (:inherit ecb-default-general-face
                                :weight normal
                                :foreground ,terminal-blue))
      (,terminal-256-class  (:inherit ecb-default-general-face
                                     :weight normal
                                     :foreground ,terminal-256-blue))))

   `(ecb-tag-header-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(ecb-analyse-bucket-element-face
     ((,terminal-class (:inherit ecb-analyse-general-face
                                :foreground ,terminal-green))
      (,terminal-256-class  (:inherit ecb-analyse-general-face
                                     :foreground ,terminal-256-green))))

   `(ecb-directories-general-face
     ((,terminal-class (:inherit ecb-default-general-face
                                :height 1.0))
      (,terminal-256-class  (:inherit ecb-default-general-face
                                     :height 1.0))))

   `(ecb-method-non-semantic-face
     ((,terminal-class (:inherit ecb-methods-general-face
                                :foreground ,terminal-cyan))
      (,terminal-256-class  (:inherit ecb-methods-general-face
                                     :foreground ,terminal-256-cyan))))

   `(ecb-mode-line-prefix-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(ecb-tree-guide-line-face
     ((,terminal-class (:inherit ecb-default-general-face
                                :foreground ,terminal-gray
                                :height 1.0))
      (,terminal-256-class  (:inherit ecb-default-general-face
                                     :foreground ,terminal-256-gray
                                     :height 1.0))))

   ;; ee
   `(ee-bookmarked
     ((,terminal-class (:foreground ,terminal-emphasis))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis))))

   `(ee-category
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(ee-link
     ((,terminal-class (:inherit link))
      (,terminal-256-class  (:inherit link))))

   `(ee-link-visited
     ((,terminal-class (:inherit link-visited))
      (,terminal-256-class  (:inherit link-visited))))

   `(ee-marked
     ((,terminal-class (:foreground ,terminal-magenta
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :weight bold))))

   `(ee-omitted
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(ee-shadow
     ((,terminal-class (:inherit shadow))
      (,terminal-256-class  (:inherit shadow))))

   ;; grep
   `(grep-context-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(grep-error-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold
                                        :underline t))))

   `(grep-hit-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(grep-match-face
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   ;; isearch
   `(isearch
     ((,terminal-class (:inherit region
                                :background ,terminal-green))
      (,terminal-256-class  (:inherit region
                                     :background ,terminal-256-green))))

   `(isearch-fail
     ((,terminal-class (:inherit isearch
                                :foreground ,terminal-red
                                :background ,terminal-background
                                :bold t))
      (,terminal-256-class  (:inherit isearch
                                     :foreground ,terminal-256-red
                                     :background ,terminal-256-background
                                     :bold t))))


   ;; ace-jump-mode
   `(ace-jump-face-background
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-background
                                   :inverse-video nil))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-background
                                        :inverse-video nil))))

   `(ace-jump-face-foreground
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background ,terminal-background
                                   :inverse-video nil
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background ,terminal-256-background
                                        :inverse-video nil
                                        :weight bold))))

   ;; auctex
   `(font-latex-bold-face
     ((,terminal-class (:inherit bold
                                :foreground ,terminal-emphasis))
      (,terminal-256-class  (:inherit bold
                                     :foreground ,terminal-256-emphasis))))

   `(font-latex-doctex-documentation-face
     ((,terminal-class (:background unspecified))
      (,terminal-256-class  (:background unspecified))))

   `(font-latex-doctex-preprocessor-face
     ((,terminal-class
       (:inherit (font-latex-doctex-documentation-face
                  font-lock-builtin-face
                  font-lock-preprocessor-face)))
      (,terminal-class
       (:inherit (font-latex-doctex-documentation-face
                  font-lock-builtin-face
                  font-lock-preprocessor-face)))))

   `(font-latex-italic-face
     ((,terminal-class (:inherit italic :foreground ,terminal-emphasis))
      (,terminal-256-class  (:inherit italic :foreground ,terminal-256-emphasis))))

   `(font-latex-math-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(font-latex-sectioning-0-face
     ((,terminal-class (:inherit font-latex-sectioning-1-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit font-latex-sectioning-1-face
                                     :height ,terminal-height-plus-1))))

   `(font-latex-sectioning-1-face
     ((,terminal-class (:inherit font-latex-sectioning-2-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit font-latex-sectioning-2-face
                                     :height ,terminal-height-plus-1))))

   `(font-latex-sectioning-2-face
     ((,terminal-class (:inherit font-latex-sectioning-3-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit font-latex-sectioning-3-face
                                     :height ,terminal-height-plus-1))))

   `(font-latex-sectioning-3-face
     ((,terminal-class (:inherit font-latex-sectioning-4-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit font-latex-sectioning-4-face
                                     :height ,terminal-height-plus-1))))

   `(font-latex-sectioning-4-face
     ((,terminal-class (:inherit font-latex-sectioning-5-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit font-latex-sectioning-5-face
                                     :height ,terminal-height-plus-1))))

   `(font-latex-sectioning-5-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-yellow
                                :weight bold))
      (,terminal-256-class  (:inherit ,terminal-pitch :
                                     foreground ,terminal-256-yellow
                                     :weight bold))))

   `(font-latex-sedate-face
     ((,terminal-class (:foreground ,terminal-emphasis))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis))))

   `(font-latex-slide-title-face
     ((,terminal-class (:inherit (,terminal-pitch font-lock-type-face)
                                :weight bold
                                :height ,terminal-height-plus-3))
      (,terminal-256-class  (:inherit (,terminal-pitch font-lock-type-face)
                                     :weight bold
                                     :height ,terminal-height-plus-3))))

   `(font-latex-string-face
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(font-latex-subscript-face
     ((,terminal-class (:height ,terminal-height-minus-1))
      (,terminal-256-class  (:height ,terminal-height-minus-1))))

   `(font-latex-superscript-face
     ((,terminal-class (:height ,terminal-height-minus-1))
      (,terminal-256-class  (:height ,terminal-height-minus-1))))

   `(font-latex-verbatim-face
     ((,terminal-class (:inherit fixed-pitch
                                :foreground ,terminal-foreground
                                :slant italic))
      (,terminal-256-class  (:inherit fixed-pitch
                                     :foreground ,terminal-256-foreground
                                     :slant italic))))

   `(font-latex-warning-face
     ((,terminal-class (:inherit bold
                                :foreground ,terminal-orange))
      (,terminal-256-class  (:inherit bold
                                     :foreground ,terminal-256-orange))))

   ;; auto-complete
   `(ac-candidate-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-blue))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-blue))))

   `(ac-selection-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(ac-candidate-mouse-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(ac-completion-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :underline t))))

   `(ac-gtags-candidate-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-blue))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-blue))))

   `(ac-gtags-selection-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(ac-yasnippet-candidate-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-yellow))))

   `(ac-yasnippet-selection-face
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-background))))

   ;; auto highlight symbol
   `(ahs-definition-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-blue))))

   `(ahs-edit-mode-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-highlight))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-highlight))))

   `(ahs-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :background unspecified))))

   `(ahs-plugin-bod-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-violet ))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-cyan ))))

   `(ahs-plugin-defalt-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-orange))))

   `(ahs-plugin-whole-buffer-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-green))))

   `(ahs-warning-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold))))

   ;; android mode
   `(android-mode-debug-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(android-mode-error-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold))))

   `(android-mode-info-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(android-mode-verbose-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(android-mode-warning-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   ;; anzu-mode
   `(anzu-mode-line
     ((,terminal-class (:foreground ,terminal-violet
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :weight bold))))

   ;; bm
   `(bm-face
     ((,terminal-class (:background ,terminal-yellow-lc
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc
                                        :foreground ,terminal-256-background))))

   `(bm-fringe-face
     ((,terminal-class (:background ,terminal-yellow-lc
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc
                                        :foreground ,terminal-256-background))))

   `(bm-fringe-persistent-face
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-background))))

   `(bm-persistent-face
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-background))))

   ;; calfw
   `(cfw:face-day-title
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(cfw:face-annotation
     ((,terminal-class (:inherit cfw:face-day-title
                                :foreground ,terminal-yellow))
      (,terminal-256-class  (:inherit cfw:face-day-title
                                     :foreground ,terminal-256-yellow))))

   `(cfw:face-default-content
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(cfw:face-default-day
     ((,terminal-class (:inherit cfw:face-day-title
                                :weight bold))
      (,terminal-256-class  (:inherit cfw:face-day-title
                                     :weight bold))))

   `(cfw:face-disable
     ((,terminal-class (:inherit cfw:face-day-title
                                :foreground ,terminal-comments))
      (,terminal-256-class  (:inherit cfw:face-day-title
                                     :foreground ,terminal-256-comments))))

   `(cfw:face-grid
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(cfw:face-header
     ((,terminal-class (:foreground ,terminal-blue-hc
                                   :background ,terminal-blue-lc
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue-hc
                                        :background ,terminal-256-blue-lc
                                        :weight bold))))

   `(cfw:face-holiday
     ((,terminal-class (:background nil
                                   :foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:background nil
                                        :foreground ,terminal-256-red
                                        :weight bold))))

   `(cfw:face-periods
     ((,terminal-class (:foreground ,terminal-magenta))
      (,terminal-256-class  (:foreground ,terminal-256-magenta))))

   `(cfw:face-select
     ((,terminal-class (:background ,terminal-magenta-lc
                                   :foreground ,terminal-magenta-hc))
      (,terminal-256-class  (:background ,terminal-256-magenta-lc
                                        :foreground ,terminal-256-magenta-hc))))

   `(cfw:face-saturday
     ((,terminal-class (:foreground ,terminal-cyan-hc
                                   :background ,terminal-cyan-lc))
      (,terminal-256-class  (:foreground ,terminal-256-cyan-hc
                                        :background ,terminal-256-cyan-lc))))

   `(cfw:face-sunday
     ((,terminal-class (:foreground ,terminal-red-hc
                                   :background ,terminal-red-lc
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red-hc
                                        :background ,terminal-256-red-lc
                                        :weight bold))))

   `(cfw:face-title
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-yellow
                                :weight bold
                                :height ,terminal-height-plus-4))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-yellow
                                     :weight bold
                                     :height ,terminal-height-plus-4))))

   `(cfw:face-today
     ((,terminal-class (:weight bold
                               :background ,terminal-highlight-line
                               :foreground nil))
      (,terminal-256-class  (:weight bold
                                    :background ,terminal-256-highlight-line
                                    :foreground nil))))

   `(cfw:face-today-title
     ((,terminal-class (:background ,terminal-yellow-lc
                                   :foreground ,terminal-yellow-hc
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc
                                        :foreground ,terminal-256-yellow-hc
                                        :weight bold))))

   `(cfw:face-toolbar
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   `(cfw:face-toolbar-button-off
     ((,terminal-class (:background ,terminal-yellow-lc
                                   :foreground ,terminal-yellow-hc
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc
                                        :foreground ,terminal-256-yellow-hc
                                        :weight bold))))

   `(cfw:face-toolbar-button-on
     ((,terminal-class (:background ,terminal-yellow-hc
                                   :foreground ,terminal-yellow-lc
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-yellow-hc
                                        :foreground ,terminal-256-yellow-lc
                                        :weight bold))))

   ;; cider
   `(cider-enlightened
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background nil
                                   :box (:color ,terminal-yellow :line-width -1 :style nil)))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background nil
                                        :box (:color ,terminal-256-yellow :line-width -1 :style nil))) ))

   `(cider-enlightened-local
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(cider-instrumented-face
     ((,terminal-class (:foreground ,terminal-violet
                                   :background nil
                                   :box (:color ,terminal-violet :line-width -1 :style nil)))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :background nil
                                        :box (:color ,terminal-256-violet :line-width -1 :style nil)))))

   `(cider-result-overlay-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :background nil
                                   :box (:color ,terminal-blue :line-width -1 :style nil)))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background nil
                                        :box (:color ,terminal-256-blue :line-width -1 :style nil)))))

   `(cider-test-error-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-orange))))

   `(cider-test-failure-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-red))))

   `(cider-test-success-face
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-green))))

   `(cider-traced-face
     ((,terminal-class :box (:color ,terminal-blue :line-width -1 :style nil))
      (,terminal-256-class  :box (:color ,terminal-256-blue :line-width -1 :style nil))))

   ;; clojure-test
   `(clojure-test-failure-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold
                                        :underline t))))

   `(clojure-test-error-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold
                                        :underline t))))

   `(clojure-test-success-face
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold
                                        :underline t))))

   ;; company-mode
   `(company-tooltip
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis))))

   `(company-tooltip-selection
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(company-tooltip-mouse
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(company-tooltip-common
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline t))))

   `(company-tooltip-common-selection
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-blue
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-blue
                                        :underline t))))

   `(company-preview
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis))))

   `(company-preview-common
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline t))))

   `(company-scrollbar-bg
     ((,terminal-class (:background ,terminal-gray))
      (,terminal-256-class  (:background ,terminal-256-gray))))

   `(company-scrollbar-fg
     ((,terminal-class (:background ,terminal-comments))
      (,terminal-256-class  (:background ,terminal-256-comments))))

   `(company-tooltip-annotation
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-green))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-green))))

   `(company-template-field
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-blue))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-blue))))

   ;; compilation
   `(compilation-column-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :underline nil))))

   `(compilation-column-number
     ((,terminal-class (:inherit font-lock-doc-face
                                :foreground ,terminal-cyan
                                :underline nil))
      (,terminal-256-class  (:inherit font-lock-doc-face
                                     :foreground ,terminal-256-cyan
                                     :underline nil))))

   `(compilation-enter-directory-face
     ((,terminal-class (:foreground ,terminal-green
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :underline nil))))

   `(compilation-error
     ((,terminal-class (:inherit error
                                :underline nil))
      (,terminal-256-class  (:inherit error
                                     :underline nil))))

   `(compilation-error-face
     ((,terminal-class (:foreground ,terminal-red
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :underline nil))))

   `(compilation-face
     ((,terminal-class (:foreground ,terminal-foreground
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :underline nil))))

   `(compilation-info
     ((,terminal-class (:foreground ,terminal-comments
                                   :underline nil
                                   :bold nil))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :underline nil
                                        :bold nil))))

   `(compilation-info-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline nil))))

   `(compilation-leave-directory-face
     ((,terminal-class (:foreground ,terminal-green
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :underline nil))))

   `(compilation-line-face
     ((,terminal-class (:foreground ,terminal-green
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :underline nil))))

   `(compilation-line-number
     ((,terminal-class (:foreground ,terminal-green
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :underline nil))))

   `(compilation-warning
     ((,terminal-class (:inherit warning
                                :underline nil))
      (,terminal-256-class  (:inherit warning
                                     :underline nil))))

   `(compilation-warning-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal
                                        :underline nil))))

   `(compilation-mode-line-exit
     ((,terminal-class (:inherit compilation-info
                                :foreground ,terminal-green
                                :weight bold))
      (,terminal-256-class  (:inherit compilation-info
                                     :foreground ,terminal-256-green
                                     :weight bold))))

   `(compilation-mode-line-fail
     ((,terminal-class (:inherit compilation-error
                                :foreground ,terminal-red
                                :weight bold))
      (,terminal-256-class  (:inherit compilation-error
                                     :foreground ,terminal-256-red
                                     :weight bold))))

   `(compilation-mode-line-run
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold))))

   ;; CSCOPE
   `(cscope-file-face
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   `(cscope-function-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(cscope-line-number-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(cscope-line-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(cscope-mouse-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-foreground))))

   ;; ctable
   `(ctbl:face-cell-select
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :underline ,terminal-emphasis
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :underline ,terminal-256-emphasis
                                        :weight bold))))

   `(ctbl:face-continue-bar
     ((,terminal-class (:background ,terminal-gray
                                   :foreground ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-gray
                                        :foreground ,terminal-256-yellow))))

   `(ctbl:face-row-select
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground
                                   :underline t))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground
                                        :underline t))))

   ;; coffee
   `(coffee-mode-class-name
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(coffee-mode-function-param
     ((,terminal-class (:foreground ,terminal-violet
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :slant italic))))

   ;; custom
   `(custom-face-tag
     ((,terminal-class (:inherit ,terminal-pitch
                                :height ,terminal-height-plus-3
                                :foreground ,terminal-violet
                                :weight bold))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :height ,terminal-height-plus-3
                                     :foreground ,terminal-256-violet
                                     :weight bold))))

   `(custom-variable-tag
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-cyan
                                :height ,terminal-height-plus-3))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-cyan
                                     :height ,terminal-height-plus-3))))

   `(custom-comment-tag
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(custom-group-tag
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-blue
                                :height ,terminal-height-plus-3))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-blue
                                     :height ,terminal-height-plus-3))))

   `(custom-group-tag-1
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-red
                                :height ,terminal-height-plus-3))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-red
                                     :height ,terminal-height-plus-3))))

   `(custom-state
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   ;; diff
   `(diff-added
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background))))

   `(diff-changed
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background))))

   `(diff-removed
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background))))

   `(diff-header
     ((,terminal-class (:background ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-background))))

   `(diff-file-header
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground
                                        :weight bold))))

   `(diff-refine-added
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-green))))

   `(diff-refine-change
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-blue))))

   `(diff-refine-removed
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-red))))

   ;; diff-hl
   `(diff-hl-change
     ((,terminal-class (:background ,terminal-blue-lc
                                   :foreground ,terminal-blue-hc))
      (,terminal-256-class  (:background ,terminal-256-blue-lc
                                        :foreground ,terminal-256-blue-hc))))

   `(diff-hl-delete
     ((,terminal-class (:background ,terminal-red-lc
                                   :foreground ,terminal-red-hc))
      (,terminal-256-class  (:background ,terminal-256-red-lc
                                        :foreground ,terminal-256-red-hc))))

   `(diff-hl-insert
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-green-hc))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-green-hc))))

   `(diff-hl-unknown
     ((,terminal-class (:background ,terminal-violet-lc
                                   :foreground ,terminal-violet-hc))
      (,terminal-256-class  (:background ,terminal-256-violet-lc
                                        :foreground ,terminal-256-violet-hc))))

   ;; ediff
   `(ediff-fine-diff-A
     ((,terminal-class (:background ,terminal-orange-lc))
      (,terminal-256-class  (:background ,terminal-256-orange-lc))))

   `(ediff-fine-diff-B
     ((,terminal-class (:background ,terminal-green-lc))
      (,terminal-256-class  (:background ,terminal-256-green-lc))))

   `(ediff-fine-diff-C
     ((,terminal-class (:background ,terminal-yellow-lc))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc))))

   `(ediff-current-diff-C
     ((,terminal-class (:background ,terminal-blue-lc))
      (,terminal-256-class  (:background ,terminal-256-blue-lc))))

   `(ediff-even-diff-A
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-foreground-lc ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-foreground-lc ))))

   `(ediff-odd-diff-A
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-foreground-hc ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-foreground-hc ))))

   `(ediff-even-diff-B
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-foreground-hc ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-foreground-hc ))))

   `(ediff-odd-diff-B
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-foreground-lc ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-foreground-lc ))))

   `(ediff-even-diff-C
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-foreground ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-foreground ))))

   `(ediff-odd-diff-C
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-background ))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-background ))))

   ;; edts
   `(edts-face-error-line
     ((,(append '((supports :underline (:style line))) terminal-class)
       (:underline (:style line :color ,terminal-red)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-red-hc
                                   :background ,terminal-red-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style line))) terminal-256-class )
       (:underline (:style line :color ,terminal-256-red)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-red-hc
                                        :background ,terminal-256-red-lc
                                        :weight bold
                                        :underline t))))

   `(edts-face-warning-line
     ((,(append '((supports :underline (:style line))) terminal-class)
       (:underline (:style line :color ,terminal-yellow)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-yellow-hc
                                   :background ,terminal-yellow-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style line))) terminal-256-class )
       (:underline (:style line :color ,terminal-256-yellow)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-yellow-hc
                                        :background ,terminal-256-yellow-lc
                                        :weight bold
                                        :underline t))))

   `(edts-face-error-fringe-bitmap
     ((,terminal-class (:foreground ,terminal-red
                                   :background unspecified
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background unspecified
                                        :weight bold))))

   `(edts-face-warning-fringe-bitmap
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background unspecified
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background unspecified
                                        :weight bold))))

   `(edts-face-error-mode-line
     ((,terminal-class (:background ,terminal-red
                                   :foreground unspecified))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground unspecified))))

   `(edts-face-warning-mode-line
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground unspecified))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground unspecified))))


   ;; elfeed
   `(elfeed-search-date-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(elfeed-search-feed-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(elfeed-search-tag-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(elfeed-search-title-face
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   ;; ein
   `(ein:cell-input-area
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))
   `(ein:cell-input-prompt
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))
   `(ein:cell-output-prompt
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))
   `(ein:notification-tab-normal
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))
   `(ein:notification-tab-selected
     ((,terminal-class (:foreground ,terminal-orange :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange :inherit bold))))

   ;; enhanced ruby mode
   `(enh-ruby-string-delimiter-face
     ((,terminal-class (:inherit font-lock-string-face))
      (,terminal-256-class  (:inherit font-lock-string-face))))

   `(enh-ruby-heredoc-delimiter-face
     ((,terminal-class (:inherit font-lock-string-face))
      (,terminal-256-class  (:inherit font-lock-string-face))))

   `(enh-ruby-regexp-delimiter-face
     ((,terminal-class (:inherit font-lock-string-face))
      (,terminal-256-class  (:inherit font-lock-string-face))))

   `(enh-ruby-op-face
     ((,terminal-class (:inherit font-lock-keyword-face))
      (,terminal-256-class  (:inherit font-lock-keyword-face))))

   ;; erm-syn
   `(erm-syn-errline
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-red)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-red-hc
                                   :background ,terminal-red-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-red)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-red-hc
                                        :background ,terminal-256-red-lc
                                        :weight bold
                                        :underline t))))

   `(erm-syn-warnline
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-orange)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-orange-hc
                                   :background ,terminal-orange-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-orange)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-orange-hc
                                        :background ,terminal-256-orange-lc
                                        :weight bold
                                        :underline t))))

   ;; epc
   `(epc:face-title
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-background
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background
                                        :weight normal
                                        :underline nil))))

   ;; erc
   `(erc-action-face
     ((,terminal-class (:inherit erc-default-face))
      (,terminal-256-class  (:inherit erc-default-face))))

   `(erc-bold-face
     ((,terminal-class (:weight bold))
      (,terminal-256-class  (:weight bold))))

   `(erc-current-nick-face
     ((,terminal-class (:foreground ,terminal-blue :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight bold))))

   `(erc-dangerous-host-face
     ((,terminal-class (:inherit font-lock-warning-face))
      (,terminal-256-class  (:inherit font-lock-warning-face))))

   `(erc-default-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(erc-highlight-face
     ((,terminal-class (:inherit erc-default-face
                                :background ,terminal-highlight))
      (,terminal-256-class  (:inherit erc-default-face
                                     :background ,terminal-256-highlight))))

   `(erc-direct-msg-face
     ((,terminal-class (:inherit erc-default-face))
      (,terminal-256-class  (:inherit erc-default-face))))

   `(erc-error-face
     ((,terminal-class (:inherit font-lock-warning-face))
      (,terminal-256-class  (:inherit font-lock-warning-face))))

   `(erc-fool-face
     ((,terminal-class (:inherit erc-default-face))
      (,terminal-256-class  (:inherit erc-default-face))))

   `(erc-input-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(erc-keyword-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight bold))))

   `(erc-nick-default-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(erc-my-nick-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold))))

   `(erc-nick-msg-face
     ((,terminal-class (:inherit erc-default-face))
      (,terminal-256-class  (:inherit erc-default-face))))

   `(erc-notice-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(erc-pal-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold))))

   `(erc-prompt-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :background ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :background ,terminal-256-background
                                        :weight bold))))

   `(erc-timestamp-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(erc-underline-face
     ((t (:underline t))))

   ;; eshell
   `(eshell-prompt
     ((,terminal-class (:foreground ,terminal-blue
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :inherit bold))))

   `(eshell-ls-archive
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :inherit bold))))

   `(eshell-ls-backup
     ((,terminal-class (:inherit font-lock-comment-face))
      (,terminal-256-class  (:inherit font-lock-comment-face))))

   `(eshell-ls-clutter
     ((,terminal-class (:inherit font-lock-comment-face))
      (,terminal-256-class  (:inherit font-lock-comment-face))))

   `(eshell-ls-directory
     ((,terminal-class (:foreground ,terminal-blue
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :inherit bold))))

   `(eshell-ls-executable
     ((,terminal-class (:foreground ,terminal-green
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :inherit bold))))

   `(eshell-ls-unreadable
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(eshell-ls-missing
     ((,terminal-class (:inherit font-lock-warning-face))
      (,terminal-256-class  (:inherit font-lock-warning-face))))

   `(eshell-ls-product
     ((,terminal-class (:inherit font-lock-doc-face))
      (,terminal-256-class  (:inherit font-lock-doc-face))))

   `(eshell-ls-special
     ((,terminal-class (:foreground ,terminal-yellow
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :inherit bold))))

   `(eshell-ls-symlink
     ((,terminal-class (:foreground ,terminal-cyan
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :inherit bold))))

   ;; evil-ex-substitute
   `(evil-ex-substitute-matches
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-red-l
                                   :inherit italic))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-red-l
                                        :inherit italic))))
   `(evil-ex-substitute-replacement
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-green-l
                                   :inherit italic))
      (,terminal-256-class  (:background ,terminal-256-highlight-line :foreground ,terminal-256-green-l :inherit italic))))

   ;; evil-search-highlight-persist
   `(evil-search-highlight-persist-highlight-face
     ((,terminal-class (:inherit region))
      (,terminal-256-class  (:inherit region))))

   ;; fic
   `(fic-author-face
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-orange
                                   :underline t
                                   :slant italic))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-orange
                                        :underline t
                                        :slant italic))))

   `(fic-face
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-orange
                                   :weight normal
                                   :slant italic))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-orange
                                        :weight normal
                                        :slant italic))))

   `(font-lock-fic-face
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-orange
                                   :weight normal
                                   :slant italic))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-orange
                                        :weight normal
                                        :slant italic))))

   ;; flx
   `(flx-highlight-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight normal
                                        :underline nil))))

   ;; flymake
   `(flymake-errline
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-red)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-class (:foreground ,terminal-red-hc
                                   :background ,terminal-red-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-red)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-red-hc
                                        :background ,terminal-256-red-lc
                                        :weight bold
                                        :underline t))))

   `(flymake-infoline
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-green)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-class (:foreground ,terminal-green-hc
                                   :background ,terminal-green-lc))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-green)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-green-hc
                                        :background ,terminal-256-green-lc))))

   `(flymake-warnline
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-yellow)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-class (:foreground ,terminal-yellow-hc
                                   :background ,terminal-yellow-lc
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-yellow)
                   :inherit unspecified
                   :foreground unspecified
                   :background unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-yellow-hc
                                        :background ,terminal-256-yellow-lc
                                        :weight bold
                                        :underline t))))

   ;; flycheck
   `(flycheck-error
     ((,(append '((supports :underline (:style line))) terminal-class)
       (:underline (:style line :color ,terminal-red)))
      (,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style line))) terminal-256-class )
       (:underline (:style line :color ,terminal-256-red)))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :weight bold
                                        :underline t))))

   `(flycheck-warning
     ((,(append '((supports :underline (:style line))) terminal-class)
       (:underline (:style line :color ,terminal-orange)))
      (,terminal-class (:foreground ,terminal-orange
                                   :background ,terminal-background
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style line))) terminal-256-class )
       (:underline (:style line :color ,terminal-256-orange)))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :background ,terminal-256-background
                                        :weight bold
                                        :underline t))))

   `(flycheck-info
     ((,(append '((supports :underline (:style line))) terminal-class)
       (:underline (:style line :color ,terminal-blue)))
      (,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-background
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style line))) terminal-256-class )
       (:underline (:style line :color ,terminal-256-blue)))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background
                                        :weight bold
                                        :underline t))))

   `(flycheck-fringe-error
     ((,terminal-class (:foreground ,terminal-red-l
                                   :background unspecified
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red-l
                                        :background unspecified
                                        :weight bold))))

   `(flycheck-fringe-warning
     ((,terminal-class (:foreground ,terminal-orange-l
                                   :background unspecified
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange-l
                                        :background unspecified
                                        :weight bold))))

   `(flycheck-fringe-info
     ((,terminal-class (:foreground ,terminal-blue-l
                                   :background unspecified
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue-l
                                        :background unspecified
                                        :weight bold))))

   ;; flyspell
   `(flyspell-duplicate
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-yellow)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-yellow
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-yellow)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold
                                        :underline t))))

   `(flyspell-incorrect
     ((,(append '((supports :underline (:style wave))) terminal-class)
       (:underline (:style wave :color ,terminal-red)
                   :inherit unspecified))
      (,terminal-class (:foreground ,terminal-red
                                   :weight bold
                                   :underline t))
      (,(append '((supports :underline (:style wave))) terminal-256-class )
       (:underline (:style wave :color ,terminal-256-red)
                   :inherit unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold
                                        :underline t))))


   ;; git-gutter
   `(git-gutter:added
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter:deleted
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter:modified
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter:unchanged
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   ;; git-gutter-fr
   `(git-gutter-fr:added
     ((,terminal-class (:foreground ,terminal-green
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :inherit bold))))

   `(git-gutter-fr:deleted
     ((,terminal-class (:foreground ,terminal-red
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :inherit bold))))

   `(git-gutter-fr:modified
     ((,terminal-class (:foreground ,terminal-blue
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :inherit bold))))

   ;; git-gutter+ and git-gutter+-fr
   `(git-gutter+-added
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter+-deleted
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter+-modified
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter+-unchanged
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-background
                                   :inherit bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-background
                                        :inherit bold))))

   `(git-gutter-fr+-added
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   `(git-gutter-fr+-deleted
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold))))

   `(git-gutter-fr+-modified
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight bold))))

   ;; git-timemachine
   `(git-timemachine-minibuffer-detail-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-highlight-line
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-blue
                                        :background ,terminal-256-highlight-line
                                        :inherit bold))))

   ;; guide-key
   `(guide-key/highlight-command-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(guide-key/key-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(guide-key/prefix-command-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   ;; gnus
   `(gnus-group-mail-1
     ((,terminal-class (:weight bold
                               :inherit gnus-group-mail-1-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-mail-1-empty))))

   `(gnus-group-mail-1-empty
     ((,terminal-class (:inherit gnus-group-news-1-empty))
      (,terminal-256-class  (:inherit gnus-group-news-1-empty))))

   `(gnus-group-mail-2
     ((,terminal-class (:weight bold
                               :inherit gnus-group-mail-2-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-mail-2-empty))))

   `(gnus-group-mail-2-empty
     ((,terminal-class (:inherit gnus-group-news-2-empty))
      (,terminal-256-class  (:inherit gnus-group-news-2-empty))))

   `(gnus-group-mail-3
     ((,terminal-class (:weight bold
                               :inherit gnus-group-mail-3-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-mail-3-empty))))

   `(gnus-group-mail-3-empty
     ((,terminal-class (:inherit gnus-group-news-3-empty))
      (,terminal-256-class  (:inherit gnus-group-news-3-empty))))

   `(gnus-group-mail-low
     ((,terminal-class (:weight bold
                               :inherit gnus-group-mail-low-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-mail-low-empty))))

   `(gnus-group-mail-low-empty
     ((,terminal-class (:inherit gnus-group-news-low-empty))
      (,terminal-256-class  (:inherit gnus-group-news-low-empty))))

   `(gnus-group-news-1
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-1-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-1-empty))))

   `(gnus-group-news-2
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-2-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-2-empty))))

   `(gnus-group-news-3
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-3-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-3-empty))))

   `(gnus-group-news-4
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-4-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-4-empty))))

   `(gnus-group-news-5
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-5-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-5-empty))))

   `(gnus-group-news-6
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-6-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-6-empty))))

   `(gnus-group-news-low
     ((,terminal-class (:weight bold
                               :inherit gnus-group-news-low-empty))
      (,terminal-256-class  (:weight bold
                                    :inherit gnus-group-news-low-empty))))

   `(gnus-header-content
     ((,terminal-class (:inherit message-header-other))
      (,terminal-256-class  (:inherit message-header-other))))

   `(gnus-header-from
     ((,terminal-class (:inherit message-header-other))
      (,terminal-256-class  (:inherit message-header-other))))

   `(gnus-header-name
     ((,terminal-class (:inherit message-header-name))
      (,terminal-256-class  (:inherit message-header-name))))

   `(gnus-header-newsgroups
     ((,terminal-class (:inherit message-header-other))
      (,terminal-256-class  (:inherit message-header-other))))

   `(gnus-header-subject
     ((,terminal-class (:inherit message-header-subject))
      (,terminal-256-class  (:inherit message-header-subject))))

   `(gnus-summary-cancelled
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(gnus-summary-high-ancient
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight bold))))

   `(gnus-summary-high-read
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   `(gnus-summary-high-ticked
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold))))

   `(gnus-summary-high-unread
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight bold))))

   `(gnus-summary-low-ancient
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-summary-low-read
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-summary-low-ticked
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(gnus-summary-low-unread
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(gnus-summary-normal-ancient
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-summary-normal-read
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-summary-normal-ticked
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(gnus-summary-normal-unread
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(gnus-summary-selected
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(gnus-cite-1
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-cite-2
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-cite-3
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-cite-4
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-cite-5
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-cite-6
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-cite-7
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(gnus-cite-8
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(gnus-cite-9
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(gnus-cite-10
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(gnus-cite-11
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(gnus-group-news-1-empty
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(gnus-group-news-2-empty
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-group-news-3-empty
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(gnus-group-news-4-empty
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-group-news-5-empty
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(gnus-group-news-6-empty
     ((,terminal-class (:foreground ,terminal-blue-lc))
      (,terminal-256-class  (:foreground ,terminal-256-blue-lc))))

   `(gnus-group-news-low-empty
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(gnus-signature
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(gnus-x-face
     ((,terminal-class (:background ,terminal-foreground
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-foreground
                                        :foreground ,terminal-256-background))))


   ;; helm
   `(helm-apt-deinstalled
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(helm-apt-installed
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-bookmark-directory
     ((,terminal-class (:inherit helm-ff-directory))
      (,terminal-256-class  (:inherit helm-ff-directory))))

   `(helm-bookmark-file
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(helm-bookmark-gnus
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(helm-bookmark-info
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-bookmark-man
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(helm-bookmark-w3m
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(helm-bookmarks-su
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(helm-buffer-file
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(helm-buffer-directory
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(helm-buffer-process
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(helm-buffer-saved-out
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :inverse-video t))))

   `(helm-buffer-size
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(helm-candidate-number
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :bold t))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :bold t))))

   `(helm-ff-directory
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(helm-ff-executable
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-ff-file
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground))))

   `(helm-ff-invalid-symlink
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-orange
                                   :slant italic))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-orange
                                        :slant italic))))

   `(helm-ff-prefix
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background))))

   `(helm-ff-symlink
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(helm-grep-file
     ((,terminal-class (:foreground ,terminal-cyan
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :underline t))))

   `(helm-grep-finish
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-grep-lineno
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(helm-grep-match
     ((,terminal-class (:inherit helm-match)))
     ((,terminal-256-class  (:inherit helm-match))))

   `(helm-grep-running
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(helm-header
     ((,terminal-class (:inherit header-line))
      (,terminal-256-class  (:inherit terminal-header-line))))

   `(helm-lisp-completion-info
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(helm-lisp-show-completion
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background ,terminal-highlight-line
                                   :bold t))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background ,terminal-256-highlight-line
                                        :bold t))))

   `(helm-M-x-key
     ((,terminal-class (:foreground ,terminal-orange
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :underline t))))

   `(helm-moccur-buffer
     ((,terminal-class (:foreground ,terminal-cyan
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :underline t))))

   `(helm-match
     ((,terminal-class (:foreground ,terminal-green :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-green :inherit bold))))

   `(helm-match-item
     ((,terminal-class (:inherit helm-match))
      (,terminal-256-class  (:inherit helm-match))))

   `(helm-selection
     ((,terminal-class (:background ,terminal-highlight
                                   :inherit bold
                                   :underline nil))
      (,terminal-256-class  (:background ,terminal-256-highlight
                                        :inherit bold
                                        :underline nil))))

   `(helm-selection-line
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :underline nil))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :underline nil))))

   `(helm-separator
     ((,terminal-class (:foreground ,terminal-gray))
      (,terminal-256-class  (:foreground ,terminal-256-gray))))

   `(helm-source-header
     ((,terminal-class (:background ,terminal-violet-l
                                   :foreground ,terminal-background
                                   :underline nil))
      (,terminal-256-class  (:background ,terminal-256-violet-l
                                        :foreground ,terminal-256-background
                                        :underline nil))))

   `(helm-swoop-target-line-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(helm-swoop-target-line-block-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(helm-swoop-target-word-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-time-zone-current
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(helm-time-zone-home
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(helm-visible-mark
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-magenta :bold t))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-magenta :bold t))))

   ;; helm-ls-git
   `(helm-ls-git-modified-not-staged-face
     ((,terminal-class :foreground ,terminal-blue)
      (,terminal-256-class  :foreground ,terminal-256-blue)))

   `(helm-ls-git-modified-and-staged-face
     ((,terminal-class :foreground ,terminal-blue-l)
      (,terminal-256-class  :foreground ,terminal-256-blue-l)))

   `(helm-ls-git-renamed-modified-face
     ((,terminal-class :foreground ,terminal-blue-l)
      (,terminal-256-class  :foreground ,terminal-256-blue-l)))

   `(helm-ls-git-untracked-face
     ((,terminal-class :foreground ,terminal-orange)
      (,terminal-256-class  :foreground ,terminal-256-orange)))

   `(helm-ls-git-added-copied-face
     ((,terminal-class :foreground ,terminal-green)
      (,terminal-256-class  :foreground ,terminal-256-green)))

   `(helm-ls-git-added-modified-face
     ((,terminal-class :foreground ,terminal-green-l)
      (,terminal-256-class  :foreground ,terminal-256-green-l)))

   `(helm-ls-git-deleted-not-staged-face
     ((,terminal-class :foreground ,terminal-red)
      (,terminal-256-class  :foreground ,terminal-256-red)))

   `(helm-ls-git-deleted-and-staged-face
     ((,terminal-class :foreground ,terminal-red-l)
      (,terminal-256-class  :foreground ,terminal-256-red-l)))

   `(helm-ls-git-conflict-face
     ((,terminal-class :foreground ,terminal-yellow)
      (,terminal-256-class  :foreground ,terminal-256-yellow)))

   ;; hi-lock-mode
   `(hi-yellow
     ((,terminal-class (:foreground ,terminal-yellow-lc
                                   :background ,terminal-yellow-hc))
      (,terminal-256-class  (:foreground ,terminal-256-yellow-lc
                                        :background ,terminal-256-yellow-hc))))

   `(hi-pink
     ((,terminal-class (:foreground ,terminal-magenta-lc
                                   :background ,terminal-magenta-hc))
      (,terminal-256-class  (:foreground ,terminal-256-magenta-lc
                                        :background ,terminal-256-magenta-hc))))

   `(hi-green
     ((,terminal-class (:foreground ,terminal-green-lc
                                   :background ,terminal-green-hc))
      (,terminal-256-class  (:foreground ,terminal-256-green-lc
                                        :background ,terminal-256-green-hc))))

   `(hi-blue
     ((,terminal-class (:foreground ,terminal-blue-lc
                                   :background ,terminal-blue-hc))
      (,terminal-256-class  (:foreground ,terminal-256-blue-lc
                                        :background ,terminal-256-blue-hc))))

   `(hi-Black-b
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background
                                        :weight bold))))

   `(hi-blue-b
     ((,terminal-class (:foreground ,terminal-blue-lc
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue-lc
                                        :weight bold))))

   `(hi-green-b
     ((,terminal-class (:foreground ,terminal-green-lc
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green-lc
                                        :weight bold))))

   `(hi-red-b
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))))

   `(hi-Black-hb
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background
                                        :weight bold))))

   ;; highlight-changes
   `(highlight-changes
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(highlight-changes-delete
     ((,terminal-class (:foreground ,terminal-red
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :underline t))))

   ;; highlight-indentation
   `(highlight-indentation-face
     ((,terminal-class (:background ,terminal-gray))
      (,terminal-256-class  (:background ,terminal-256-gray))))

   `(highlight-indentation-current-column-face
     ((,terminal-class (:background ,terminal-gray))
      (,terminal-256-class  (:background ,terminal-256-gray))))

   ;; hl-line-mode
   `(hl-line
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(hl-line-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   ;; ido-mode
   `(ido-first-match
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal))))

   `(ido-only-match
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-yellow
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-yellow
                                        :weight normal))))

   `(ido-subdir
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(ido-incomplete-regexp
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold ))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold ))))

   `(ido-indicator
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-background
                                   :width condensed))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-background
                                        :width condensed))))

   `(ido-virtual
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   ;; info
   `(info-header-xref
     ((,terminal-class (:foreground ,terminal-green
                                   :inherit bold
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :inherit bold
                                        :underline t))))

   `(info-menu
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(info-node
     ((,terminal-class (:foreground ,terminal-violet
                                   :inherit bold))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :inherit bold))))

   `(info-quoted-name
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(info-reference-item
     ((,terminal-class (:background nil
                                   :underline t
                                   :inherit bold))
      (,terminal-256-class  (:background nil
                                        :underline t
                                        :inherit bold))))

   `(info-string
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(info-title-1
     ((,terminal-class (:height ,terminal-height-plus-4))
      (,terminal-256-class  (:height ,terminal-height-plus-4))))

   `(info-title-2
     ((,terminal-class (:height ,terminal-height-plus-3))
      (,terminal-256-class  (:height ,terminal-height-plus-3))))

   `(info-title-3
     ((,terminal-class (:height ,terminal-height-plus-2))
      (,terminal-256-class  (:height ,terminal-height-plus-2))))

   `(info-title-4
     ((,terminal-class (:height ,terminal-height-plus-1))
      (,terminal-256-class  (:height ,terminal-height-plus-1))))

   ;; ivy
   `(ivy-current-match
     ((,terminal-class (:background ,terminal-gray :inherit bold))
      (,terminal-256-class  (:background ,terminal-gray-l :inherit bold))))

   `(ivy-minibuffer-match-face-1
     ((,terminal-class (:inherit bold))
      (,terminal-256-class  (:inherit bold))))

   `(ivy-minibuffer-match-face-2
     ((,terminal-class (:foreground ,terminal-violet
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :underline t))))

   `(ivy-minibuffer-match-face-3
     ((,terminal-class (:foreground ,terminal-green
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :underline t))))

   `(ivy-minibuffer-match-face-4
     ((,terminal-class (:foreground ,terminal-yellow
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :underline t))))

   `(ivy-remote
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(swiper-line-face
     ((,terminal-class (:background ,terminal-highlight-line))))

   `(swiper-match-face-1
     ((,terminal-class (:background ,terminal-gray-d))))

   `(swiper-match-face-2
     ((,terminal-class (:background ,terminal-green))))

   `(swiper-match-face-3
     ((,terminal-class (:background ,terminal-orange))))

   `(swiper-match-face-4
     ((,terminal-class (:background ,terminal-magenta))))

   ;; jabber
   `(jabber-activity-face
     ((,terminal-class (:weight bold
                               :foreground ,terminal-red))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-red))))

   `(jabber-activity-personal-face
     ((,terminal-class (:weight bold
                               :foreground ,terminal-blue))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-blue))))

   `(jabber-chat-error
     ((,terminal-class (:weight bold
                               :foreground ,terminal-red))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-red))))

   `(jabber-chat-prompt-foreign
     ((,terminal-class (:weight bold
                               :foreground ,terminal-red))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-red))))

   `(jabber-chat-prompt-local
     ((,terminal-class (:weight bold
                               :foreground ,terminal-blue))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-blue))))

   `(jabber-chat-prompt-system
     ((,terminal-class (:weight bold
                               :foreground ,terminal-green))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-green))))

   `(jabber-chat-text-foreign
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(jabber-chat-text-local
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(jabber-chat-rare-time-face
     ((,terminal-class (:underline t
                                  :foreground ,terminal-green))
      (,terminal-256-class  (:underline t
                                       :foreground ,terminal-256-green))))

   `(jabber-roster-user-away
     ((,terminal-class (:slant italic
                              :foreground ,terminal-green))
      (,terminal-256-class  (:slant italic
                                   :foreground ,terminal-256-green))))

   `(jabber-roster-user-chatty
     ((,terminal-class (:weight bold
                               :foreground ,terminal-orange))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-orange))))

   `(jabber-roster-user-dnd
     ((,terminal-class (:slant italic
                              :foreground ,terminal-red))
      (,terminal-256-class  (:slant italic
                                   :foreground ,terminal-256-red))))

   `(jabber-roster-user-error
     ((,terminal-class (:weight light
                               :slant italic
                               :foreground ,terminal-red))
      (,terminal-256-class  (:weight light
                                    :slant italic
                                    :foreground ,terminal-256-red))))

   `(jabber-roster-user-offline
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(jabber-roster-user-online
     ((,terminal-class (:weight bold
                               :foreground ,terminal-blue))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-blue))))

   `(jabber-roster-user-xa
     ((,terminal-class (:slant italic
                              :foreground ,terminal-magenta))
      (,terminal-256-class  (:slant italic
                                   :foreground ,terminal-256-magenta))))

   ;; js2-mode colors
   `(js2-error
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(js2-external-variable
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(js2-function-call
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(js2-function-param
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(js2-instance-member
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(js2-jsdoc-html-tag-delimiter
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(js2-jsdoc-html-tag-name
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(js2-jsdoc-tag
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(js2-jsdoc-type
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(js2-jsdoc-value
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(js2-magic-paren
     ((,terminal-class (:underline t))
      (,terminal-256-class  (:underline t))))

   `(js2-object-property
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(js2-private-function-call
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(js2-private-member
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(js2-warning
     ((,terminal-class (:underline ,terminal-orange))
      (,terminal-256-class  (:underline ,terminal-256-orange))))

   ;; jedi
   `(jedi:highlight-function-argument
     ((,terminal-class (:inherit bold))
      (,terminal-256-class  (:inherit bold))))

   ;; linum-mode
   `(linum
     ((,terminal-class (:foreground ,terminal-line-number
                                   :background ,terminal-fringe-bg
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-line-number
                                        :background ,terminal-256-fringe-bg
                                        :underline nil))))

   ;; linum-relative-current-face
   `(linum-relative-current-face
     ((,terminal-class (:foreground ,terminal-line-number
                                   :background ,terminal-highlight-line
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-line-number
                                        :background ,terminal-256-highlight-line
                                        :underline nil))))

   ;; lusty-explorer
   `(lusty-directory-face
     ((,terminal-class (:inherit diterminal-red-directory))
      (,terminal-256-class  (:inherit diterminal-red-directory))))

   `(lusty-file-face
     ((,terminal-class nil)
      (,terminal-256-class  nil)))

   `(lusty-match-face
     ((,terminal-class (:inherit ido-first-match))
      (,terminal-256-class  (:inherit ido-first-match))))

   `(lusty-slash-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :weight bold))))

   ;; magit
   ;;
   ;; TODO: Add supports for all magit faces
   ;; https://github.com/magit/magit/search?utf8=%E2%9C%93&q=face
   ;;



   `(magit-diff-file-heading-highlight
     ((,terminal-class (:foreground ,"Yellow"
                                    :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                         :background ,terminal-256-background))))

   `(magit-section-highlight
     ((,terminal-class (:foreground ,"White"
                                    :background ,"Black"))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                         :background ,"Black"))))
















   `(magit-diff-added
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background))))

   `(magit-diff-added-highlight
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-highlight-line))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-highlight-line))))

   `(magit-diff-removed
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background))))

   `(magit-diff-removed-highlight
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-highlight-line))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-highlight-line))))

   `(magit-section-title
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(magit-branch
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight bold))))

   `(magit-item-highlight
     ((,terminal-class (:background ,terminal-highlight-line
                                   :weight unspecified))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :weight unspecified))))

   `(magit-log-author
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(magit-log-graph
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(magit-log-head-label-bisect-bad
     ((,terminal-class (:background ,terminal-red-hc
                                   :foreground ,terminal-red-lc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-red-hc
                                        :foreground ,terminal-256-red-lc
                                        :box 1))))

   `(magit-log-head-label-bisect-good
     ((,terminal-class (:background ,terminal-green-hc
                                   :foreground ,terminal-green-lc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-green-hc
                                        :foreground ,terminal-256-green-lc
                                        :box 1))))

   `(magit-log-head-label-default
     ((,terminal-class (:background ,terminal-highlight-line
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :box 1))))

   `(magit-log-head-label-local
     ((,terminal-class (:background ,terminal-blue-lc
                                   :foreground ,terminal-blue-hc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-blue-lc
                                        :foreground ,terminal-256-blue-hc
                                        :box 1))))

   `(magit-log-head-label-patches
     ((,terminal-class (:background ,terminal-red-lc
                                   :foreground ,terminal-red-hc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-red-lc
                                        :foreground ,terminal-256-red-hc
                                        :box 1))))

   `(magit-log-head-label-remote
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-green-hc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-green-hc
                                        :box 1))))

   `(magit-log-head-label-tags
     ((,terminal-class (:background ,terminal-yellow-lc
                                   :foreground ,terminal-yellow-hc
                                   :box 1))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc
                                        :foreground ,terminal-256-yellow-hc
                                        :box 1))))

   `(magit-log-sha1
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   ;; man
   `(Man-overstrike
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight bold))))

   `(Man-reverse
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(Man-underline
     ((,terminal-class (:foreground ,terminal-green :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-green :underline t))))

   ;; monky
   `(monky-section-title
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(monky-diff-add
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(monky-diff-del
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; markdown-mode
   `(markdown-header-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(markdown-header-face-1
     ((,terminal-class (:inherit markdown-header-face
                                :height ,terminal-height-plus-4))
      (,terminal-256-class  (:inherit markdown-header-face
                                     :height ,terminal-height-plus-4))))

   `(markdown-header-face-2
     ((,terminal-class (:inherit markdown-header-face
                                :height ,terminal-height-plus-3))
      (,terminal-256-class  (:inherit markdown-header-face
                                     :height ,terminal-height-plus-3))))

   `(markdown-header-face-3
     ((,terminal-class (:inherit markdown-header-face
                                :height ,terminal-height-plus-2))
      (,terminal-256-class  (:inherit markdown-header-face
                                     :height ,terminal-height-plus-2))))

   `(markdown-header-face-4
     ((,terminal-class (:inherit markdown-header-face
                                :height ,terminal-height-plus-1))
      (,terminal-256-class  (:inherit markdown-header-face
                                     :height ,terminal-height-plus-1))))

   `(markdown-header-face-5
     ((,terminal-class (:inherit markdown-header-face))
      (,terminal-256-class  (:inherit markdown-header-face))))

   `(markdown-header-face-6
     ((,terminal-class (:inherit markdown-header-face))
      (,terminal-256-class  (:inherit markdown-header-face))))

   ;; message-mode
   `(message-cited-text
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(message-header-name
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(message-header-other
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight normal))))

   `(message-header-to
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight normal))))

   `(message-header-cc
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight normal))))

   `(message-header-newsgroups
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(message-header-subject
     ((,terminal-class (:foreground ,terminal-cyan
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :weight normal))))

   `(message-header-xheader
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(message-mml
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(message-separator
     ((,terminal-class (:foreground ,terminal-comments
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :slant italic))))

   ;; mew
   `(mew-face-header-subject
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(mew-face-header-from
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(mew-face-header-date
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-header-to
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-header-key
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-header-private
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-header-important
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(mew-face-header-marginal
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight bold))))

   `(mew-face-header-warning
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-header-xmew
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-header-xmew-bad
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-body-url
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(mew-face-body-comment
     ((,terminal-class (:foreground ,terminal-foreground
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :slant italic))))

   `(mew-face-body-cite1
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-body-cite2
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(mew-face-body-cite3
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(mew-face-body-cite4
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(mew-face-body-cite5
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-mark-review
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(mew-face-mark-escape
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-mark-delete
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-mark-unlink
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(mew-face-mark-refile
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-mark-unread
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(mew-face-eof-message
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(mew-face-eof-part
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   ;; mingus
   `(mingus-directory-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(mingus-pausing-face
     ((,terminal-class (:foreground ,terminal-magenta))
      (,terminal-256-class  (:foreground ,terminal-256-magenta))))

   `(mingus-playing-face
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(mingus-playlist-face
     ((,terminal-class (:foreground ,terminal-cyan ))
      (,terminal-256-class  (:foreground ,terminal-256-cyan ))))

   `(mingus-song-file-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(mingus-stopped-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; mmm
   `(mmm-init-submode-face
     ((,terminal-class (:background ,terminal-violet-d))
      (,terminal-256-class  (:background ,terminal-256-violet-d))))

   `(mmm-cleanup-submode-face
     ((,terminal-class (:background ,terminal-orange-d))
      (,terminal-256-class  (:background ,terminal-256-orange-d))))

   `(mmm-declaration-submode-face
     ((,terminal-class (:background ,terminal-cyan-d))
      (,terminal-256-class  (:background ,terminal-256-cyan-d))))

   `(mmm-comment-submode-face
     ((,terminal-class (:background ,terminal-blue-d))
      (,terminal-256-class  (:background ,terminal-256-blue-d))))

   `(mmm-output-submode-face
     ((,terminal-class (:background ,terminal-red-d))
      (,terminal-256-class  (:background ,terminal-256-red-d))))

   `(mmm-special-submode-face
     ((,terminal-class (:background ,terminal-green-d))
      (,terminal-256-class  (:background ,terminal-256-green-d))))

   `(mmm-code-submode-face
     ((,terminal-class (:background ,terminal-gray))
      (,terminal-256-class  (:background ,terminal-256-gray))))

   `(mmm-default-submode-face
     ((,terminal-class (:background ,terminal-gray-d))
      (,terminal-256-class  (:background ,terminal-256-gray-d))))

   ;; moccur
   `(moccur-current-line-face
     ((,terminal-class (:underline t))
      (,terminal-256-class  (:underline t))))

   `(moccur-edit-done-face
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-background
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-background
                                        :slant italic))))

   `(moccur-edit-face
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-background))))

   `(moccur-edit-file-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(moccur-edit-reject-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(moccur-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :weight bold))))

   `(search-buffers-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :weight bold))))

   `(search-buffers-header-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-yellow
                                        :weight bold))))

   ;; mu4e
   `(mu4e-cited-1-face
     ((,terminal-class (:foreground ,terminal-green
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-2-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-3-face
     ((,terminal-class (:foreground ,terminal-orange
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-4-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-5-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-6-face
     ((,terminal-class (:foreground ,terminal-green
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :slant italic
                                        :weight normal))))

   `(mu4e-cited-7-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :slant italic
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :slant italic
                                        :weight normal))))

   `(mu4e-flagged-face
     ((,terminal-class (:foreground ,terminal-magenta
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :weight bold))))

   `(mu4e-view-url-number-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal))))

   `(mu4e-warning-face
     ((,terminal-class (:foreground ,terminal-red
                                   :slant normal
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :slant normal
                                        :weight bold))))

   `(mu4e-header-highlight-face
     ((,terminal-class (:inherit unspecified
                                :foreground unspecified
                                :background ,terminal-highlight-line
                                :underline ,terminal-emphasis
                                :weight normal))
      (,terminal-256-class  (:inherit unspecified
                                     :foreground unspecified
                                     :background ,terminal-256-highlight-line
                                     :underline ,terminal-256-emphasis
                                     :weight normal))))


   `(mu4e-draft-face
     ((,terminal-class (:inherit font-lock-string-face))
      (,terminal-256-class  (:inherit font-lock-string-face))))

   `(mu4e-footer-face
     ((,terminal-class (:inherit font-lock-comment-face))
      (,terminal-256-class  (:inherit font-lock-comment-face))))

   `(mu4e-forwarded-face
     ((,terminal-class (:inherit font-lock-builtin-face
                                :weight normal))
      (,terminal-256-class  (:inherit font-lock-builtin-face
                                     :weight normal))))

   `(mu4e-header-face
     ((,terminal-class (:inherit default))
      (,terminal-256-class  (:inherit default))))

   `(mu4e-header-marks-face
     ((,terminal-class (:inherit font-lock-preprocessor-face))
      (,terminal-256-class  (:inherit font-lock-preprocessor-face))))

   `(mu4e-header-title-face
     ((,terminal-class (:inherit font-lock-type-face))
      (,terminal-256-class  (:inherit font-lock-type-face))))

   `(mu4e-highlight-face
     ((,terminal-class (:inherit font-lock-pseudo-keyword-face
                                :weight bold))
      (,terminal-256-class  (:inherit font-lock-pseudo-keyword-face
                                     :weight bold))))

   `(mu4e-moved-face
     ((,terminal-class (:inherit font-lock-comment-face
                                :slant italic))
      (,terminal-256-class  (:inherit font-lock-comment-face
                                     :slant italic))))

   `(mu4e-ok-face
     ((,terminal-class (:inherit font-lock-comment-face
                                :slant normal
                                :weight bold))
      (,terminal-256-class  (:inherit font-lock-comment-face
                                     :slant normal
                                     :weight bold))))

   `(mu4e-replied-face
     ((,terminal-class (:inherit font-lock-builtin-face
                                :weight normal))
      (,terminal-256-class  (:inherit font-lock-builtin-face
                                     :weight normal))))

   `(mu4e-system-face
     ((,terminal-class (:inherit font-lock-comment-face
                                :slant italic))
      (,terminal-256-class  (:inherit font-lock-comment-face
                                     :slant italic))))

   `(mu4e-title-face
     ((,terminal-class (:inherit font-lock-type-face
                                :weight bold))
      (,terminal-256-class  (:inherit font-lock-type-face
                                     :weight bold))))

   `(mu4e-trashed-face
     ((,terminal-class (:inherit font-lock-comment-face
                                :strike-through t))
      (,terminal-256-class  (:inherit font-lock-comment-face
                                     :strike-through t))))

   `(mu4e-unread-face
     ((,terminal-class (:inherit font-lock-keyword-face
                                :weight bold))
      (,terminal-256-class  (:inherit font-lock-keyword-face
                                     :weight bold))))

   `(mu4e-view-attach-number-face
     ((,terminal-class (:inherit font-lock-variable-name-face
                                :weight bold))
      (,terminal-256-class  (:inherit font-lock-variable-name-face
                                     :weight bold))))

   `(mu4e-view-contact-face
     ((,terminal-class (:foreground ,terminal-foreground
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :weight normal))))

   `(mu4e-view-header-key-face
     ((,terminal-class (:inherit message-header-name
                                :weight normal))
      (,terminal-256-class  (:inherit message-header-name
                                     :weight normal))))

   `(mu4e-view-header-value-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :weight normal
                                   :slant normal))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :weight normal
                                        :slant normal))))

   `(mu4e-view-link-face
     ((,terminal-class (:inherit link))
      (,terminal-256-class  (:inherit link))))

   `(mu4e-view-special-header-value-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight normal
                                        :underline nil))))

   ;; mumamo
   `(mumamo-background-chunk-submode1
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   ;; nav
   `(nav-face-heading
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(nav-face-button-num
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(nav-face-dir
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(nav-face-hdir
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(nav-face-file
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(nav-face-hfile
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; nav-flash
   `(nav-flash-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   ;; neo-tree
   `(neo-banner-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background
                                        :weight bold))))


   `(neo-header-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background))))

   `(neo-root-dir-face
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background))))

   `(neo-dir-link-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-background))))

   `(neo-file-link-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(neo-button-face
     ((,terminal-class (:underline nil))
      (,terminal-256-class  (:underline nil))))

   `(neo-expand-btn-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(neo-vc-default-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(neo-vc-user-face
     ((,terminal-class (:foreground ,terminal-red
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :slant italic))))

   `(neo-vc-up-to-date-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(neo-vc-edited-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(neo-vc-needs-update-face
     ((,terminal-class (:underline t))
      (,terminal-256-class  (:underline t))))

   `(neo-vc-needs-merge-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(neo-vc-unlocked-changes-face
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-comments))))

   `(neo-vc-added-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(neo-vc-removed-face
     ((,terminal-class (:strike-through t))
      (,terminal-256-class  (:strike-through t))))

   `(neo-vc-conflict-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(neo-vc-missing-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(neo-vc-ignored-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   ;; adoc-mode / markup
   `(markup-meta-face
     ((,terminal-class (:foreground ,terminal-gray-l))
      (,terminal-256-class  (:foreground ,terminal-256-gray-l))))

   `(markup-table-face
     ((,terminal-class (:foreground ,terminal-blue-hc
                                   :background ,terminal-blue-lc))
      (,terminal-256-class  (:foreground ,terminal-256-blue-hc
                                        :background ,terminal-256-blue-lc))))

   `(markup-verbatim-face
     ((,terminal-class (:background ,terminal-orange-lc))
      (,terminal-256-class  (:background ,terminal-256-orange-lc))))

   `(markup-list-face
     ((,terminal-class (:foreground ,terminal-violet-hc
                                   :background ,terminal-violet-lc))
      (,terminal-256-class  (:foreground ,terminal-256-violet-hc
                                        :background ,terminal-256-violet-lc))))

   `(markup-replacement-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(markup-complex-replacement-face
     ((,terminal-class (:foreground ,terminal-violet-hc
                                   :background ,terminal-violet-lc))
      (,terminal-256-class  (:foreground ,terminal-256-violet-hc
                                        :background ,terminal-256-violet-lc))))

   `(markup-gen-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(markup-secondary-text-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; org-mode
   `(org-agenda-structure
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-highlight-line
                                   :weight bold
                                   :slant normal
                                   :inverse-video nil
                                   :height ,terminal-height-plus-1
                                   :underline nil
                                   :box (:line-width 2 :color ,terminal-background)))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-highlight-line
                                        :weight bold
                                        :slant normal
                                        :inverse-video nil
                                        :height ,terminal-height-plus-1
                                        :underline nil
                                        :box (:line-width 2 :color ,terminal-256-background)))))

   `(org-agenda-calendar-event
     ((,terminal-class (:foreground ,terminal-emphasis))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis))))

   `(org-agenda-calendar-sexp
     ((,terminal-class (:foreground ,terminal-foreground
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :slant italic))))

   `(org-agenda-date
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video nil
                                   :overline nil
                                   :slant normal
                                   :height 1.0
                                   :box (:line-width 2 :color ,terminal-background)))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video nil
                                        :overline nil
                                        :slant normal
                                        :height 1.0
                                        :box (:line-width 2 :color ,terminal-256-background)))) t)

   `(org-agenda-date-weekend
     ((,terminal-class (:inherit org-agenda-date
                                :inverse-video nil
                                :background unspecified
                                :foreground ,terminal-comments
                                :weight unspecified
                                :underline t
                                :overline nil
                                :box unspecified))
      (,terminal-256-class  (:inherit org-agenda-date
                                     :inverse-video nil
                                     :background unspecified
                                     :foreground ,terminal-256-comments
                                     :weight unspecified
                                     :underline t
                                     :overline nil
                                     :box unspecified))) t)

   `(org-agenda-date-today
     ((,terminal-class (:inherit org-agenda-date
                                :inverse-video t
                                :weight bold
                                :underline unspecified
                                :overline nil
                                :box unspecified
                                :foreground ,terminal-blue
                                :background ,terminal-background))
      (,terminal-256-class  (:inherit org-agenda-date
                                     :inverse-video t
                                     :weight bold
                                     :underline unspecified
                                     :overline nil
                                     :box unspecified
                                     :foreground ,terminal-256-blue
                                     :background ,terminal-256-background))) t)

   `(org-agenda-done
     ((,terminal-class (:foreground ,terminal-comments
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :slant italic))) t)

   `(org-archived
     ((,terminal-class (:foreground ,terminal-comments
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :weight normal))))

   `(org-block
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-highlight-alt))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-highlight-alt))))

   `(org-block-background
     ((,terminal-class (:background ,terminal-highlight-alt))
      (,terminal-256-class  (:background ,terminal-256-highlight-alt))))

   `(org-block-begin-line
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-gray-d
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-gray-d
                                        :slant italic))))

   `(org-block-end-line
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-gray-d
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-gray-d
                                        :slant italic))))

   `(org-checkbox
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground
                                   :box (:line-width 1 :style released-button)))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground
                                        :box (:line-width 1 :style released-button)))))

   `(org-code
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(org-date
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline t))))

   `(org-done
     ((,terminal-class (:weight bold
                               :foreground ,terminal-green))
      (,terminal-256-class  (:weight bold
                                    :foreground ,terminal-256-green))))

   `(org-ellipsis
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(org-formula
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(org-headline-done
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(org-hide
     ((,terminal-class (:foreground ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-background))))

   `(org-level-1
     ((,terminal-class (:inherit ,terminal-pitch
                                :height ,terminal-height-plus-4
                                :foreground ,terminal-orange))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :height ,terminal-height-plus-4
                                     :foreground ,terminal-256-orange))))

   `(org-level-2
     ((,terminal-class (:inherit ,terminal-pitch
                                :height ,terminal-height-plus-3
                                :foreground ,terminal-green))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :height ,terminal-height-plus-3
                                     :foreground ,terminal-256-green))))

   `(org-level-3
     ((,terminal-class (:inherit ,terminal-pitch
                                :height ,terminal-height-plus-2
                                :foreground ,terminal-blue))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :height ,terminal-height-plus-2
                                     :foreground ,terminal-256-blue))))

   `(org-level-4
     ((,terminal-class (:inherit ,terminal-pitch
                                :height ,terminal-height-plus-1
                                :foreground ,terminal-yellow))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :height ,terminal-height-plus-1
                                     :foreground ,terminal-256-yellow))))

   `(org-level-5
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-cyan))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-cyan))))

   `(org-level-6
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-green))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-green))))

   `(org-level-7
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-red))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-red))))

   `(org-level-8
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-blue))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-blue))))

   `(org-link
     ((,terminal-class (:foreground ,terminal-blue
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :underline t))))

   `(org-sexp-date
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(org-scheduled
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(org-scheduled-previously
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(org-scheduled-today
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :weight normal))))

   `(org-special-keyword
     ((,terminal-class (:foreground ,terminal-comments
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :weight bold))))

   `(org-table
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(org-tag
     ((,terminal-class (:weight bold))
      (,terminal-256-class  (:weight bold))))

   `(org-time-grid
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(org-todo
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold)))
     ((,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold))))

   `(org-upcoming-deadline
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal
                                        :underline nil))))

   `(org-warning
     ((,terminal-class (:foreground ,terminal-orange
                                   :weight normal
                                   :underline nil))
      (,terminal-256-class  (:foreground ,terminal-256-orange
                                        :weight normal
                                        :underline nil))))

   ;; org-habit (clear=blue, ready=green, alert=yellow, overdue=red. future=lower contrast)
   `(org-habit-clear-face
     ((,terminal-class (:background ,terminal-blue-lc
                                   :foreground ,terminal-blue-hc))
      (,terminal-256-class  (:background ,terminal-256-blue-lc
                                        :foreground ,terminal-256-blue-hc))))

   `(org-habit-clear-future-face
     ((,terminal-class (:background ,terminal-blue-lc))
      (,terminal-256-class  (:background ,terminal-256-blue-lc))))

   `(org-habit-ready-face
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-green))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-green))))

   `(org-habit-ready-future-face
     ((,terminal-class (:background ,terminal-green-lc))
      (,terminal-256-class  (:background ,terminal-256-green-lc))))

   `(org-habit-alert-face
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-yellow-lc))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-yellow-lc))))

   `(org-habit-alert-future-face
     ((,terminal-class (:background ,terminal-yellow-lc))
      (,terminal-256-class  (:background ,terminal-256-yellow-lc))))

   `(org-habit-overdue-face
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-red-lc))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-red-lc))))

   `(org-habit-overdue-future-face
     ((,terminal-class (:background ,terminal-red-lc))
      (,terminal-256-class  (:background ,terminal-256-red-lc))))

   ;; latest additions
   `(org-agenda-dimmed-todo-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(org-agenda-restriction-lock
     ((,terminal-class (:background ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-yellow))))

   `(org-clock-overlay
     ((,terminal-class (:background ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-yellow))))

   `(org-column
     ((,terminal-class (:background ,terminal-highlight-line
                                   :strike-through nil
                                   :underline nil
                                   :slant normal
                                   :weight normal
                                   :inherit default))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :strike-through nil
                                        :underline nil
                                        :slant normal
                                        :weight normal
                                        :inherit default))))

   `(org-column-title
     ((,terminal-class (:background ,terminal-highlight-line
                                   :underline t
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :underline t
                                        :weight bold))))

   `(org-date-selected
     ((,terminal-class (:foreground ,terminal-red
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :inverse-video t))))

   `(org-document-info
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(org-document-title
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :weight bold
                                   :height ,terminal-height-plus-4))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :weight bold
                                        :height ,terminal-height-plus-4))))

   `(org-drawer
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(org-footnote
     ((,terminal-class (:foreground ,terminal-magenta
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :underline t))))

   `(org-latex-and-export-specials
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(org-mode-line-clock-overrun
     ((,terminal-class (:inherit mode-line))
      (,terminal-256-class  (:inherit mode-line))))

   ;; outline
   `(outline-1
     ((,terminal-class (:inherit org-level-1))
      (,terminal-256-class  (:inherit org-level-1))))

   `(outline-2
     ((,terminal-class (:inherit org-level-2))
      (,terminal-256-class  (:inherit org-level-2))))

   `(outline-3
     ((,terminal-class (:inherit org-level-3))
      (,terminal-256-class  (:inherit org-level-3))))

   `(outline-4
     ((,terminal-class (:inherit org-level-4))
      (,terminal-256-class  (:inherit org-level-4))))

   `(outline-5
     ((,terminal-class (:inherit org-level-5))
      (,terminal-256-class  (:inherit org-level-5))))

   `(outline-6
     ((,terminal-class (:inherit org-level-6))
      (,terminal-256-class  (:inherit org-level-6))))

   `(outline-7
     ((,terminal-class (:inherit org-level-7))
      (,terminal-256-class  (:inherit org-level-7))))

   `(outline-8
     ((,terminal-class (:inherit org-level-8))
      (,terminal-256-class  (:inherit org-level-8))))

   ;; parenface
   `(paren-face
     ((,terminal-256-class  (:foreground ,terminal-comments))))

   ;; perspective
   `(persp-selected-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :weight bold))))

   ;; pretty-mode
   `(pretty-mode-symbol-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight normal))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight normal))))

   ;; popup
   `(popup-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   `(popup-isearch-match
     ((,terminal-class (:background ,terminal-green))
      (,terminal-256-class  (:background ,terminal-256-green))))

   `(popup-menu-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   `(popup-menu-mouse-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-foreground))))

   `(popup-menu-selection-face
     ((,terminal-class (:background ,terminal-magenta
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-magenta
                                        :foreground ,terminal-256-background))))

   `(popup-scroll-bar-background-face
     ((,terminal-class (:background ,terminal-comments))
      (,terminal-256-class  (:background ,terminal-256-comments))))

   `(popup-scroll-bar-foreground-face
     ((,terminal-class (:background ,terminal-emphasis))
      (,terminal-256-class  (:background ,terminal-256-emphasis))))

   `(popup-tip-face
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(rainbow-delimiters-depth-2-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(rainbow-delimiters-depth-3-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(rainbow-delimiters-depth-4-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(rainbow-delimiters-depth-5-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(rainbow-delimiters-depth-6-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(rainbow-delimiters-depth-7-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(rainbow-delimiters-depth-8-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(rainbow-delimiters-depth-9-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(rainbow-delimiters-depth-10-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(rainbow-delimiters-depth-11-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(rainbow-delimiters-depth-12-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(rainbow-delimiters-unmatched-face
     ((,terminal-class (:foreground ,terminal-foreground
                                   :background ,terminal-background
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :background ,terminal-256-background
                                        :inverse-video t))))

   ;; rhtm-mode
   `(erb-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background))))

   `(erb-delim-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :background ,terminal-256-background))))

   `(erb-exec-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background))))

   `(erb-exec-delim-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :background ,terminal-256-background))))

   `(erb-out-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background))))

   `(erb-out-delim-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :background ,terminal-256-background))))

   `(erb-comment-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background))))

   `(erb-comment-delim-face
     ((,terminal-class (:foreground ,terminal-cyan
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :background ,terminal-256-background))))

   ;; rst-mode
   `(rst-level-1-face
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-background))))

   `(rst-level-2-face
     ((,terminal-class (:background ,terminal-cyan
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-cyan
                                        :foreground ,terminal-256-background))))

   `(rst-level-3-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background))))

   `(rst-level-4-face
     ((,terminal-class (:background ,terminal-violet
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-violet
                                        :foreground ,terminal-256-background))))

   `(rst-level-5-face
     ((,terminal-class (:background ,terminal-magenta
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-magenta
                                        :foreground ,terminal-256-background))))

   `(rst-level-6-face
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-background))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-background))))

   ;; rpm-mode
   `(rpm-spec-dir-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(rpm-spec-doc-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(rpm-spec-ghost-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(rpm-spec-macro-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(rpm-spec-obsolete-tag-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(rpm-spec-package-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(rpm-spec-section-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(rpm-spec-tag-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(rpm-spec-var-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; sh-mode
   `(sh-quoted-exec
     ((,terminal-class (:foreground ,terminal-violet
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-violet
                                        :weight bold))))

   `(sh-escaped-newline
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   `(sh-heredoc
     ((,terminal-class (:foreground ,terminal-yellow
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :weight bold))))

   ;; smartparens
   `(sp-pair-overlay-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(sp-wrap-overlay-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(sp-wrap-tag-overlay-face
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(sp-show-pair-enclosing
     ((,terminal-class (:inherit highlight))
      (,terminal-256-class  (:inherit highlight))))

   `(sp-show-pair-match-face
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   `(sp-show-pair-mismatch-face
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   ;; show-paren
   `(show-paren-match
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))








































































   `(show-paren-mismatch
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   ;; mic-paren
   `(paren-face-match
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   `(paren-face-mismatch
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   `(paren-face-no-match
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-background
                                   :weight normal
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-background
                                        :weight normal
                                        :inverse-video t))))

   ;; SLIME
   `(slime-repl-inputed-output-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; speedbar
   `(speedbar-button-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-comments))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-comments))))

   `(speedbar-directory-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-blue))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-blue))))

   `(speedbar-file-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-foreground))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-foreground))))

   `(speedbar-highlight-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :background ,terminal-highlight-line))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :background ,terminal-256-highlight-line))))

   `(speedbar-selected-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-yellow
                                :underline t))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-yellow
                                     :underline t))))

   `(speedbar-separator-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :background ,terminal-blue
                                :foreground ,terminal-background
                                :overline ,terminal-cyan-lc))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :background ,terminal-256-blue
                                     :foreground ,terminal-256-background
                                     :overline ,terminal-256-cyan-lc))))

   `(speedbar-tag-face
     ((,terminal-class (:inherit ,terminal-pitch
                                :foreground ,terminal-green))
      (,terminal-256-class  (:inherit ,terminal-pitch
                                     :foreground ,terminal-256-green))))

   ;; sunrise commander headings
   `(sr-active-path-face
     ((,terminal-class (:background ,terminal-blue
                                   :foreground ,terminal-background
                                   :height ,terminal-height-plus-1
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-blue
                                        :foreground ,terminal-256-background
                                        :height ,terminal-height-plus-1
                                        :weight bold))))

   `(sr-editing-path-face
     ((,terminal-class (:background ,terminal-yellow
                                   :foreground ,terminal-background
                                   :weight bold
                                   :height ,terminal-height-plus-1))
      (,terminal-256-class  (:background ,terminal-256-yellow
                                        :foreground ,terminal-256-background
                                        :weight bold
                                        :height ,terminal-height-plus-1))))

   `(sr-highlight-path-face
     ((,terminal-class (:background ,terminal-green
                                   :foreground ,terminal-background
                                   :weight bold
                                   :height ,terminal-height-plus-1))
      (,terminal-256-class  (:background ,terminal-256-green
                                        :foreground ,terminal-256-background
                                        :weight bold
                                        :height ,terminal-height-plus-1))))

   `(sr-passive-path-face
     ((,terminal-class (:background ,terminal-comments
                                   :foreground ,terminal-background
                                   :weight bold
                                   :height ,terminal-height-plus-1))
      (,terminal-256-class  (:background ,terminal-256-comments
                                        :foreground ,terminal-256-background
                                        :weight bold
                                        :height ,terminal-height-plus-1))))

   ;; sunrise commander marked
   `(sr-marked-dir-face
     ((,terminal-class (:inherit diterminal-red-marked))
      (,terminal-256-class  (:inherit diterminal-red-marked))))

   `(sr-marked-file-face
     ((,terminal-class (:inherit diterminal-red-marked))
      (,terminal-256-class  (:inherit diterminal-red-marked))))

   `(sr-alt-marked-dir-face
     ((,terminal-class (:background ,terminal-magenta
                                   :foreground ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-magenta
                                        :foreground ,terminal-256-background
                                        :weight bold))))

   `(sr-alt-marked-file-face
     ((,terminal-class (:background ,terminal-magenta
                                   :foreground ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-magenta
                                        :foreground ,terminal-256-background
                                        :weight bold))))

   ;; sunrise commander fstat
   `(sr-directory-face
     ((,terminal-class (:inherit diterminal-red-directory
                                :weight normal))
      (,terminal-256-class  (:inherit diterminal-red-directory
                                     :weight normal))))

   `(sr-symlink-directory-face
     ((,terminal-class (:inherit diterminal-red-directory
                                :slant italic
                                :weight normal))
      (,terminal-256-class  (:inherit diterminal-red-directory
                                     :slant italic
                                     :weight normal))))

   `(sr-symlink-face
     ((,terminal-class (:inherit diterminal-red-symlink
                                :slant italic
                                :weight normal))
      (,terminal-256-class  (:inherit diterminal-red-symlink
                                     :slant italic
                                     :weight normal))))

   `(sr-broken-link-face
     ((,terminal-class (:inherit diterminal-red-warning
                                :slant italic
                                :weight normal))
      (,terminal-256-class  (:inherit diterminal-red-warning
                                     :slant italic
                                     :weight normal))))

   ;; sunrise commander file types
   `(sr-compressed-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(sr-encrypted-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(sr-log-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(sr-packaged-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(sr-html-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(sr-xml-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   ;; sunrise commander misc
   `(sr-clex-hotchar-face
     ((,terminal-class (:background ,terminal-red
                                   :foreground ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:background ,terminal-256-red
                                        :foreground ,terminal-256-background
                                        :weight bold))))

   ;; syslog-mode
   `(syslog-ip-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-yellow))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-yellow))))

   `(syslog-hour-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-green))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-green))))

   `(syslog-error-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-red
                                        :weight bold))))

   `(syslog-warn-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-orange
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-orange
                                        :weight bold))))

   `(syslog-info-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-blue
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-blue
                                        :weight bold))))

   `(syslog-debug-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-cyan
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-cyan
                                        :weight bold))))

   `(syslog-su-face
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-magenta))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-magenta))))

   ;; table
   `(table-cell
     ((,terminal-class (:foreground ,terminal-foreground
                                   :background ,terminal-highlight-line))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :background ,terminal-256-highlight-line))))

   ;; term
   `(term-color-Black
     ((,terminal-class (:foreground ,terminal-background
                                   :background ,terminal-highlight-line))
      (,terminal-256-class  (:foreground ,terminal-256-background
                                        :background ,terminal-256-highlight-line))))

   `(term-color-red
     ((,terminal-class (:foreground ,terminal-red
                                   :background ,terminal-red-d))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :background ,terminal-256-red-d))))

   `(term-color-green
     ((,terminal-class (:foreground ,terminal-green
                                   :background ,terminal-green-d))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :background ,terminal-256-green-d))))

   `(term-color-yellow
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background ,terminal-yellow-d))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background ,terminal-256-yellow-d))))

   `(term-color-blue
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-blue-d))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-blue-d))))

   `(term-color-magenta
     ((,terminal-class (:foreground ,terminal-magenta
                                   :background ,terminal-magenta-d))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :background ,terminal-256-magenta-d))))

   `(term-color-cyan
     ((,terminal-class (:foreground ,terminal-cyan
                                   :background ,terminal-cyan-d))
      (,terminal-256-class  (:foreground ,terminal-256-cyan
                                        :background ,terminal-256-cyan-d))))

   `(term-color-White
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-foreground))))

   `(term-default-fg-color
     ((,terminal-class (:inherit term-color-White))
      (,terminal-256-class  (:inherit term-color-White))))

   `(term-default-bg-color
     ((,terminal-class (:inherit term-color-Black))
      (,terminal-256-class  (:inherit term-color-Black))))

   ;; tooltip. (NOTE: This setting has no effect on the os widgets for me
   ;; zencoding uses this)
   `(tooltip
     ((,terminal-class (:background ,terminal-green-l
                                   :foreground ,terminal-background
                                   :inherit ,terminal-pitch))))

   ;; tuareg
   `(tuareg-font-lock-governing-face
     ((,terminal-class (:foreground ,terminal-magenta
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-magenta
                                        :weight bold))))

   `(tuareg-font-lock-multistage-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :background ,terminal-highlight-line
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :background ,terminal-256-highlight-line
                                        :weight bold))))

   `(tuareg-font-lock-operator-face
     ((,terminal-class (:foreground ,terminal-emphasis))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis))))

   `(tuareg-font-lock-error-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :background ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :background ,terminal-256-red
                                        :weight bold))))

   `(tuareg-font-lock-interactive-output-face
     ((,terminal-class (:foreground ,terminal-cyan))
      (,terminal-256-class  (:foreground ,terminal-256-cyan))))

   `(tuareg-font-lock-interactive-error-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   ;; undo-tree
   `(undo-tree-visualizer-default-face
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-background))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-background))))

   `(undo-tree-visualizer-unmodified-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(undo-tree-visualizer-current-face
     ((,terminal-class (:foreground ,terminal-blue
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-blue
                                        :inverse-video t))))

   `(undo-tree-visualizer-active-branch-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :background ,terminal-background
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :background ,terminal-256-background
                                        :weight bold))))

   `(undo-tree-visualizer-register-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   ;; volatile highlights
   `(vhl/default-face
     ((,terminal-class (:background ,terminal-green-lc
                                   :foreground ,terminal-green-hc))
      (,terminal-256-class  (:background ,terminal-256-green-lc
                                        :foreground ,terminal-256-green-hc))))

   ;; w3m
   `(w3m-anchor
     ((,terminal-class (:inherit link))
      (,terminal-256-class  (:inherit link))))

   `(w3m-arrived-anchor
     ((,terminal-class (:inherit link-visited))
      (,terminal-256-class  (:inherit link-visited))))

   `(w3m-form
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground))))

   `(w3m-header-line-location-title
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-yellow))))

   `(w3m-header-line-location-content

     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   `(w3m-bold
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :weight bold))))

   `(w3m-image-anchor
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-cyan
                                   :inherit link))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-cyan
                                        :inherit link))))

   `(w3m-image
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-cyan))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-cyan))))

   `(w3m-lnum-minibuffer-prompt
     ((,terminal-class (:foreground ,terminal-emphasis))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis))))

   `(w3m-lnum-match
     ((,terminal-class (:background ,terminal-highlight-line))
      (,terminal-256-class  (:background ,terminal-256-highlight-line))))

   `(w3m-lnum
     ((,terminal-class (:underline nil
                                  :bold nil
                                  :foreground ,terminal-red))
      (,terminal-256-class  (:underline nil
                                       :bold nil
                                       :foreground ,terminal-256-red))))

   `(w3m-session-select
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(w3m-session-selected
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :bold t
                                   :underline t))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :bold t
                                        :underline t))))

   `(w3m-tab-background
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground))))

   `(w3m-tab-selected-background
     ((,terminal-class (:background ,terminal-background
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-background
                                        :foreground ,terminal-256-foreground))))

   `(w3m-tab-mouse
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-yellow))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-yellow))))

   `(w3m-tab-selected
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-emphasis
                                   :bold t))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-emphasis
                                        :bold t))))

   `(w3m-tab-unselected
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-foreground))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-foreground))))

   `(w3m-tab-selected-retrieving
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-red))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-red))))

   `(w3m-tab-unselected-retrieving
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-orange))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-orange))))

   `(w3m-tab-unselected-unseen
     ((,terminal-class (:background ,terminal-highlight-line
                                   :foreground ,terminal-violet))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :foreground ,terminal-256-violet))))

   ;; web-mode
   `(web-mode-builtin-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(web-mode-comment-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(web-mode-constant-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(web-mode-current-element-highlight-face
     ((,terminal-class (:underline unspecified
                                  :weight unspecified
                                  :background ,terminal-highlight-line))
      (,terminal-256-class  (:underline unspecified
                                       :weight unspecified
                                       :background ,terminal-256-highlight-line))))

   `(web-mode-doctype-face
     ((,terminal-class (:foreground ,terminal-comments
                                   :slant italic
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :slant italic
                                        :weight bold))))

   `(web-mode-folded-face
     ((,terminal-class (:underline t))
      (,terminal-256-class  (:underline t))))

   `(web-mode-function-name-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(web-mode-html-attr-name-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(web-mode-html-attr-custom-face
     ((,terminal-class (:inherit web-mode-html-attr-name-face))
      (,terminal-256-class  (:inherit web-mode-html-attr-name-face))))

   `(web-mode-html-attr-engine-face
     ((,terminal-class (:inherit web-mode-block-delimiter-face))
      (,terminal-256-class  (:inherit web-mode-block-delimiter-face))))

   `(web-mode-html-attr-equal-face
     ((,terminal-class (:inherit web-mode-html-attr-name-face))
      (,terminal-256-class  (:inherit web-mode-html-attr-name-face))))

   `(web-mode-html-attr-value-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(web-mode-html-tag-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(web-mode-keyword-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(web-mode-preprocessor-face
     ((,terminal-class (:foreground ,terminal-yellow
                                   :slant normal
                                   :weight unspecified))
      (,terminal-256-class  (:foreground ,terminal-256-yellow
                                        :slant normal
                                        :weight unspecified))))

   `(web-mode-string-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(web-mode-type-face
     ((,terminal-class (:inherit font-lock-type-face))
      (,terminal-256-class  (:inherit font-lock-type-face))))

   `(web-mode-variable-name-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(web-mode-warning-face
     ((,terminal-class (:inherit font-lock-warning-face))
      (,terminal-256-class  (:inherit font-lock-warning-face))))

   `(web-mode-block-face
     ((,terminal-class (:background unspecified))
      (,terminal-256-class  (:background unspecified))))

   `(web-mode-block-delimiter-face
     ((,terminal-class (:inherit font-lock-preprocessor-face))
      (,terminal-256-class  (:inherit font-lock-preprocessor-face))))

   `(web-mode-block-comment-face
     ((,terminal-class (:inherit web-mode-comment-face))
      (,terminal-256-class  (:inherit web-mode-comment-face))))

   `(web-mode-block-control-face
     ((,terminal-class (:inherit font-lock-preprocessor-face))
      (,terminal-256-class  (:inherit font-lock-preprocessor-face))))

   `(web-mode-block-string-face
     ((,terminal-class (:inherit web-mode-string-face))
      (,terminal-256-class  (:inherit web-mode-string-face))))

   `(web-mode-comment-keyword-face
     ((,terminal-class (:box 1 :weight bold))
      (,terminal-256-class  (:box 1 :weight bold))))

   `(web-mode-css-at-rule-face
     ((,terminal-class (:inherit font-lock-constant-face))
      (,terminal-256-class  (:inherit font-lock-constant-face))))

   `(web-mode-css-pseudo-class-face
     ((,terminal-class (:inherit font-lock-builtin-face))
      (,terminal-256-class  (:inherit font-lock-builtin-face))))

   `(web-mode-css-color-face
     ((,terminal-class (:inherit font-lock-builtin-face))
      (,terminal-256-class  (:inherit font-lock-builtin-face))))

   `(web-mode-css-filter-face
     ((,terminal-class (:inherit font-lock-function-name-face))
      (,terminal-256-class  (:inherit font-lock-function-name-face))))

   `(web-mode-css-function-face
     ((,terminal-class (:inherit font-lock-builtin-face))
      (,terminal-256-class  (:inherit font-lock-builtin-face))))

   `(web-mode-css-function-call-face
     ((,terminal-class (:inherit font-lock-function-name-face))
      (,terminal-256-class  (:inherit font-lock-function-name-face))))

   `(web-mode-css-priority-face
     ((,terminal-class (:inherit font-lock-builtin-face))
      (,terminal-256-class  (:inherit font-lock-builtin-face))))

   `(web-mode-css-property-name-face
     ((,terminal-class (:inherit font-lock-variable-name-face))
      (,terminal-256-class  (:inherit font-lock-variable-name-face))))

   `(web-mode-css-selector-face
     ((,terminal-class (:inherit font-lock-keyword-face))
      (,terminal-256-class  (:inherit font-lock-keyword-face))))

   `(web-mode-css-string-face
     ((,terminal-class (:inherit web-mode-string-face))
      (,terminal-256-class  (:inherit web-mode-string-face))))

   `(web-mode-javascript-string-face
     ((,terminal-class (:inherit web-mode-string-face))
      (,terminal-256-class  (:inherit web-mode-string-face))))

   `(web-mode-json-comment-face
     ((,terminal-class (:inherit web-mode-comment-face))
      (,terminal-256-class  (:inherit web-mode-comment-face))))

   `(web-mode-json-context-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(web-mode-json-key-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(web-mode-json-string-face
     ((,terminal-class (:inherit web-mode-string-face))
      (,terminal-256-class  (:inherit web-mode-string-face))))

   `(web-mode-param-name-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(web-mode-part-comment-face
     ((,terminal-class (:inherit web-mode-comment-face))
      (,terminal-256-class  (:inherit web-mode-comment-face))))

   `(web-mode-part-face
     ((,terminal-class (:inherit web-mode-block-face))
      (,terminal-256-class  (:inherit web-mode-block-face))))

   `(web-mode-part-string-face
     ((,terminal-class (:inherit web-mode-string-face))
      (,terminal-256-class  (:inherit web-mode-string-face))))

   `(web-mode-symbol-face
     ((,terminal-class (:foreground ,terminal-violet))
      (,terminal-256-class  (:foreground ,terminal-256-violet))))

   `(web-mode-Whitespace-face
     ((,terminal-class (:background ,terminal-red))
      (,terminal-256-class  (:background ,terminal-256-red))))

   ;; Whitespace-mode
   `(Whitespace-space
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-comments
                                   :inverse-video unspecified
                                   :slant italic))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-comments
                                        :inverse-video unspecified
                                        :slant italic))))

   `(Whitespace-hspace
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-emphasis
                                   :inverse-video unspecified))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-emphasis
                                        :inverse-video unspecified))))

   `(Whitespace-tab
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-red
                                   :inverse-video unspecified
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-red
                                        :inverse-video unspecified
                                        :weight bold))))

   `(Whitespace-newline
     ((,terminal-class(:background unspecified
                                  :foreground ,terminal-comments
                                  :inverse-video unspecified))
      (,terminal-256-class (:background unspecified
                                       :foreground ,terminal-256-comments
                                       :inverse-video unspecified))))

   `(Whitespace-trailing
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-orange-lc
                                   :inverse-video t))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-orange-lc
                                        :inverse-video t))))

   `(Whitespace-line
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-magenta
                                   :inverse-video unspecified))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-magenta
                                        :inverse-video unspecified))))

   `(Whitespace-space-before-tab
     ((,terminal-class (:background ,terminal-red-lc
                                   :foreground unspecified
                                   :inverse-video unspecified))
      (,terminal-256-class  (:background ,terminal-256-red-lc
                                        :foreground unspecified
                                        :inverse-video unspecified))))

   `(Whitespace-indentation
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-yellow
                                   :inverse-video unspecified
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-yellow
                                        :inverse-video unspecified
                                        :weight bold))))

   `(Whitespace-empty
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-red-lc
                                   :inverse-video t))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-red-lc
                                        :inverse-video t))))

   `(Whitespace-space-after-tab
     ((,terminal-class (:background unspecified
                                   :foreground ,terminal-orange
                                   :inverse-video t
                                   :weight bold))
      (,terminal-256-class  (:background unspecified
                                        :foreground ,terminal-256-orange
                                        :inverse-video t
                                        :weight bold))))

   ;; wanderlust
   `(wl-highlight-folder-few-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(wl-highlight-folder-many-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(wl-highlight-folder-path-face
     ((,terminal-class (:foreground ,terminal-orange))
      (,terminal-256-class  (:foreground ,terminal-256-orange))))

   `(wl-highlight-folder-unread-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-folder-zero-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(wl-highlight-folder-unknown-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-message-citation-header
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(wl-highlight-message-cited-text-1
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(wl-highlight-message-cited-text-2
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-cited-text-3
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-message-cited-text-4
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-message-header-contents-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-headers-face
     ((,terminal-class (:foreground ,terminal-red))
      (,terminal-256-class  (:foreground ,terminal-256-red))))

   `(wl-highlight-message-important-header-contents
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-header-contents
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-important-header-contents2
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-signature
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   `(wl-highlight-message-unimportant-header-contents
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(wl-highlight-summary-answeterminal-red-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-summary-disposed-face
     ((,terminal-class (:foreground ,terminal-foreground
                                   :slant italic))
      (,terminal-256-class  (:foreground ,terminal-256-foreground
                                        :slant italic))))

   `(wl-highlight-summary-new-face
     ((,terminal-class (:foreground ,terminal-blue))
      (,terminal-256-class  (:foreground ,terminal-256-blue))))

   `(wl-highlight-summary-normal-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(wl-highlight-summary-thread-top-face
     ((,terminal-class (:foreground ,terminal-yellow))
      (,terminal-256-class  (:foreground ,terminal-256-yellow))))

   `(wl-highlight-thread-indent-face
     ((,terminal-class (:foreground ,terminal-magenta))
      (,terminal-256-class  (:foreground ,terminal-256-magenta))))

   `(wl-highlight-summary-refiled-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(wl-highlight-summary-displaying-face
     ((,terminal-class (:underline t
                                  :weight bold))
      (,terminal-256-class  (:underline t
                                       :weight bold))))

   ;; weechat
   `(weechat-error-face
     ((,terminal-class (:inherit error))
      (,terminal-256-class  (:inherit error))))

   `(weechat-highlight-face
     ((,terminal-class (:foreground ,terminal-emphasis
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-emphasis
                                        :weight bold))))

   `(weechat-nick-self-face
     ((,terminal-class (:foreground ,terminal-green
                                   :weight unspecified
                                   :inverse-video t))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight unspecified
                                        :inverse-video t))))

   `(weechat-prompt-face
     ((,terminal-class (:inherit minibuffer-prompt))
      (,terminal-256-class  (:inherit minibuffer-prompt))))

   `(weechat-time-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   ;; which-func-mode
   `(which-func
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   ;; which-key
   `(which-key-key-face
     ((,terminal-class (:foreground ,terminal-green
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-green
                                        :weight bold))))

   `(which-key-separator-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(which-key-note-face
     ((,terminal-class (:foreground ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments))))

   `(which-key-command-description-face
     ((,terminal-class (:foreground ,terminal-foreground))
      (,terminal-256-class  (:foreground ,terminal-256-foreground))))

   `(which-key-local-map-description-face
     ((,terminal-class (:foreground ,terminal-yellow-hc))
      (,terminal-256-class  (:foreground ,terminal-256-yellow-hc))))

   `(which-key-group-description-face
     ((,terminal-class (:foreground ,terminal-red
                                   :weight bold))
      (,terminal-256-class  (:foreground ,terminal-256-red
                                        :weight bold))))
   ;; window-number-mode
   `(window-number-face
     ((,terminal-class (:foreground ,terminal-green))
      (,terminal-256-class  (:foreground ,terminal-256-green))))

   ;; yascroll
   `(yascroll:thumb-text-area
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-comments))))

   `(yascroll:thumb-fringe
     ((,terminal-class (:foreground ,terminal-comments
                                   :background ,terminal-comments))
      (,terminal-256-class  (:foreground ,terminal-256-comments
                                        :background ,terminal-256-comments))))

   ;; zencoding
   `(zencoding-preview-input
     ((,terminal-class (:background ,terminal-highlight-line
                                   :box ,terminal-emphasis))
      (,terminal-256-class  (:background ,terminal-256-highlight-line
                                        :box ,terminal-256-emphasis)))))

  (custom-theme-set-variables
   'terminal
   `(ansi-color-names-vector [,terminal-background ,terminal-red ,terminal-green ,terminal-yellow
                                                  ,terminal-blue ,terminal-magenta ,terminal-cyan ,terminal-foreground])

   ;; compilation
   `(compilation-message-face 'default)

   ;; fill-column-indicator
   `(fci-rule-color ,terminal-highlight-line)

   ;; magit
   `(magit-diff-use-overlays nil)

   ;; highlight-changes
   `(highlight-changes-colors '(,terminal-magenta ,terminal-violet))

   ;; highlight-tail
   `(highlight-tail-colors
     '((,terminal-highlight-line . 0)
       (,terminal-green-lc . 20)
       (,terminal-cyan-lc . 30)
       (,terminal-blue-lc . 50)
       (,terminal-yellow-lc . 60)
       (,terminal-orange-lc . 70)
       (,terminal-magenta-lc . 85)
       (,terminal-highlight-line . 100)))

   ;; pos-tip
   `(pos-tip-foreground-color ,terminal-background)
   `(pos-tip-background-color ,terminal-green)



   ;; vc
   `(vc-annotate-color-map
     '((20 . ,terminal-red)
       (40 . "#CF4F1F")
       (60 . "#C26C0F")
       (80 . ,terminal-yellow)
       (100 . "#AB8C00")
       (120 . "#A18F00")
       (140 . "#989200")
       (160 . "#8E9500")
       (180 . ,terminal-green)
       (200 . "#729A1E")
       (220 . "#609C3C")
       (240 . "#4E9D5B")
       (260 . "#3C9F79")
       (280 . ,terminal-cyan)
       (300 . "#299BA6")
       (320 . "#2896B5")
       (340 . "#2790C3")
       (360 . ,terminal-blue)))
   `(vc-annotate-very-old-color nil)
   `(vc-annotate-background nil)

   ;; weechat
   `(weechat-color-list
     (unspecified ,terminal-background ,terminal-highlight-line
                  ,terminal-red-d ,terminal-red
                  ,terminal-green-d ,terminal-green
                  ,terminal-yellow-d ,terminal-yellow
                  ,terminal-blue-d ,terminal-blue
                  ,terminal-magenta-d ,terminal-magenta
                  ,terminal-cyan-d ,terminal-cyan
                  ,terminal-foreground ,terminal-emphasis))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'terminal)

;; Local Variables:
;; no-byte-compile: t
;; fill-column: 95
;; End:

;;; terminal-theme.el ends here
