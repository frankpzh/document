#!/usr/bin/emacs --script

(condition-case nil
    (progn
      ; These are for Orgmode 7
      (require 'org-latex)
      (require 'org-special-blocks)
      (setq org-export-latex-default-packages-alist nil))
  (error
   ; Fall back to Orgmode 6
   (require 'org-export-latex)))

(add-to-list 'org-export-latex-classes
             '("usenix"
               "\\documentclass[finalversion,endnotes]{usetex-v1}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-export-latex-classes
             '("sigplan"
               "\\documentclass{sigplanconf}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-export-latex-classes
             '("ieee"
               "\\documentclass[conference]{IEEEtran}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
(add-to-list 'org-export-latex-inline-image-extensions
             "eps")

(setq org-file (pop argv))
(find-file org-file)
(org-export-as-latex 5)
