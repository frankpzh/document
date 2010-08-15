(defun maximize-emacs-unix nil
  "Maximize emacs when in UNIX-like system."
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                         '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

(add-hook 'window-setup-hook
		  '(lambda nil
			 (if (eq system-type 'windows-nt)
				 (w32-send-sys-command #xf030)
			   (maximize-emacs-unix))) t)

(provide 'maximize-emacs)