(global-set-key "\C-h" 'delete-backward-char)

(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(require 'riece)
