;; START ...lifted from XEmacs...
;;(Init-safe-require 'xemacs-ported)
;;(load-library "xemacs-ported")
(or (fboundp 'switch-to-other-buffer)
(defun switch-to-other-buffer (arg)
  "Switch to the previous buffer.  With a numeric arg, n, switch to the nth
most recent buffer.  With an arg of 0, buries the current buffer at the
bottom of the buffer stack."
  (interactive "p")
  (if (eq arg 0)
      (bury-buffer (current-buffer)))
  (switch-to-buffer
   (if (<= arg 1) (other-buffer (current-buffer))
     (nth (1+ arg) (buffer-list))))))
