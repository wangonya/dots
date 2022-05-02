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

;; easy copy cut paste
(cua-mode t)

;; autosave on lose focus
(add-function :after after-focus-change-function
	      (lambda () (save-some-buffers t)))

;; minimal look
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(defalias 'yes-or-no-p 'y-or-n-p)

;; move focus to split window
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; wrap lines
(global-visual-line-mode 1)

;; refresh buffer when files change on disk
(global-auto-revert-mode t)

;; stop creating ~ files
(setq make-backup-files nil)

;; font
(add-to-list 'default-frame-alist '(font . "Monospace-10"))

;; remember cursor position
(save-place-mode t)

;; org capture notes file
(setq org-default-notes-file "~/org/wm.org")

;; org capture keybinding
(global-set-key (kbd "C-c c") 'org-capture)

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

;; theme
(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-dark t))

;; git-gutter
(use-package git-gutter
  :bind
  (("C-x p" . git-gutter:previous-hunk)
   ("C-x n" . git-gutter:next-hunk)
   ("C-x v s" . git-gutter:stage-hunk)
   ("C-x v =" . git-gutter:popup-hunk)
   ("C-x v r" . git-gutter:revert-hunk))
  :config
  (setq git-gutter:added-sign "|"
	git-gutter:modified-sign "|")
  (global-git-gutter-mode t))

;; help with parens and delimiters
(use-package smartparens
  :hook ((prog-mode . smartparens-mode)))
(use-package rainbow-delimiters
  :hook((prog-mode . rainbow-delimiters-mode)))

;; project.el
(require 'project)
(define-key ctl-x-map "p" project-prefix-map)

;; eglot
(use-package eglot
  :bind
  (("C-c r" . eglot-rename)
   ("C-c h" . eldoc)
   ("<f6>" . xref-find-definitions))
  :hook ((python-mode . eglot-ensure)
	 (go-mode . eglot-ensure)
	 (bash-mode . eglot-ensure)))

;; load env vars
(use-package load-env-vars)

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
(savehist-mode t)

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
  :bind
  (("C-c f" . format-all-buffer)))

;; tree-sitter
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package tree-sitter-langs)


;; neotree
(defun neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
        (file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
        (if (neo-global--window-exists-p)
            (progn
              (neotree-dir project-dir)
              (neotree-find file-name)))
      (message "Could not find git project root."))))
(use-package neotree
  :bind (("C-c t" . neotree-project-dir))
  :config
  (setq neo-theme (if (display-graphic-p) 'arrow 'arrow)
	neo-smart-open t
	projectile-switch-project-action 'neotree-projectile-action))

;;
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(package-selected-packages
   '(eglot git-gutter spacemacs-theme neotree tree-sitter-langs tree-sitter load-env-vars rg go-mode orderless format-all company vertico wakatime-mode auto-virtualenv rainbow-delimiters smartparens use-package))
 '(wakatime-cli-path "/usr/bin/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
