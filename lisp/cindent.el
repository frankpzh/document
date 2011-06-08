;; CC mode settings
(defun tab-kernel nil
  (interactive)
  (setq tab-width 8)
  (setq-default c-basic-offset 8)
  (setq indent-tabs-mode t))

(defun tab-4 nil
  (interactive)
  (setq tab-width 4)
  (setq-default c-basic-offset 4)
  (setq indent-tabs-mode nil))

(setq-default tab-width 8)
(setq-default indent-tabs-mode nil)

;; Create my personal style.
(defconst frankpzh-c-style
  '((c-tab-always-indent        . t)
    (c-hanging-braces-alist     . ((brace-list-open)
                                   (brace-entry-open)
                                   (statement-cont)
                                   (substatement-open after)
                                   (block-close . c-snug-do-while)
                                   (extern-lang-open after)
                                   (namespace-open after)
                                   (module-open after)
                                   (composition-open after)
                                   (inexpr-class-open after)
                                   (inexpr-class-close before)
                                   (defun-open after)))
    (c-cleanup-list             . (brace-else-brace
                                   brace-elseif-brace
                                   brace-catch-brace
                                   defun-close-semi))
    (c-offsets-alist            . ((substatement-open . 0))))
  "Frank Pan's C Programming Style")
(c-add-style "frankpzh" frankpzh-c-style)
(setq c-default-style
      '((java-mode . "java") (awk-mode . "awk") (other . "frankpzh")))

(add-hook 'c-initialization-hook
          '(lambda nil
             (define-key c-mode-base-map "\C-m" 'c-context-line-break)
             (setq-default c-basic-offset 4)))

(add-hook 'c-mode-common-hook
          '(lambda nil
             (c-toggle-hungry-state)))

(provide 'cindent)
