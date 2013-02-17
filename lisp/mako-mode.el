(defvar mako-mode-hook nil)

(defvar mako-keywords
  (list (list "^[ \t]*\%[ \t]*\\(if\\)" 1 font-lock-keyword-face)
        (list "^[ \t]*\%[ \t]*\\(endif\\)" 1 font-lock-keyword-face)
        (list "^[ \t]*\%[ \t]*\\(for\\)" 1 font-lock-keyword-face)
        (list "^[ \t]*\%[ \t]*\\(endfor\\)" 1 font-lock-keyword-face)
        (list "\\#.*$" 0 font-lock-comment-face)))

(defvar mako-map
  (let ((map (make-sparse-keymap)))
    map))

(defun mako-mode nil
  (interactive)
  (kill-all-local-variables)
  (use-local-map mako-map)
  (setq major-mode 'mako-mode)
  (setq mode-name "Mako")
  (setq font-lock-defaults
        (list 'mako-keywords))
  (run-mode-hooks 'mako-mode-hook))

(add-to-list 'auto-mode-alist '("templates/[^/]*\\.mk$" . mako-mode))

(provide 'mako-mode)
