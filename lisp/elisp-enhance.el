(define-key emacs-lisp-mode-map (kbd "<f5>") 'eval-buffer)

(defadvice save-buffer (after compile-elisp-after-save)
  (when (equal major-mode 'emacs-lisp-mode)
    (if (file-exists-p (byte-compile-dest-file (buffer-file-name)))
        (byte-compile-file (buffer-file-name)))))

(ad-activate 'save-buffer)

(provide 'elisp-enhance)
