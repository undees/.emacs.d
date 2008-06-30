;;;; My personal quirks, encoded as Lisp

(add-to-list 'load-path "~/.emacs.d")

;;;; OS/Emacs sniffing

(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar aquamacs-p (featurep 'aquamacs))

;;;; Cosmetics

;; More real estate up top...
(tool-bar-mode -1)

;; ... and less on the side (line numbers)
(require 'linum)
(linum-mode)

;; Making purty colors load properly in all Emacsen
(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(setq color-theme-load-all-themes nil)
(setq color-theme-is-global t)
(eval-after-load "color-theme" (color-theme-initialize))
(color-theme-clarity)

;;;; General text editing

;; So I can see what I'm highlighting
(transient-mark-mode)

;; Because they're under my fingers
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c/" 'comment-or-uncomment-region)

;; Auto-completion of file/buffer names
(require 'ido)
(ido-mode t)

;; Note-taking and such
(setq load-path (cons "~/.emacs.d/org/lisp" load-path))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;;; Fancy features for when we're not in the terminal
(when window-system
  ;;;; Allow emacsclient to connect to us
  (server-start)

  ;;;; Specific languages
  (add-to-list 'load-path "~/.emacs.d/ruby")
  (add-to-list 'load-path "~/.emacs.d/rails")
  (require 'rails)

  (add-to-list 'load-path "~/.emacs.d/yaml")
  (require 'yaml-mode)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

  ;;;; Emacs Code Browser
  (load-file "~/.emacs.d/cedet/common/cedet.el")
  (add-to-list 'load-path "~/.emacs.d/ecb")
  (require 'ecb)

  ;;;; Duct tape for various platforms
  (when macosx-p
    (setq ecb-source-path (quote ("~/src")))
    (when (not aquamacs-p)
      (setq mac-option-modifier 'meta)
      (setq mac-command-modifier nil)))
  (when mswindows-p
    (setq ecb-source-path (quote ("e:/src")))
    (setq rails-ruby-command "c:/ruby/bin/ruby.exe")
    (setq exec-path (cons "e:/bin" exec-path))
    (setq shell-file-name "bash")
    (setenv "SHELL" shell-file-name)
    (setenv "PATH" (concat "e:/bin;" (getenv "PATH")))
    (setq explicit-shell-file-name shell-file-name)
    (add-hook 'comint-output-filter-functions
              'comint-strip-ctrl-m)))

;;;; The rest

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-tar-setup (quote cons))
 '(ecb-tip-of-the-day nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
