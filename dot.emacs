(global-set-key "\C-h" 'delete-backward-char)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(require 'riece)

;; elscreen
(setq elscreen-prefix-key "\C-z")
(load "elscreen")
(define-key elscreen-map "\C-h" 'elscreen-prev)
(define-key elscreen-map "\C-l" 'elscreen-next)

(define-key ctl-x-map "p"
  #'(lambda (arg)
      (interactive "p")
      (other-window (- arg))))
