;;; See https://github.com/syl20bnr/spacemacs/blob/master/doc/LAYERS.org#anatomy-of-a-layer

;;; This file contains general key bindings. It is the last file loaded. The
;;; word general here means independent of any package. Since the end user can
;;; exclude an arbitrary set of packages, you cannot be sure that, just because
;;; your layer includes a package, that package will necessarily be loaded. For
;;; this reason, code in these files must be generally safe, regardless of which
;;; packages are installed.

;; Use describe-personal-keybindings to list these out.
;;(require 'bind-key)

;; Make C-x, -c, -v behave properly if there is a selection. C-x KEY still works!
;; C-z is undo. C-RET starts rectangle selection mode.
(cua-mode t)

;; ******************* Function keys ********************
;; Move help to F1. Must happen before we rebind C-h.
(global-set-key [f1] (lookup-key global-map (kbd "C-h")))
(bind-key* "<f2>"    #'er/expand-region)      ;; From MS Excel muscle memory.
(bind-key* "S-<f2>"  #'wd-shrink-region)
(bind-key* "M-<f4>"  #'kill-buffer)           ;; CUA.
(bind-key* "M-<f5>"  #'recenter-top-bottom)   ;; Ought to be F5, but want to reserve that for "VS debug program".
(bind-key* "<f7>"    #'ff-find-other-file)    ;; VS View.ToggleDesigner.

;; ******************* Letter keys ********************
(bind-key* "C-a"     #'wd-back-to-indentation-or-beginning)
(bind-key* "C-S-a"   #'mark-whole-buffer)
(bind-key* "C-x C-b" #'helm-mini)
(bind-key* "C-x b"   #'helm-mini)
(bind-key* "M-c"     #'wd-copy-line)
(bind-key* "C-M-c"   #'wd-duplicate-line-or-region)
(bind-key* "C-S-d"   #'dired-jump)

;; This moves isearch-forward from C-s to C-f. We also need to adjust the keys within the isearch-mode-map.
(bind-key "C-f"      #'isearch-forward)
(bind-key "C-f"      #'isearch-repeat-forward isearch-mode-map)
(bind-key "C-v"      #'isearch-yank-kill isearch-mode-map)
(unbind-key "C-s"    isearch-mode-map)
(unbind-key "C-w"    isearch-mode-map)
(unbind-key "C-y"    isearch-mode-map)

(bind-key* "M-f"     #'helm-occur)
(bind-key* "C-S-g"   #'helm-all-mark-rings)
(bind-key* "C-h"     #'query-replace)                   ;; VS. Change to regex version by default?
(bind-key* "M-h"     #'wd-query-replace-whole-buffer)
(bind-key* "C-S-h"   #'query-replace-regexp)
(bind-key* "C-i"     #'spacemacs/indent-region-or-buffer)
(bind-key* "C-j"     #'wd-kill-whitespace-and-indent)
(bind-key* "M-j"     #'wd-kill-whitespace)
(bind-key* "C-S-j"   #'wd-kill-whitespace-leave-one-space)
(bind-key* "C-l"     #'kill-whole-line)
(bind-key* "C-n"     #'spacemacs/new-empty-buffer)
(bind-key* "C-o"     #'spacemacs/helm-find-files)
(bind-key* "M-o"     #'ff-find-other-file)
(bind-key* "C-M-o"   #'revert-buffer)
;; https://github.com/syl20bnr/spacemacs/blob/b7e51d70aa3fb81df2da6dc16d9652a002ba5e6b/layers/%2Bdistributions/spacemacs-base/packages.el
;; (bind-key "C-p"   #'projects)
(global-set-key      [remap fill-paragraph] #'wd-fill-or-unfill)
(bind-key* "M-r"     #'isearch-backward-regexp)
(bind-key* "C-s"     #'save-buffer)
(bind-key* "M-s"     #'write-file)
(bind-key* "C-M-s"   #'wd-rename-file-and-buffer)
(bind-key* "C-S-s"   #'save-some-buffers)
(bind-key* "C-u"     #'wd-xah-toggle-letter-case)
;;(bind-key* "M-v"     #'helm-show-kill-ring)   ;; WILL NOT BIND.
(bind-key* "C-S-v"   #'helm-show-kill-ring)
(bind-key* "C-w"     #'kill-buffer)             ;; Does not stick, gets reset to ido-kill-buffer for some reason.
(bind-key* "C-S-w"   #'wd-delete-file-and-buffer)
(bind-key* "C-M-x"   #'append-next-kill)
(bind-key* "C-y"     #'repeat)                  ;; From MS Office. Consider using "redo" here, it seems more standard.
;; Cua mode should bind C-z to undo, but it seems to keep getting rebound to
;; evil-exit-emacs-state.

;; ******************* Punctutation ********************
(bind-key* "M-;"    #'wd-endless/comment-line-or-region)
(bind-key* "C-'"    #'er/expand-region)
(bind-key* "C-S-'"  #'wd-shrink-region)

;; ******************* Arrow, PgUp/Down and other TKL keys ********************
;; C-arrow and S-arrow are already Windows compatible (move by word, extend selection, respectively)
;; These functions used to be bound to C-, since M- clashes with org-mode
;; keybindings. However, I do not really use org-mode, and moving them back to
;; M- allows me to use C- for more natural Windows keybindings.
(bind-key* "M-<up>"    #'windmove-up)
(bind-key* "M-<down>"  #'windmove-down)
(bind-key* "M-<left>"  #'windmove-left)
(bind-key* "M-<right>" #'windmove-right)

(bind-key* "C-S-<return>"  #'wd-ergoemacs-open-line-below)
(bind-key* "C-M-<return>"  #'wd-ergoemacs-open-line-above)       ;; From Notepad++.
(bind-key* "M-S-<return>"  #'spacemacs/toggle-fullscreen-frame)  ;; VS standard. Windows standard is F11.
(bind-key* "C-<tab>"       #'helm-mini)                          ;; Like VS quick switch window.
(bind-key* "M-<backspace>" #'undo)
