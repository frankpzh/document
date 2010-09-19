(defvar select-tag-list
  ((?x "~/xen/xen")
   (?q "~/xen/tools/ioemu-remote")
   (?k "/usr/src/linux")
   (?i "~/igb-mig")
   (?c "~/xen/tools/libxc")
   (?p "~/xen/tools/python")))

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

(provide 'utility)