(defvar select-tag-list
  (list
   (cons ?x "~/xen/xen")
   (cons ?q "~/xen/tools/ioemu-remote")
   (cons ?k "/usr/src/linux")
   (cons ?i "~/igb-mig")
   (cons ?c "~/xen/tools/libxc")
   (cons ?p "~/xen/tools/python")
   (cons ?f "~/xen/tools/firmware")))

(defun select-tag (char)
  (interactive "cTag code:")
  (let ((tag
         (catch 'result
           (let ((list select-tag-list))
             (while (not (null list))
               (if (equal char (caar list))
                   (throw 'result (cdar list)))
               (setq list (cdr list))))
           nil)))
    (if (null tag)
        (message "No such tag code.")
      (progn
        (setq tags-table-list nil)
        (setq tags-file-name tag)
        (message (concat "Tag file set to " tag))))))

(defun clear-tag-list nil
  (interactive)
  (setq tags-file-name nil)
  (setq tags-table-list nil)
  (message "Tag file list has been cleared"))

(defun word-count nil
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun grep-string (str dir)
  (interactive "sString: \nDBase dir: ")
  (shell-command (concat "grep " str " " dir " -rn --include=\"*.[ch]\"")))

(defun kill-ring-save-sexp nil
  (interactive)
  (mark-sexp)
  (kill-ring-save (point) (mark))
  (message (concat "Saved into kill ring: " (buffer-substring (point) (mark)))))


(defun increase-font-size nil
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun decrease-font-size nil
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                (face-attribute 'default :height)))))

(defun dos2unix ()
  "dos2unix on current buffer."
  (interactive)
  (set-buffer-file-coding-system 'unix))

(defun unix2dos ()
  "unix2dos on current buffer."
  (interactive)
  (set-buffer-file-coding-system 'dos))

(provide 'utility)
