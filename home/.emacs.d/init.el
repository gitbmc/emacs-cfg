;; commented-out 2018-10-03: maybe without a "~/.emacs" file, this isn't needed
;; (let ((user-custom-file (convert-standard-filename
;;                          (concat user-emacs-directory "custom.el"))))
;;   (if (not (file-exists-p user-custom-file))
;;       (message (concat "WARNING: custom file " user-custom-file 
;;                        " does not exist - defaulting to " custom-file))
;;          (setq custom-file user-custom-file)
;;          (load custom-file)))

;; TODO use this function properly, as per https://www.emacswiki.org/emacs/LoadPath; i.e., call repeatedly setting default-directory to the directories listed below each time [updated 2018-10-03: change .emacs.d/lisp to .emacs.d/elisp, and removed "homedir-rooted" elisp/emacs-lisp dirs]

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(normal-top-level-add-to-load-path '(".emacs.d/elisp"))

(load-library "xemacs-ported")
(load-library "command")

;; auto-install ...???
;;(require 'auto-install)
;;(auto-install-update-emacswiki-package-name t)

;; direx (using auto-install) ...???
;;(auto-install-from-url "https://raw.github.com/m2ym/direx-el/master/direx.el")
(require 'direx-project)

(when (memq system-type '(ms-dos windows-nt))
  (global-set-key [(mouse-2)] 'mouse-yank-at-click)) ;; no primary selection...

;; ensure find-grep command uses "-exec grep {} +": the check to determine
;; which command format to use in grep-compute-defaults currently passes NUL
;; instead of /dev/null as per default value for global-null, and find in Git
;; Bash does not recognize NUL - as of 2.7.2 or possibly much earlier - so it
;; comes up with the "wrong" answer - when this bug gets fixed in a future
;; release of Emacs then this simply becomes superfluous and could be removed

;; commented-out 2018-10-24: with WSL this shouldn't be needed...?
;;(setq-default grep-find-use-xargs 'exec-plus)

(global-set-key [(control meta escape)] 'keyboard-escape-quit)
(define-key isearch-mode-map [(control meta escape)] 'isearch-cancel)

(global-set-key [(control shift a)] 'mark-whole-buffer)
(global-set-key [(control shift s)] 'save-buffer)

(global-set-key [(control z)] 'undo)
(global-set-key [(control shift z)] 'suspend-frame)

(global-set-key [(control meta shift x)] 'exchange-point-and-mark)

(global-set-key [(meta f4)] 'kill-buffer-and-frame)
(global-set-key [(control f4)] 'kill-this-buffer)
(global-set-key [(control shift f4)] 'kill-buffer-and-window)
(global-set-key [(control shift meta f4)] 'save-buffers-kill-terminal);; C-x C-c

(global-set-key [f5] 'repeat-complex-command) ;; Redo w/ history
(global-set-key [(control f5)] 'repeat) ;; Repeat last command
(global-set-key [(shift f5)] 'call-last-kbd-macro) ;; Repeat keyboard macro
(global-set-key [f6] 'switch-to-other-buffer) ;; from XEmacs

(global-set-key [f7] 'other-window)
(global-set-key [f8] 'emacs-lisp-byte-compile-and-load)
(global-set-key [f9] 'find-grep)

(global-set-key [f10] 'ispell-buffer)

(global-set-key [(f11)] 'delete-other-windows)
(global-set-key [(meta f11)] 'kill-other-window-and-buffer)
(global-set-key [(shift f11)] 'kill-other-previous-window-and-buffer)
(global-set-key [(control f11)] 'kill-buffer-and-window)

(global-set-key [f12] 'kill-buffer-and-frame-or-window)
(global-set-key [(meta f12)] 'delete-frame)
(global-set-key [(control f12)] 'delete-window)
(global-set-key [(shift f12)] 'server-edit) ;; C-x #
(global-set-key [(control meta f12)] 'save-buffers-kill-terminal) ;; C-x C-c

(global-set-key [(control tab)] 'next-buffer)
(global-set-key [(control shift tab)] 'previous-buffer)
(global-set-key [(control \`)] 'other-window)
(global-set-key [(control \~)] 'other-previous-window) ;; negated count arg.

(global-set-key "\C-cc" 'comment-region) ;; should be keymap-specific
(global-set-key "\C-cm" 'compile) ;; ...and, similar to above, should look at
(global-set-key "\C-cv" 'recompile) ;; http://www.emacswiki.org/emacs/SmartCompile
(global-set-key "\C-xj" 'direx:jump-to-directory)

;; Magit customizations
(require 'magit)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

(setq magit-view-git-manual-method 'man)

(magit-define-popup-action 'magit-file-popup
			   ?R "Rename file" 'magit-file-rename)
(magit-define-popup-action 'magit-file-popup
			   ?K "Delete file" 'magit-file-delete)
(magit-define-popup-action 'magit-file-popup
			   ?U "Untrack file" 'magit-file-untrack)
(magit-define-popup-action 'magit-file-popup
			   ?C "Checkout file" 'magit-file-checkout)

(setq vc-handled-backends (delq 'Git vc-handled-backends)) ;; not just for Magit

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers-type nil)
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages (quote (magit)))
 '(scroll-bar-mode (quote left))
 '(size-indication-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
