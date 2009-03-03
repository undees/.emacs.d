;;; init.el --- Where all the magic begins
;;
;; My personal quirks, encoded as Lisp
;; Thanks to the Emacs Starter Kit

;; Find it!

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "vendor"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'cl)
(require 'recentf)
(require 'package)
(package-initialize)

(require 'id-defuns)
(require 'id-bindings)
(require 'id-misc)

;; (regen-autoloads)
(load custom-file 'noerror)

; Snippets
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "/vendor/snippets"))

;; More real estate up top...
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Sensible tabs
(setq-default indent-tabs-mode nil)

;;;; General text editing

;; So I can see what I'm highlighting
(transient-mark-mode)

;; Auto-completion of file/buffer names
(require 'ido)
(ido-mode t)

;;;; Fancy features for when we're not in the terminal
(when window-system
  ;;;; Allow emacsclient to connect to us
  (server-start)

  ;;;; Specific languages
  (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

  (eval-after-load 'ruby-mode
    '(progn
       (require 'ruby-compilation)
       (setq ruby-use-encoding-map nil)
       (add-hook 'ruby-mode-hook 'inf-ruby-keys)
       (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)))

   ;;; Flymake

   (eval-after-load 'ruby-mode
     '(progn
        (require 'flymake)

        ;; Invoke ruby with '-c' to get syntax checking
        (defun flymake-ruby-init ()
          (let* ((temp-file (flymake-init-create-temp-buffer-copy
                             'flymake-create-temp-inplace))
                 (local-file (file-relative-name
                              temp-file
                              (file-name-directory buffer-file-name))))
            (list "ruby" (list "-c" local-file))))

        (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
        (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

        (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
              flymake-err-line-patterns)

        (add-hook 'ruby-mode-hook
                  (lambda ()
                    (when (and buffer-file-name
                               (file-writable-p
                                (file-name-directory buffer-file-name))
                               (file-writable-p buffer-file-name))
                      (local-set-key (kbd "C-c d")
                                     'flymake-display-err-menu-for-current-line)
                      (flymake-mode t)))))))

(setq system-specific-config (concat dotfiles-dir "local/" system-name ".el")
      user-specific-config (concat dotfiles-dir "local/" user-login-name ".el"))

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))

(provide 'init)
;;; init.el ends here
