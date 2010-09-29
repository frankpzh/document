(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme")
(require 'dired-x)
(require 'maximize-emacs)
(require 'utility)
(require 'taglist)

;; Desktop save
(require 'desktop)
(desktop-save-mode 1)

;; Font/color stuffs
(require 'color-theme)
(color-theme-initialize)
(if (not (null window-system))
    (color-theme-blackboard))
(if (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :family "Consolas")
  (set-face-attribute 'default nil :family "Terminus"))

;; Set window transparent
(add-to-list 'default-frame-alist (cons 'alpha 90))
(setq-default make-backup-files nil)
(setq initial-buffer-choice nil)
(tool-bar-mode -1)
(column-number-mode t)
(display-time)
(fset 'yes-or-no-p 'y-or-n-p)
(setq scroll-margin 3)
(setq scroll-conservatively 10000)

;; Tab stuffs
(defun tab-8 nil
  (interactive)
  (setq tab-width 8)
  (setq indent-tabs-mode t))
(defun tab-4 nil
  (interactive)
  (setq tab-width 4)
  (setq indent-tabs-mode nil))
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(require 'cc-mode)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; Show function name
(which-func-mode t)

;; Key binding stuffs
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-r") 'revert-buffer)
(global-set-key (kbd "<f3>") 'taglist)
(global-set-key (kbd "<f4>") 'select-tag)
(global-set-key (kbd "C-<f4>") 'clear-tag-list)
(global-set-key (kbd "<f6>") 'goto-line)
(global-set-key (kbd "<f11>") 'bookmark-bmenu-list)
(global-set-key (kbd "C-<f11>") 'bookmark-set)
(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buffer)

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
         ("Patch" (mode . diff-mode))
         ("Elisp" (mode . emacs-lisp-mode))
         ("Dired" (mode . dired-mode))
         ("W3m" (name . "^\\*w3m\\*.*$"))
         ("System" (name . "^\\*.*\\*$"))
         )))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((c-set-style . "BSD")))))
