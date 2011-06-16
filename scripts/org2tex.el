#!/usr/bin/emacs --script

(require 'org-export-latex)
(add-to-list 'org-export-latex-classes
             '("usenix"
               "\\documentclass[finalversion,endnotes]{usetex-v1}
\\usepackage{epsfig}
\\usepackage{url}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-export-latex-inline-image-extensions
             "eps")

(setq org-file (pop argv))
(find-file org-file)
(org-export-as-latex 3)
