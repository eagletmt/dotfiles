;; configs
(setq initial-major-mode 'lisp-interaction-mode)
(setq inhibit-startup-message t)

; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)

; indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

; backup
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

; show candidates on minibuffer
(iswitchb-mode t)
(iswitchb-default-keybindings)

; hide toolbar and menubar
(tool-bar-mode 0)
(menu-bar-mode 0)

; on GUI
(if window-system
    (progn
      ; colors
      (set-background-color "black")
      (set-foreground-color "lightgray")
      (set-cursor-color "gray")
      (set-frame-parameter nil 'alpha 90)))

;; global keymap
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key [f5] 'twittering-update-status-from-pop-up-buffer)

;; local keymap
(define-key lisp-interaction-mode-map "\C-c" 'eval-print-last-sexp)

(define-key ctl-x-map "p"
  #'(lambda (arg)
      (interactive "p")
      (other-window (- arg))))

(add-hook 'Info-mode-hook
          #'(lambda ()
              (local-set-key "h" 'backward-char)
              (local-set-key "j" 'next-line)
              (local-set-key "k" 'previous-line)
              (local-set-key "l" 'forward-char)
              (local-set-key "g" 'beginning-of-buffer)
              (local-set-key "G" 'end-of-buffer)

              (local-set-key "f" 'Info-scroll-up)
              (local-set-key "b" 'Info-scroll-down)
              (local-set-key "L" 'Info-history-forward)
              (local-set-key "H" 'Info-history-back)
              (local-set-key "y" 'Info-copy-current-node-name)
              (local-set-key "t" 'Info-goto-node)
              (local-set-key "o" 'Info-menu)
              (local-set-key "O" 'Info-follow-reference)
              (local-set-key "/" 'Info-search)))

;; functions
; fullscreen on Carbon Emacs
(defun mac-toggle-max-window ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

;; plugins
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(setq elscreen-prefix-key "\C-a")
(load "elscreen")
(define-key elscreen-map "\C-a" 'move-beginning-of-line)
(define-key elscreen-map "n" 'elscreen-create)
(define-key elscreen-map "h" 'elscreen-previous)
(define-key elscreen-map "l" 'elscreen-next)

(require 'twittering-mode)
(setq twittering-username "eagletmt")

(add-to-list 'load-path (expand-file-name "~/.emacs.d/ddskk"))
(require 'skk-autoloads)
;(require 'skk-hint)
(setq skk-large-jisyo (expand-file-name "~/Library/AquaSKK/SKK-JISYO.L"))
(setq mac-pass-control-to-system nil)
(setq skk-preload t)
(setq-default skk-kutouten-type 'en)
(setq skk-egg-like-newline t)
(setq skk-sticky-key ";")
(setq skk-henkan-strict-okuri-precedence t)

(define-key ctl-x-map "\C-j" 'skk-mode)
(add-hook 'isearch-mode-hook
          #'(lambda ()
              (and (boundp 'skk-mode) skk-mode
                   (skk-isearch-mode-setup))))

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp")

(require 'linum)
(setq linum-format "%3d")
(global-linum-mode t)
(add-hook 'eshell-mode-hook
          #'(lambda ()
              (linum-mode)))

(require 'anything-config)
(global-set-key (kbd "C-;") 'anything)
(define-key anything-map "\C-p" 'anything-previous-line)
(define-key anything-map "\C-n" 'anything-next-line)
(define-key anything-map "\C-v" 'anything-next-page)
(define-key anything-map "\M-v" 'anything-previous-page)

(require 'auto-complete)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map ";" 'ac-complete)
(define-key ac-complete-mode-map "\r" nil)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
(require 'slime)
(add-hook 'lisp-mode-hook
          #'(lambda ()
              (slime-mode t)
              (show-paren-mode)))
(setq inferior-lisp-program "sbcl")
(add-hook 'inferior-lisp-mode-hook
          #'(lambda ()
              (inferior-lisp-mode t)))

