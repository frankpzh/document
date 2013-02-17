;; Shell color settings

; Color theme from Gnome Terminal
;(setq ansi-color-names-vector-foreground
;      ["#4C4C4C" "#FF0000" "#00FF00" "#FFFF00"
;       "#4682B4" "#FF00FF" "#00FFFF" "#FFFFFF"])
;(setq ansi-color-names-vector-background
;      ["#000000" "#CD0000" "#00CD00" "#CDCD00"
;       "#1E90FF" "#CD00CD" "#00CDCD" "#E5E5E5"])

; Color theme from Solarized
(setq ansi-color-names-vector-foreground
      ["#073642" "#DC322F" "#48A800" "#B58900"
       "#268BD2" "#D33682" "#2AA198" "#EEE8D5"])
(setq ansi-color-names-vector-background
      ["#002b36" "#CB4B16" "#586E75" "#657B83"
       "#839496" "#6C71C4" "#93A1A1" "#FDF6E3"])

(defun ansi-color-make-color-map-customized ()
  (let ((ansi-color-map (make-vector 50 nil))
        (index 0))
    ;; miscellaneous attributes
    (mapc
     (function (lambda (e)
                 (aset ansi-color-map index e)
                 (setq index (1+ index)) ))
     ansi-color-faces-vector)
    ;; foreground attributes
    (setq index 30)
    (mapc
     (function (lambda (e)
                 (aset ansi-color-map index
		       (ansi-color-make-face 'foreground e))
                 (setq index (1+ index)) ))
     ansi-color-names-vector-foreground)
    ;; background attributes
    (setq index 40)
    (mapc
     (function (lambda (e)
                 (aset ansi-color-map index
		       (ansi-color-make-face 'background e))
                 (setq index (1+ index)) ))
     ansi-color-names-vector-background)
    ansi-color-map))

(add-hook 'shell-mode-hook
          '(lambda ()
             (ansi-color-for-comint-mode-on)
             (setq ansi-color-map (ansi-color-make-color-map-customized))))

(setq shell-font-lock-keywords
      '(("^\\*\\*\\* output flushed \\*\\*\\*$" . font-lock-comment-face)
        ("^frankpan@Google:\\(.*\\)\\(:P\\) ([0-9]*) " 
         (1 'font-lock-reference-face)
         (2 'green))
        ("^frankpan@Google:\\(.*\\)\\(:(\\) ([0-9]*) " 
         (1 'font-lock-reference-face)
         (2 'red))))

;; Bash completion
(when (require-maybe 'bash-completion)
  (bash-completion-setup))

(defun shell-or-quit (arg)
  (interactive "P")
  (let* ((index (prefix-numeric-value arg))
         (bname (format "*shell-%d*" index)))
    (if (string-match "\\*shell-[0-9]*\\*"
                      (buffer-name (current-buffer)))
        (quit-window)
      (shell bname)
      (delete-other-windows))))

(defun filter (lst condp)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x))
                lst)))

(defun next-shell nil
  (interactive)
  (let* ((shell-bufferp
          (lambda (buffer)
            (string-match "\\*shell-[0-9]*\\*"
                          (buffer-name buffer))))
         (shell-buffer-list
          (filter (buffer-list) shell-bufferp))
         (buffer-name-lessp
          (lambda (buffer1 buffer2)
            (string-lessp
             (buffer-name buffer1)
             (buffer-name buffer2))))
         (sorted-list
          (sort shell-buffer-list buffer-name-lessp))
         (next-buffer (car sorted-list)))
    (while sorted-list
      (when (equal (car sorted-list) (current-buffer))
        (when (cdr sorted-list)
          (setq next-buffer (car (cdr sorted-list)))))
      (setq sorted-list (cdr sorted-list)))
    (bury-buffer (current-buffer))
    (switch-to-buffer next-buffer)))

(global-set-key (kbd "C-M-z") 'shell-or-quit)
(global-set-key (kbd "C-M-x") 'next-shell)

;; Track pwd using regex
(setq dirtrack-list '("^frankpan@Google:\\([^:]*\\):" 1 nil))

;; Disable default pwd track
(add-hook 'shell-mode-hook
          '(lambda ()
              (dirtrack-mode 1)))

(provide 'shell-setting)
