(defun wd-shrink-region ()
  "Shrinks the current region by 1 step."
  (interactive)
  (er/expand-region -1))

(defun wd-back-to-indentation-or-beginning ()
  "Toggle between indentation and true beginning of line."
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun wd-query-replace-whole-buffer ()
  "Run query-replace for an entire buffer. By default,
query-replace just runs from the current point to the end of the
buffer. This command starts it from the beginning of the buffer,
then restores point afterwards."
  (interactive "*")
  (save-excursion
    (goto-char (point-min))
    (call-interactively #'query-replace)))

(defun wd-write-copy-to-file ()
  "Write a copy of the current buffer or region to a file."
  ;; From http://stackoverflow.com/questions/18770669/how-can-i-save-as-in-emacs-without-visiting-the-new-file
  (interactive)
  (let* ((curr (buffer-file-name))
         (new (read-file-name
               "Copy to file: " nil nil nil
               (and curr (file-name-nondirectory curr))))
         (mustbenew (if (and curr (file-equal-p new curr)) 'excl t)))
    (if (use-region-p)
        (write-region (region-beginning) (region-end) new nil nil nil mustbenew)
      (save-restriction
        (widen)
        (write-region (point-min) (point-max) new nil nil nil mustbenew)))))

(defun wd-rename-file-and-buffer (new-name)
  "Rename the current buffer and the file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun wd-delete-file-and-buffer ()
  "Delete the current buffer and its backing file."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (ido-kill-buffer)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))

;; From better defaults.
;; http://endlessparentheses.com/fill-and-unfill-paragraphs-with-a-single-key.html
(defun wd-fill-or-unfill ()
  "Like `fill-paragraph', but unfill if used twice."
  (interactive "*")
  (let ((fill-column
         (if (eq last-command 'spacemacs/fill-or-unfill)
             (progn (setq this-command nil)
                    (point-max))
           fill-column)))
    (call-interactively #'fill-paragraph)))

(defun wd-xah-toggle-letter-case ()
  "Toggle the letter case of current word or text selection.
Always cycle in this order: Init Caps, ALL CAPS, all lower.

URL `http://ergoemacs.org/emacs/modernization_upcase-word.html'
Version 2016-01-08"
  (interactive "*")
  (let (
        (deactivate-mark nil)
        -p1 -p2)
    (if (use-region-p)
        (setq -p1 (region-beginning)
              -p2 (region-end))
      (save-excursion
        (skip-chars-backward "[:alnum:]")
        (setq -p1 (point))
        (skip-chars-forward "[:alnum:]")
        (setq -p2 (point))))
    (when (not (eq last-command this-command))
      (put this-command 'state 0))
    (cond
     ((equal 0 (get this-command 'state))
      (upcase-initials-region -p1 -p2)
      (put this-command 'state 1))
     ((equal 1  (get this-command 'state))
      (upcase-region -p1 -p2)
      (put this-command 'state 2))
     ((equal 2 (get this-command 'state))
      (downcase-region -p1 -p2)
      (put this-command 'state 0)))))

(defun wd-ergoemacs-open-line-below ()
  "Open line below.
If a major/minor mode rebinds the default M-RET command, use that instead."
  (interactive "*")
  (end-of-line)
  (newline-and-indent))

(defun wd-ergoemacs-open-line-above ()
  "Open line above"
  (interactive "*")
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-for-tab-command))

(defun wd--kill-whitespace (leave)
  "Kill all the whitespace around point. If there is no whitespace around point,
first move to the end of the current line then kill. Has the
effect of joining lines and eliminating consecutive blank lines.
LEAVE is a string to insert after the deletion, or a function to
run."
  ;; From https://www.emacswiki.org/emacs/DeletingWhitespace
  (save-excursion
    (save-restriction
      (save-match-data
        (progn
          (unless (looking-at-p "[ \t\r\n]")
            (end-of-line))
          (re-search-backward "[^ \t\r\n]" nil t)
          (re-search-forward "[ \t\r\n]+" nil t)
          (replace-match "" nil nil)
          (when leave
            (if (functionp leave)
                (funcall leave)
              (insert leave))))))))

(defun wd-kill-whitespace ()
  "Kill all the whitespace around point.
Has the effect of joining lines and eliminating consecutive blank lines."
  (interactive "*")
  (wd--kill-whitespace nil))

(defun wd-kill-whitespace-leave-one-space ()
  "Kills all whitespace around point except for a single space."
  (interactive "*")
  (wd--kill-whitespace " "))

(defun wd-kill-whitespace-and-indent ()
  "Kills all whitespace around point, but do not join the next non-blank line."
  (interactive "*")
  (wd--kill-whitespace 'newline-and-indent))

(defun wd-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines.

From https://www.emacswiki.org/emacs/CopyingWholeLines. I removed
the automatic move to the next line, as I often want to move up
when I copy a line, not necessarily down."
  (interactive "p")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (when mark-active
      (if (> (point) (mark))
          (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
        (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
    (if (eq last-command 'copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-ring-save beg end)))
  ;; This extra \n makes the sequence of commands "copy line, paste" work well.
  (kill-append "\n" nil)
  ;;(beginning-of-line (or (and arg (1+ arg)) 2))
  (if (and arg (not (= 1 arg)))
      (message "%d lines copied" arg)))

(defun wd-duplicate-line-or-region (arg)
  "Duplicate current line, or lines spanned by the region if active."
  (interactive "*p")
  (call-interactively #'wd-copy-line arg)
  (end-of-line)
  ;; Prepend a newline for a better undo experience.
  ;; Remove the trailing newline to avoid extra blank lines.
  (let* ((text (concat "\n" (substring (car kill-ring-yank-pointer) 0 -1))))
    (insert text)))

(defun wd-endless/comment-line-or-region (n)
  "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above.
If region is active, apply to active region instead."
  (interactive "*p")
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning) (region-end))
    (let ((range
           (list (line-beginning-position)
                 (goto-char (line-end-position n)))))
      (comment-or-uncomment-region
       (apply #'min range)
       (apply #'max range)))
    (forward-line 1)
    (back-to-indentation)))

(defun wd-endless/forward-paragraph (&optional n)
  "Advance just past next blank line."
  (interactive "p")
  (let ((para-commands
         '(endless/forward-paragraph endless/backward-paragraph)))
    ;; Only push mark if it's not active and we're not repeating.
    (or (use-region-p)
        (not (member this-command para-commands))
        (member last-command para-commands)
        (push-mark))
    ;; The actual movement.
    (dotimes (_ (abs n))
      (if (> n 0)
          (skip-chars-forward "\n[:blank:]")
        (skip-chars-backward "\n[:blank:]"))
      (if (search-forward-regexp
           "\n[[:blank:]]*\n[[:blank:]]*" nil t (cl-signum n))
          (goto-char (match-end 0))
        (goto-char (if (> n 0) (point-max) (point-min)))))))

(defun wd-endless/backward-paragraph (&optional n)
  "Go back up to previous blank line."
  (interactive "p")
  (endless/forward-paragraph (- n)))

(defun wd-term-dont-prompt-on-exit ()
  "Stop Emacs prompting with 'Active processes exist, kill them?' when exiting Emacs.
From http://stackoverflow.com/questions/2706527/make-emacs-stop-asking-active-processes-exist-kill-them-and-exit-anyway"
  (set-process-query-on-exit-flag
   (get-buffer-process (current-buffer)) nil))

(defun wd-term-exec-hook ()
  "Make exiting ansi-term or shell-mode kill the buffer.
Originally called oleh-term-exec-hook."
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (set-process-sentinel
     proc
     `(lambda (process event)
        (if (string= event "finished\n")
            (kill-buffer ,buff))))))

;; This pair of calls is for term and ansi-term.
(add-hook 'term-exec-hook   #'wd-term-exec-hook)
(add-hook 'term-exec-hook   #'wd-term-dont-prompt-on-exit)

;; This is necessary for shell-mode, which is derived from comint-mode.
(add-hook 'comint-exec-hook #'wd-term-exec-hook)
(add-hook 'comint-exec-hook #'wd-term-dont-prompt-on-exit)

;; Don't prompt about killing buffers with live processes attached to them.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))
