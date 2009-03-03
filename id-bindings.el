;;; id-bindings.el --- Things that don't fit anywhere else
;;
;; Thanks to the Emacs Starter Kit

;; Because they're under my fingers
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(defalias 'qrr 'query-replace-regexp)

;; A "bettah meta", Yegge-style
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-unset-key "\C-xm") ;; keyboards are unreliable

;; nXML tag completion
(add-hook 'nxml-mode-hook
	  (lambda ()
	    (define-key nxml-mode-map
	       "\C-c\C-c"
	       'nxml-complete)))

;; Jump around windows
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key "\C-x\C-i" 'ido-imenu)

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(defun regen-autoloads (&optional force-regen)
  "Regenerate the autoload definitions file if necessary and load it."
  (interactive "P")
  (let ((autoload-dir (concat dotfiles-dir "/vendor"))
        (generated-autoload-file autoload-file))
    (when (or force-regen
              (not (file-exists-p autoload-file))
              (some (lambda (f) (file-newer-than-file-p f autoload-file))
                    (directory-files autoload-dir t "\\.el$")))
      (message "Updating autoloads...")
      (update-directory-autoloads autoload-dir)))
  (load autoload-file))

(provide 'id-bindings)
;;; id-bindings.el ends here
