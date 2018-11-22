(let ((user-custom-file (expand-file-name "custom.el" user-emacs-directory)))
  (if (not (file-readable-p user-custom-file))
      (message (concat "WARNING: cannot find/read custom file " user-custom-file
                       " - defaulting to " custom-file))
    (setq custom-file user-custom-file)
    (load custom-file)))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; auto-install ...???
;;(require 'auto-install)
;;(auto-install-update-emacswiki-package-name t)

;; direx (using auto-install) ...???
;;(auto-install-from-url "https://raw.github.com/m2ym/direx-el/master/direx.el")

(defun compile-and-load-elisp-srctree (src &optional elc)
  (interactive
   (let* ((src (read-directory-name "Emacs lisp source directory:" nil nil 1))
          (work (file-name-as-directory src))
          elc) ;; init elc to nil
     (while (null elc)
       (let ((read (read-directory-name "Emacs lisp output directory: " work)))
         (if (or (file-directory-p read)
                 (y-or-n-p (concat "Top-level emacs lisp output directory \""
                                   (file-name-as-directory read)
                                   "\" does not exist - create?")))
             (setq elc read)
           (setq work read))))
     (list src elc)))
  (let* ((indir (expand-file-name src))
         (outdir (when elc (file-name-as-directory (expand-file-name elc))))
         (load-path (cl-copy-list load-path))
         elcfiles ;; init elcfiles to nil (empty list)
         (byte-compile-dest-file-function
          (lambda (file)
            (let ((srcdir (file-name-directory file))
                  (elcfile (if (or (null outdir) (file-equal-p indir outdir))
                               (concat (file-name-sans-extension file) ".elc")
                             (let ((elcdir (concat outdir (file-name-directory
                                                           (file-relative-name
                                                            file indir)))))
                               (mkdir elcdir t)
                               (concat elcdir (file-name-base file) ".elc")))))
              (unless (member srcdir load-path) (push srcdir load-path))
              (unless (member elcfile elcfiles) (push elcfile elcfiles))
              elcfile))))
    (byte-recompile-directory indir 0)
    (mapc 'load elcfiles)))

(let* ((user-elisp (expand-file-name "elisp" user-emacs-directory)))
  (if (not (file-accessible-directory-p user-elisp))
      (message (concat "WARNING: user emacs lisp directory " user-elisp
                       " not accessible - skipping user emacs lisp loading"))
    (compile-and-load-elisp-srctree user-elisp)))

;;(message "%s: %s" (current-time-string) "before system type check...")
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

;;(message "%s: %s" (current-time-string) "before first keybinding...")
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
(global-set-key [(meta f5)] 'repeat-matching-complex-command) ;; Redo w/ search
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
(global-set-key "\C-cj" 'direx:find-directory)

(global-set-key "\C-x\C-a" 'save-buffers-kill-emacs)

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

;; Emacs desktop compatibility with daemon mode: load desktop after initial
;; frame is displayed (presumably triggered by client invocation)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (unused-frame-arg)
                (unless desktop-save-mode
                  (desktop-save-mode 1)
                  (desktop-read)))
              t)
  ;;(message "%s: %s" (current-time-string) "starting desktop immediately...")
  (desktop-save-mode 1))
