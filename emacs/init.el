;; package setup
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "http://mirrors.163.com/elpa/gnu/")
			 ("melpa" . "https://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))
(setq use-package-always-ensure t)

;; benchmark startup
(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
(add-hook 'after-init-hook
	  (lambda () (message "loaded in %s" (emacs-init-time))))

;; autosave on lose focus
(add-function :after after-focus-change-function
	      (lambda () (save-some-buffers t)))

;; minimal look
(setq inhibit-startup-screen t)
(defun display-startup-echo-area-message ()
  (message nil))
(tool-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
; hide minor modes from modeline
(setq mode-line-modes
      (mapcar (lambda (elem)
		(pcase elem
                  (`(:propertize (,_ minor-mode-alist . ,_) . ,_)
                   "")
                  (_ elem)))
              mode-line-modes))

;; wrap lines
(global-visual-line-mode 1)

;; font
(set-frame-font "IBM Plex Mono 10" nil t)

;; remember cursor position
(save-place-mode 1)

;; delete backup files on save
(setq delete-auto-save-files t)

;; theme
(use-package modus-themes
  :init
  ;; Load the theme files before enabling a theme
  (modus-themes-load-themes)
  :config
  (modus-themes-load-vivendi) ;; OR (modus-themes-load-operandi)
  :bind ("<f5>" . modus-themes-toggle))

;; whic-key
(use-package which-key
  :config
  (add-hook 'after-init-hook 'which-key-mode))

;; help with parens and delimiters
(use-package smartparens
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode))
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; git
(use-package magit
  :bind ("C-x g" . magit-status))
(use-package git-gutter
  :config
  (global-git-gutter-mode 't))

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; lsp
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  ((lsp-mode-hook . lsp-enable-which-key-integration)))
(use-package lsp-ui
  :commands lsp-ui-mode)

;; debugger
;; realgud??

;; tree-sitter
(use-package tree-sitter-langs)
(use-package tree-sitter
  :config
  (global-tree-sitter-mode))

;; flycheck
(use-package flycheck
  :init (global-flycheck-mode))

;; python
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))
(use-package auto-virtualenv)
(add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

;; go
(use-package go-mode)
(add-hook 'go-mode-hook 'lsp-deferred)

;; wakatime
(use-package wakatime-mode
  :config
  (global-wakatime-mode))

;; vertico
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))
(savehist-mode 1)

;; vertico directory
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

;; `orderless' completion style.
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; company
(use-package company
  :init
  (global-company-mode))

;; format-all
(use-package format-all)

;; env variables
(use-package load-env-vars)

;; pdf save place
(use-package saveplace-pdf-view)

;; project sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :commands (dired-sidebar-toggle-sidebar))

;;
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(package-selected-packages
   '(dired-sidebar go-mode flycheck orderless saveplace-pdf-view tree-sitter-langs load-env-vars format-all company vertico wakatime-mode auto-virtualenv lsp-pyright lsp-ui lsp-mode projectile git-gutter magit rainbow-delimiters smartparens which-key modus-themes benchmark-init use-package))
 '(wakatime-cli-path "/usr/bin/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
