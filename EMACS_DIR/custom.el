(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(delete-selection-mode t)
 '(desktop-auto-save-timeout 30)
 '(desktop-load-locked-desktop t)
 '(indent-tabs-mode nil)
 '(java-mode-hook
   (quote
    ((lambda nil
       (set
        (make-local-variable
         (quote compile-command))
        (concat "javac " buffer-file-name))))))
 '(mouse-drag-and-drop-region (quote control))
 '(mouse-drag-copy-region t)
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages (quote (magit)))
 '(recentf-max-menu-items 50)
 '(recentf-max-saved-items 100)
 '(recentf-mode t)
 '(save-place t)
 '(savehist-additional-variables (quote (search-ring regexp-search-ring)))
 '(savehist-mode t)
 '(scroll-bar-mode (quote left))
 '(select-enable-primary t)
 '(show-paren-mode t)
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
