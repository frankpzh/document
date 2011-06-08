(defmacro require-maybe (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(let ((require-result (require ,feature ,file 'noerror)))
     (with-current-buffer (get-buffer-create "*Startup Log*")
       (let* ((startup-log-format-string-prefix "%-20s--------[")
              (startup-log-format-string-postfix "%s")
              (startup-status (if require-result "LOADED" "FAILED"))
              (startup-status-face `(face (:foreground
                                           ,(if require-result "green" "red")))))
         (insert (format startup-log-format-string-prefix ,feature))
         (let ((start-pos (point)))
           (insert (format startup-log-format-string-postfix startup-status))
           (add-text-properties start-pos (point) startup-status-face)
           (insert "]\n"))))
     require-result))
(defmacro when-available (func foo)
  "*Do something if FUNCTION is available."
  `(when (fboundp ,func) ,foo))

(provide 'require-maybe)