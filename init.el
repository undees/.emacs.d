;;; init.el --- Where all the magic begins
;;
;; My personal quirks, encoded as Lisp
;; Thanks to the Emacs Starter Kit

;; Find it!

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-hook 'after-init-hook #'(lambda () (load "~/.emacs.d/init2.el")))

(provide 'init)
;;; init.el ends here
