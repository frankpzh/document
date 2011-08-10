(defconst project-hook-file ".project.hook")

(defun project-upper-directory (directory)
  (file-name-directory
   (directory-file-name directory)))

(defun project-find (file)
  (let ((upper (project-upper-directory file))
        (found nil)
        (hook nil))
    (while (and (not found)
               (not (equal file upper)))
      (setq hook (concat upper project-hook-file))
      (setq file upper)
      (setq upper (project-upper-directory file))
      (if (file-exists-p hook)
          (setq found t)))
    (if found
        file
      nil)))

(defun project-find-hook (file)
  (let ((project (project-find file)))
    (if project
        (concat project project-hook-file)
      nil)))

(defun project-call-hook nil
  (let* ((file (buffer-file-name))
         (fdir (expand-file-name file))
         (project-hook (project-find-hook file)))
    (when project-hook
      (load project-hook))))

(add-hook 'c-mode-common-hook
          'project-call-hook)

(defun project-find-tag (file)
  (let ((project (project-find file)))
    (when project
      (concat project "TAGS"))))

(defun project-default-tag nil
  (if (buffer-file-name)
      (let ((tag-file (project-find-tag (buffer-file-name))))
        (unless (equal tags-file-name tag-file)
          (setq tags-file-name nil)
          (setq tags-table-list nil))
        tag-file)
    nil))

(setq default-tags-table-function
      'project-default-tag)

(defun project-tag-p (tag-file)
  (equal tag-file (project-find-tag tag-file)))

(defconst project-etags-temp-buffer "*Find-result*")

(defun project-call-find (dir-list out-buffer)
  (let ((arg-list '("-name" "*.[chS]")))
    (apply 'call-process
           "find"
           nil
           out-buffer
           nil
           (append dir-list arg-list))))

(defun project-make-tag (tag-file)
  (let ((project (project-find tag-file)))
    (message "Generating tags file...")
    (if (get-buffer project-etags-temp-buffer)
        (kill-buffer project-etags-temp-buffer))
    (with-current-buffer
        (get-buffer-create project-etags-temp-buffer)
      (setq default-directory project)
      (project-call-find '() (current-buffer))
      (call-process-region (point-min)
                           (point-max)
                           "etags"
                           nil
                           nil
                           nil
                           "-")
      (kill-buffer project-etags-temp-buffer))))

(defadvice tags-verify-table (before check-and-make-tag)
  (let ((tag-file (ad-get-arg 0)))
    (when (and (not (file-exists-p tag-file))
               (project-tag-p tag-file))
      (project-make-tag tag-file))))

(ad-activate 'tags-verify-table)

(provide 'project)
