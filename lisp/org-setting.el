;; Settings
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
(setq org-directory "~/document/docs")
(setq org-default-notes-file "~/document/docs/todo.org")
(define-key global-map "\C-cr" 'org-remember)
(setq org-remember-templates
      '(("Tech" ?t "** HOLD [#C] %?\n" nil "New Technologies")
        ("Piece" ?p "** TODO [#A] %?\n" nil "Pieces")
        ("Emacs" ?e "** HOLD [#B] %?\n" nil "Emacs")
        ("Vocabulary" ?v "** %?\n" "voc.org" "Vocabulary Collection")))
;; Add org agenda files
(add-to-list 'org-agenda-files "~/document/docs/todo.org")

(provide 'org-setting)