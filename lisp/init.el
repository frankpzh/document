(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/google3")
(require 'require-maybe)
(require-maybe 'utility)
(require-maybe 'taglist)
(require-maybe 'diff-color)
(require-maybe 'cindent)
(require-maybe 'pyindent)
(require-maybe 'project)
(require-maybe 'elisp-enhance)
(require-maybe 'csearch)
(require-maybe 'magit)
(require-maybe 'js-mode)
(require-maybe 'putty)
(require-maybe 'mako)

(require-maybe 'layout-setting)
(require-maybe 'org-setting)
(require-maybe 'shell-setting)
(require-maybe 'ibuffer-setting)

;; Desktop save
(when (require-maybe 'desktop)
  (desktop-save-mode 1))

;; Font selection
(setq font-family-preference-list
      (list "Consolas"
            "Droid Sans Mono"
            "Terminus"))

(defun select-font-family ()
  (let ((list font-family-preference-list))
    (while (not
            (or (eq list nil)
                (some (lambda (family)
                        (equal (car list)
                               family))
                      (font-family-list))))
      (setq list (cdr list)))
    (if (not (null list))
        (car list))))

;; Interface stuffs
(defun setup-frame (frame)
  (select-frame frame)
  (when (not (null window-system))
    (let ((family (select-font-family)))
      (set-face-attribute 'default nil :family family)
      (set-face-attribute 'default nil :height 110))

    (tool-bar-mode 0))

  (if (require-maybe 'color-theme)
      (let ((color-theme-is-global nil))
        (color-theme-initialize)
        (color-theme-blackboard)))

  ;; Faces
  (when (require-maybe 'magit)
    (set-face-attribute 'magit-diff-add nil :foreground "green")
    (set-face-attribute 'magit-diff-del nil :foreground "red")
    (set-face-attribute 'magit-header nil :foreground "cyan")
    (set-face-attribute 'magit-item-highlight nil :background "#202020"))

  (set-face-attribute 'comint-highlight-input nil :foreground "light green")
  (set-face-attribute 'comint-highlight-prompt nil :foreground "gold1")

  (if (eq system-uses-terminfo t)
      (set-putty-keymap))
  (menu-bar-mode 0)

 ;; Set window transparent
  (set-frame-parameter (selected-frame) 'alpha '(85 50)))

(add-hook 'after-make-frame-functions
          'setup-frame)

;; Misc
(setq-default make-backup-files nil)
(setq initial-buffer-choice nil)
(column-number-mode t)
(display-time)
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-margin 3)
(setq scroll-conservatively 10000)
(setq scroll-preserve-screen-position t)

;; Editing
(setq-default fill-column 79)

;; Key bindings
(define-prefix-command 'find-map)
(define-prefix-command 'tag-map)
(define-prefix-command 'goto-map)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "C-x C-r") 'revert-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-M-<backspace>") 'backward-kill-sexp)
(global-set-key (kbd "C-q") 'fill-region)
(global-set-key (kbd "C-z") 'other-window)
(global-set-key (kbd "C-S-<SPC>") 'browse-url-at-point)
(global-set-key (kbd "C-+") 'enlarge-window)
(global-set-key (kbd "C-_") 'shrink-window)

(global-set-key (kbd "<f2>") 'undo)
(global-set-key (kbd "<f3>") 'find-map)
(global-set-key (kbd "<f3> t") 'taglist)
(global-set-key (kbd "<f3> g") 'grep)
(global-set-key (kbd "<f3> f") 'occur)
(global-set-key (kbd "<f3> c") 'csearch)
(global-set-key (kbd "<f4>") 'tag-map)
(global-set-key (kbd "<f4> c") 'clear-tag-list)
(global-set-key (kbd "<f4> s") 'select-tag)
(global-set-key (kbd "<f6>") 'goto-map)
(global-set-key (kbd "<f6> l") 'goto-line)
(global-set-key (kbd "<f6> j") 'jump-to-register)
(global-set-key (kbd "<f6> s") 'point-to-register)
(global-set-key (kbd "<f8>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<f9>") 'kmacro-end-or-call-macro)


(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g l")
                (lambda () (interactive) (compile "git5 --no-pager lint -d -v")))
(global-set-key (kbd "C-x g c")
                (lambda () (interactive) (compile "git5 comments -q")))

;; Dired settings
(when (require-maybe 'dired-x)
  (add-hook 'dired-load-hook
            (lambda ()
              (load "dired-x")))

  (add-hook 'dired-mode-hook
            (lambda ()
              (dired-omit-mode 1)
              (setq dired-omit-files "\\.\\(o\\|opic\\|cmd\\)$"))))

;; Gtalk
(when (require-maybe 'jabber)
  (setq jabber-account-list
        '(("frankpzh@gmail.com"
           (:network-server . "talk.google.com")
           (:connection-type . ssl))))
  (setq jabber-roster-line-format " %c %-25n %u %-8s  %S"))
(setq frame-title-format '("" jabber-activity-mode-string " Emacs - %b"))

;; Disable Version Control
(setq vc-handled-backends nil)

;; ispell language
(setq ispell-local-dictionary "american")

;; Lua Mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; Browser setting
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(provide 'init)
