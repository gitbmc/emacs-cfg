;; "command" function definitions; e.g. simple function forms to convert
;; "non-command" zero-arg functions to commands that can then be bound to keys

(defun other-previous-window (count &optional all-frames)
  "Same as other-window, but goes backwards by negating count argument."
  (interactive "p")
  (other-window (- count) all-frames))

(defun kill-other-window-and-buffer (count &optional all-frames)
  "Kill buffer and window specified by other-window if more than
1 window as specified by count-windows (otherwise display a
message and exit doing nothing)."
  (interactive "p")
  (if (eq (count-windows) 1)
      (message "No other windows.")
    (other-window count all-frames)
    (kill-buffer-and-window)))

(defun kill-other-previous-window-and-buffer (count &optional all-frames)
  "Same as kill-other-window-and-buffer, but goes backwards by
negating count argument."
  (interactive "p")
  (kill-other-window-and-buffer (- count) all-frames))

(defun kill-buffer-and-frame (&optional arg)
  "If this is a server buffer, call server-edit with specified
optional argument and then kill the current frame, else kill
buffer and the containing frame."
  (interactive "P")
  (if (null server-buffer-clients)
      (if (kill-buffer) (delete-frame))
    (server-edit arg)
    (unless server-buffer-clients (delete-frame))))

(defun kill-buffer-and-frame-or-window (&optional arg)
  "If this is a server buffer, call server-edit with specified
optional argument and then kill the current frame (if server is
configured to always open a new frame for each client invocation),
else kill buffer and the containing window (or frame if only one
window exists in the current frame)."
  (interactive "P")
  (if (null server-buffer-clients)
      (if (> (count-windows) 1)
          (kill-buffer-and-window)
        (if (and (kill-buffer)
                 (> (safe-length (visible-frame-list)) 1)) ;; may need something better than visible-frame-alist...
            (delete-frame)))
    (server-edit arg)
    (unless server-buffer-clients
      ;; (message "server-window: %s" server-window)
      ;; (message "visible-frame-list: %s" (visible-frame-list))
      ;; (message "whole and condition: %s" (and (eq server-window 'switch-to-buffer-other-frame)
      ;;                                         (> (safe-length (visible-frame-list)) 1)))
      (if (eq server-window 'switch-to-buffer-other-frame)
          (delete-frame)))))
