;;; init.el --- Where all the magic begins
;;
;; My personal quirks, encoded as Lisp
;; Thanks to the Emacs Starter Kit

;; Find it!


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-hook 'after-init-hook #'(lambda () (load "~/.emacs.d/lisp/init2.el")))

(provide 'init)
;;; init.el ends here
