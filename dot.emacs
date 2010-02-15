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

;; fullscreen Carbon Emacs
(when (eq window-system 'mac)
  (add-hook 'window-setup-hook
	    (lambda ()
	      (set-frame-parameter nil 'fullscreen 'fullboth))))

(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

;; color
(if window-system
    (progn
      (set-background-color "black")
      (set-foreground-color "lightgray")
      (set-cursor-color "gray")
      (set-frame-parameter nil 'alpha 90)))

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2 indent-tabs-mode nil)
(global-set-key "\C-m" 'newline-and-indent)

