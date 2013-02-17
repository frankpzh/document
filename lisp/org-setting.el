(setq org-log-done 'time)
(setq org-hide-leading-stars t)
;; Add TODO keyword
(setq org-todo-keywords '((type "TODO" "HOLD" "|" "DONE")))
(setq org-todo-keyword-faces '(("HOLD" . org-todo)
                               ("TODO" . org-warning)))
;; Set TODO to DONE when all sub-TODOs are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ;; turn off logging
    (if (= n-not-done 0)
        (org-todo "DONE"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
;; Set up org remember for new techs
(org-remember-insinuate)
(setq org-directory "~/public/doc")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(setq org-remember-templates
      '(("Work" ?w "** TODO [#A] %?\n" nil "Work related ideas")
        ("Tech" ?t "** HOLD [#C] %?\n" nil "New Technologies")
        ("Emacs" ?e "** HOLD [#B] %?\n" nil "Emacs")))
;; Add org agenda files
(add-to-list 'org-agenda-files (concat org-directory "/todo.org"))

(defun open-todo-or-quit ()
  (interactive)
  (if (equal
       "/usr/local/google/home/frankpan/public/doc/todo.org"
       (buffer-file-name (current-buffer)))
      (quit-window)
    (find-file org-default-notes-file)))

(global-set-key (kbd "C-c r") 'org-remember)
(global-set-key (kbd "<f11>") 'org-todo-list)
(global-set-key (kbd "C-M-a") 'open-todo-or-quit)
(global-set-key (kbd "C-<f11>") 'org-remember)

(provide 'org-setting)
