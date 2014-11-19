;;; id-misc.el --- Things that don't fit anywhere else
;;
;; Thanks to the Emacs Starter Kit

;; Put backup files somewhere sensible
;; http://amitp.blogspot.com/2007/03/emacs-move-autosave-and-backup-files.html
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; Hooks
(add-hook 'find-file-hook 'id-choose-header-mode)
(add-hook 'ruby-mode-hook 'coding-hook)
(add-hook 'c-mode-common-hook 'coding-hook)
(add-hook 'objc-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 4)))


;; Purty colors
(when window-system
  (require 'color-theme)
  (require 'color-theme-blackboard)
  (setq color-theme-is-global t)
  (color-theme-blackboard))

;; Tired of typing "yes" and "no" all the time
(defalias 'yes-or-no-p 'y-or-n-p)

;; Remember recent files
(recentf-mode 1)

;; Handle whitespace sanely
(require 'whitespace)
(setq-default show-trailing-whitespace t)

(provide 'id-misc)
;;; id-misc.el ends here
