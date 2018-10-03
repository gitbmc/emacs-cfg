(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-save-mode t)
 '(grep-find-command
   (quote
    ("\"C:/Program Files/Git/usr/bin/find\" . -type f -exec grep -nH  {} +" . 62)))
 '(indent-tabs-mode nil)
 '(inhibit-startup-echo-area-message "ebrumcl")
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(ispell-program-name "C:\\sw\\cygwin\\usr\\bin\\aspell")
 '(java-mode-hook
   (quote
    ((lambda nil
       (set
        (make-local-variable
         (quote compile-command))
        (concat "javac " buffer-file-name))))))
 '(mouse-drag-copy-region t)
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages (quote (direx)))
 '(recentf-max-menu-items 50)
 '(recentf-max-saved-items 50)
 '(recentf-mode t)
 '(save-place t nil (saveplace))
 '(server-window (quote switch-to-buffer-other-frame))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
