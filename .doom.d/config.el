;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;; global keymappings
;;
(global-set-key "\C-d" 'delete-backward-char)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-j" 'indent-region)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-x\C-o" 'other-window)
(global-set-key "\C-x\k" 'kill-buffer)
(global-set-key "\C-x\C-k" 'kill-buffer)
(global-set-key "\C-x\d" 'mark-whole-buffer)
(global-set-key "\C-x\C-h" 'mark-whole-buffer)
(global-set-key [S-right] 'forward-word)
(global-set-key [S-left] 'backward-word)
(global-set-key [?\e down] 'end-of-buffer)
(global-set-key [?\e up] 'beginning-of-buffer)
(global-set-key "\M-5" 'query-replace)
(global-set-key "\C-x\f" 'find-file)
(global-set-key "\C-xf" 'find-file)
(global-set-key (kbd "C-x C-v") 'revert-buffer)

;;
;; keymappings
;;
;(define-key isearch-mode-map "\C-d" 'isearch-delete-char)
;(define-key c++-mode-map "\C-d" 'delete-backward-char)
;(define-key java-mode-map "\C-d" 'delete-backward-char)
;(global-set-key (kbd "M-y") 'browse-kill-ring)

;;
;; Global settings
;;
(setq fill-column 80)

;;
;; compilation-always-kill
;;
(load-file "~/.doom.d/compilation-always-kill.el")
(autoload 'compilation-always-kill-mode "compilation-always-kill" nil t)
(compilation-always-kill-mode 1)

;;
;; Copy the buffer file name into the kill ring
;;
(defun copy-buffer-file-name-as-kill (choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
        (name (if (eq major-mode 'dired-mode)
                  (dired-get-filename)
                (or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
           (setq new-kill-string name))
          ((eq choice ?d)
           (setq new-kill-string (file-name-directory name)))
          ((eq choice ?n)
           (setq new-kill-string (file-name-nondirectory name)))
          (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))

(global-set-key "\C-c\C-f" 'copy-buffer-file-name-as-kill)

;;
;; compilation
;;
(setq compilation-scroll-output t)
;;(setq compilation-window-height 20)


;;
;; helm
;;
(helm-mode 0)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key "\C-f" 'helm-buffers-list)
(setq helm-buffer-max-length 60)
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
(add-hook 'helm-before-initialize-hook
          (lambda ()
            (add-to-list 'helm-boring-buffer-regexp-list "*Compile-Log*")
            (add-to-list 'helm-boring-buffer-regexp-list "*Backtrace*")
            (add-to-list 'helm-boring-buffer-regexp-list "*Messages*")
            (add-to-list 'helm-boring-buffer-regexp-list "*Completions*")
            (add-to-list 'helm-boring-buffer-regexp-list "*Debug Helm Log*")))

;;
;; pii
;;
(setq user-full-name "Steven Ness"
      user-mail-address "sness@sness.net")

;;
;; scroll one line at a time
;;
(defun scroll-one-line-up (&optional arg)
  "Scroll the selected window up (forward in the text) one line (or N lines)."
  (interactive "p")
  (scroll-up (or arg 1)))
(defun scroll-one-line-down (&optional arg)
  "Scroll the selected window down (backward in the text) one line (or N)."
  (interactive "p")
  (scroll-down (or arg 1)))
(global-set-key [S-down] 'scroll-one-line-up)
(global-set-key [S-up]  'scroll-one-line-down)

;;
;; insert the current date into the buffer
;;
(defun insert-date ()
  "Insert date at the current cursor position in the current buffer."
  (interactive)
  (insert
   (format-time-string "* %a %b %d %Y - %H:%M:%S %p")
   "\n"
   "  -----------------------------"
   "\n"))
(global-set-key "\M-i" 'insert-date)


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dark+)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
