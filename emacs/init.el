;;; $HOME/dots/emacs/init.el --- My emacs config

;;; Commentary:
;; ¯\_(ツ)_/¯

;;; Code:

;; make it easy to edit this file
(defun find-config ()
  "Edit Emacs config."
  (interactive)
  (find-file "~/dots/emacs/init.el"))
(global-set-key (kbd "C-c i") 'find-config)

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

;; autosave on lose focus
(add-function :after after-focus-change-function
	      (lambda () (save-some-buffers t)))

;; minimal look
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; wrap lines
(global-visual-line-mode 1)

;; stop creating ~ files
(setq make-backup-files nil)

;; font
(add-to-list 'default-frame-alist '(font . "Monospace-10"))

;; remember cursor position
(save-place-mode 1)

;; theme
(load-theme 'modus-vivendi)

;; better modeline
(use-package telephone-line
  :config
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
	telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
	telephone-line-primary-right-separator 'telephone-line-cubed-right
	telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
  (setq telephone-line-height 18
	telephone-line-evil-use-short-tag t)
  (telephone-line-mode 1))

;; help with parens and delimiters
(use-package smartparens
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode))
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; projectile
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; lsp
(use-package lsp-mode
  :config
  (setq lsp-enable-snippet nil
	lsp-pylsp-plugins-flake8-config "~/dots/python/flake8"
	lsp-pylsp-plugins-pydocstyle-enabled nil)
  :hook ((python-mode . lsp)
	 (go-mode . lsp)))
(use-package lsp-ui
  :commands lsp-ui-mode)

;; load env vars
(use-package load-env-vars)

;; flycheck
(use-package flycheck
  :init (global-flycheck-mode))

;; python
(use-package auto-virtualenv
  :hook
  (python-mode . auto-virtualenv-set-virtualenv))

;; go
(use-package go-mode)

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

;; better search
(use-package rg
  :bind
  (("C-c s" . rg-project)))

;; format-all
(use-package format-all
  :hook (prog-mode . format-all-mode))

;; treemacs
(global-set-key (kbd "C-c t") 'treemacs)

;;
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(package-selected-packages
   '(load-env-vars rg vc-msg-show telephone-line go-mode flycheck orderless format-all company vertico wakatime-mode auto-virtualenv lsp-ui lsp-mode projectile rainbow-delimiters smartparens use-package))
 '(wakatime-cli-path "/usr/bin/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
