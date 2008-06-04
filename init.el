(add-to-list 'load-path "~/.emacs.d")

(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar aquamacs-p (featurep 'aquamacs))

(tool-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(setq color-theme-load-all-themes nil)
(setq color-theme-is-global t)
(if (not aquamacs-p) (color-theme-initialize))
(color-theme-clarity)

(require 'linum)
(linum-mode)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

(require 'ido)
(ido-mode t)

(load-file "~/.emacs.d/cedet/common/cedet.el")

(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
'(ecb-source-path (quote ("~/src")))

(add-to-list 'load-path "~/.emacs.d/ruby")

(add-to-list 'load-path "~/.emacs.d/rails")
(require 'rails)

(when (and macosx-p (not aquamacs-p))
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier nil))

(when mswindows-p
  (setq exec-path (cons "C:/cygwin/bin" exec-path))
  (setq shell-file-name "bash")
  (setenv "SHELL" shell-file-name)
  (setq explicit-shell-file-name shell-file-name)
  (add-hook 'comint-output-filter-functions
            'comint-strip-ctrl-m))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(ecb-source-path (quote ("~/src")))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-tip-of-the-day nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
