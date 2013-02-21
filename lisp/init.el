;;----------------------------------------------------------------------
;; Basic environment
(defvar google-corp nil)
(let ((google3-dir "/google/src/head/depot/eng/elisp"))
  (when (file-directory-p google3-dir)
    (setq google-corp t)
    (add-to-list 'load-path google3-dir)
    (add-to-list 'load-path (concat google3-dir "/third_party"))))
(require 'require-maybe)

;;----------------------------------------------------------------------
;; File modes go before desktop
(require-maybe 'mako-mode)
(autoload 'js2-mode "js2-mode" "Javascript editing mode." t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; Yaml Mode
(autoload 'yaml-mode "yaml-mode" "YAML editing mode." t)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
;; Lua Mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(when google-corp
  (if (require-maybe 'borg-mode)
      (add-to-list 'auto-mode-alist '("\\.borg$" . borg-mode)))
  (if (require-maybe 'google3-build-mode)
      (add-to-list 'auto-mode-alist '("BUILD$" . google3-build-mode)))
  (if (require-maybe 'protobuf-mode)
      (add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))))


;;----------------------------------------------------------------------
;; Save/load desktop
(when (require-maybe 'desktop)
  (setq desktop-dirname "~/.emacs.d/")
  (desktop-save-mode 1))


;;----------------------------------------------------------------------
;; Interface settings: color-theme, font, menubar, toolbar, keymap
(defvar font-family-preference-list
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

(defun setup-frame (frame)
  (if frame
      (select-frame frame))

  ;; Set (font, toolbar, menubar, transparent) in window system
  (when (not (null window-system))
    (let ((family (select-font-family)))
      (set-face-attribute 'default nil :family family)
      (set-face-attribute 'default nil :height 110))
    (tool-bar-mode 0)
    (menu-bar-mode 0)
    (set-frame-parameter (selected-frame) 'alpha '(85 50)))

  ;; Color theme
  (when (require-maybe 'color-theme)
    (let ((color-theme-is-global (not frame)))
      (color-theme-initialize)
      (color-theme-blackboard)))

  ;; Extra Faces
  (when (require-maybe 'magit)
    (set-face-attribute 'magit-diff-add nil :foreground "green")
    (set-face-attribute 'magit-diff-del nil :foreground "red")
    (set-face-attribute 'magit-header nil :foreground "cyan")
    (set-face-attribute 'magit-item-highlight nil :background "#202020"))

  (when (require-maybe 'shell)
    (set-face-attribute 'comint-highlight-input nil :foreground "light green")
    (set-face-attribute 'comint-highlight-prompt nil :foreground "gold1"))

  (require-maybe 'diff-color)

  ;; Keymap of PuTTY
  (if (eq system-uses-terminfo t)
      (if (require-maybe 'putty)
          (set-putty-keymap))))

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      'setup-frame)
  (setup-frame nil))


;;----------------------------------------------------------------------
;; General settings
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

;; Browser setting
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(require-maybe 'layout-setting)
(require-maybe 'org-setting)
(require-maybe 'shell-setting)
(require-maybe 'ibuffer-setting)
(require-maybe 'cindent-setting)

(when google-corp
  (require-maybe 'google-coding-style))


;;----------------------------------------------------------------------
;; Third party libraries
(require-maybe 'utility)
(require-maybe 'taglist)
(require-maybe 'project)
(require-maybe 'elisp-enhance)
(require-maybe 'magit)
(when google-corp
  (require-maybe 'csearch)
  (require-maybe 'google-lint))


;;----------------------------------------------------------------------
;; Key bindings

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
(define-prefix-command 'find-map nil
  "t: taglist   c: csearch\ng: grep      f: occur\nPlease select")
(global-set-key (kbd "<f3>") 'find-map)
(global-set-key (kbd "<f3> t") 'taglist)
(global-set-key (kbd "<f3> g") 'grep)
(global-set-key (kbd "<f3> f") 'occur)
(global-set-key (kbd "<f3> c") 'csearch)
(global-set-key (kbd "<f3> C-g") 'keyboard-quit)
(define-prefix-command 'tag-map nil
  "c: clear tag list   s: select tag\nPlease select")
(global-set-key (kbd "<f4>") 'tag-map)
(global-set-key (kbd "<f4> c") 'clear-tag-list)
(global-set-key (kbd "<f4> s") 'select-tag)
(global-set-key (kbd "<f4> C-g") 'keyboard-quit)
(define-prefix-command 'goto-map nil
  "l: goto line\nj: jump to register   s: point to register\nPlease select")
(global-set-key (kbd "<f6>") 'goto-map)
(global-set-key (kbd "<f6> l") 'goto-line)
(global-set-key (kbd "<f6> j") 'jump-to-register)
(global-set-key (kbd "<f6> s") 'point-to-register)
(global-set-key (kbd "<f6> C-g") 'keyboard-quit)
(global-set-key (kbd "<f8>") 'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "C-<f8>") 'kmacro-end-or-call-macro)


(global-unset-key (kbd "C-x g"))
(global-set-key (kbd "C-x g l")
                (lambda () (interactive) (compile "git5 --no-pager lint -d -v")))
(global-set-key (kbd "C-x g c")
                (lambda () (interactive) (compile "git5 comments -q")))

(provide 'init)
