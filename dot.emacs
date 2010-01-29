(global-set-key "\C-h" 'delete-backward-char)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(require 'riece)

(define-key ctl-x-map "p"
  #'(lambda (arg)
      (interactive "p")
      (other-window (- arg))))
