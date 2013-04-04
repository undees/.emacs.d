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
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'cl)
(require 'recentf)

;; Auto-completion of file/buffer names
(require 'ido)
(ido-mode t)

;; Install a few packages on first launch; see
;; http://stackoverflow.com/questions/10092322/
;; how-to-automatically-install-emacs-packages-
;; by-specifying-a-list-of-package-name
(defvar auto-install-packages (list
                               'color-theme-blackboard
                               'inf-ruby
                               'markdown-mode
                               'ruby-mode
                               'ruby-electric
                               'ruby-compilation
                               'textmate
                               'whitespace
                               'yaml-mode
                               'yasnippet)
  "Libraries that should be installed by default.")

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(mapc
 (lambda (package)
   (when (not (require package nil t))
     (package-install package)))
 auto-install-packages)

;; Continue with the rest of the initialization,
;; now that all the libraries are ready

(require 'id-defuns)
(require 'id-bindings)
(require 'id-misc)

(regen-autoloads)
(load custom-file 'noerror)

;; More real estate up top...
(tool-bar-mode -1)
(if (not (eq system-type 'darwin))
    (menu-bar-mode -1)
)

;; Sensible tabs
(setq-default indent-tabs-mode nil)
(setq c-default-style "stroustrup"
      c-basic-offset 4)

;;;; General text editing

;; So I can see what I'm highlighting
(setq-default transient-mark-mode t)

;; Handy shortcuts
(textmate-mode t)

;; Column numbers
(column-number-mode t)

;;;; Fancy features for when we're not in the terminal
(when window-system
  ;;;; Allow emacsclient to connect to us
  (server-start)

  ;;;; Specific languages
  (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))
  (add-to-list 'auto-mode-alist '("\\.pro$" . makefile-mode))
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

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
        (push '("Gemfile$" flymake-ruby-init) flymake-allowed-file-name-masks)

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

(provide 'init2)
;;; init2.el ends here
