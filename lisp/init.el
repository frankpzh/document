(add-to-list 'load-path "~/.emacs.d")
(require 'require-maybe)
(require-maybe 'dired-x)
(require-maybe 'maximize-emacs)
(require-maybe 'utility)
(require-maybe 'taglist)
(require-maybe 'diff-color)
(require-maybe 'cindent)
(require-maybe 'org-setting)
(require-maybe 'elisp-enhance)

;; Desktop save
(when (require-maybe 'desktop)
  (desktop-save-mode 1))

;; Font/color stuffs
(when (require-maybe 'color-theme)
  (color-theme-initialize)
  (if (not (null window-system))
      (color-theme-blackboard)))

(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas")
  (set-face-attribute 'default nil :family "Terminus"))

;; Set window transparent
(add-to-list 'default-frame-alist (cons 'alpha 90))
(setq-default make-backup-files nil)
(setq initial-buffer-choice nil)
(if (not (null window-system))
    (tool-bar-mode 0))
(menu-bar-mode 0)
(column-number-mode t)
(display-time)
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-margin 3)
(setq scroll-conservatively 10000)

;; Show function name
(which-func-mode t)

;; Key binding stuffs
(define-prefix-command 'find-map)
(define-prefix-command 'tag-map)
(define-prefix-command 'goto-map)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-r") 'revert-buffer)
(global-set-key (kbd "C-M-w") 'kill-sexp)
(global-set-key (kbd "M-W") 'kill-ring-save-sexp)
(global-set-key (kbd "C-=") 'increase-font-size)
(global-set-key (kbd "C--") 'decrease-font-size)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "<f2>") 'undo)
(global-set-key (kbd "<f3>") 'find-map)
(global-set-key (kbd "<f3> t") 'taglist)
(global-set-key (kbd "<f3> g") 'grep)
(global-set-key (kbd "<f3> f") 'occur)
(global-set-key (kbd "<f4>") 'tag-map)
(global-set-key (kbd "<f4> c") 'clear-tag-list)
(global-set-key (kbd "<f4> s") 'select-tag)
(global-set-key (kbd "<f6>") 'goto-map)
(global-set-key (kbd "<f6> l") 'goto-line)
(global-set-key (kbd "<f6> j") 'jump-to-register)
(global-set-key (kbd "<f6> s") 'point-to-register)
(global-set-key (kbd "<f11>") 'org-agenda-list)
(global-set-key (kbd "S-<f11>") 'org-todo-list)
(global-set-key (kbd "C-<f11>") 'org-remember)

;; Dired settings
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-omit-mode 1)
            (setq dired-omit-files "\\.\\(o\\|d\\|opic\\)$")))

;; IBuffer settings
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Program" (or
                     (mode . c-mode)
                     (mode . cc-mode)
                     (mode . makefile-mode)
                     (mode . makefile-gmake-mode)
                     (mode . makefile-automake-mode)
                     (mode . asm-mode)
                     (mode . python-mode)))
         ("Document" (or
                      (mode . org-mode)
                      (mode . latex-mode)))
         ("Patch" (mode . diff-mode))
         ("Elisp" (mode . emacs-lisp-mode))
         ("Dired" (mode . dired-mode))
         ("W3m" (name . "^\\*w3m\\*.*$"))
         ("System" (name . "^\\*.*\\*$"))
         )))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Gtalk
(when (require-maybe 'jabber)
  (setq jabber-account-list
        '(("frankpzh@gmail.com"
           (:network-server . "talk.google.com")
           (:connection-type . ssl))))
  (setq jabber-roster-line-format " %c %-25n %u %-8s  %S"))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((c-set-style . "BSD")))))

(provide 'init)