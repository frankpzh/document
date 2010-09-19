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
      (setq tags-file-name tag))))

(defun word-count nil
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun grep-string (str dir)
  (interactive "sString: \nDBase dir: ")
  (shell-command (concat "grep " str " " dir " -rn --include=\"*.[ch]\"")))

(provide 'utility)