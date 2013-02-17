;; IBuffer settings
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Setting" (or
                     (mode . emacs-lisp-mode)
                     (filename . "\\.config/awesome/rc\\.lua$")
                     (filename . "\\.mk\\.sh$")
                     (filename . "\\.bashrc$")
                     (filename . "\\.zshrc$")
                     (filename . "\\.blazerc$")))
         ("Meta-file" (or
                     (mode . makefile-mode)
                     (mode . makefile-gmake-mode)
                     (mode . makefile-automake-mode)
                     (mode . protobuf-mode)
                     (mode . yaml-mode)
                     (mode . google3-build-mode)
                     (filename . "\\.mk$")
                     (filename . "\\.borg$")
                     (filename . "\\.proto$")
                     (filename . "BUILD$")))
         ("Program" (or
                     (mode . c-mode)
                     (mode . c++-mode)
                     (mode . asm-mode)
                     (mode . python-mode)
                     (mode . awk-mode)
                     (mode . sh-mode)
                     (mode . js-mode)
                     (mode . java-mode)
                     (mode . lua-mode)))
         ("Document" (or
                      (mode . org-mode)
                      (mode . latex-mode)
                      (mode . bibtex-mode)
                      (mode . doctex-mode)
                      (mode . html-mode)
                      (mode . css-mode)
                      (mode . text-mode)
                      (mode . csv-mode)
                      (mode . markdown-mode)))
         ("Patch" (mode . diff-mode))
         ("Dired" (mode . dired-mode))
         ("System" (name . "^\\*.*\\*$"))
         )))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")

            ;; Use human readable Size column instead of original one
            (define-ibuffer-column size-h
              (:name "Size" :inline t)
              (cond
               ((> (buffer-size) 1024) (format "%7.1fk" (/ (buffer-size) 1024.0)))
               ((> (buffer-size) 1048576) (format "%7.1fM" (/ (buffer-size) 1048576.0)))
               (t (format "%8d" (buffer-size)))))

            ;; Modify the default ibuffer-formats
            (setq ibuffer-formats
                  '((mark modified read-only " "
                          (name 18 18 :left :elide)
                          " "
                          (size-h 9 -1 :right)
                          " "
                          (mode 16 16 :left :elide)
                          " "
                          filename-and-process)))))

(provide 'ibuffer-setting)
