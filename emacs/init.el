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

;; improve looks
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)
(defalias 'yes-or-no-p 'y-or-n-p)

;; remove minor mode from mode-line
;; https://emacs.stackexchange.com/a/41135
(let ((my/minor-mode-alist '((flycheck-mode flycheck-mode-line))))
  (setq mode-line-modes
        (mapcar (lambda (elem)
                  (pcase elem
                    (`(:propertize (,_ minor-mode-alist . ,_) . ,_)
                     `(:propertize ("" ,my/minor-mode-alist)
			           mouse-face mode-line-highlight
			           local-map ,mode-line-minor-mode-keymap)
                     )
                    (_ elem)))
                mode-line-modes)
        ))

;; move focus to split window
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; wrap lines
(global-visual-line-mode t)

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
(use-package git-gutter+
  :bind
  (("C-x p" . git-gutter+-previous-hunk)
   ("C-x n" . git-gutter+-next-hunk)
   ("C-x v s" . git-gutter+-stage-hunks)
   ("C-x v =" . git-gutter+-show-hunk)
   ("C-x v r" . git-gutter+-revert-hunks)
   ("C-x v c" . git-gutter+-commit)
   ("C-x v C" . git-gutter+-stage-and-commit)
   )
  :config
  (setq git-gutter+-added-sign "|"
	git-gutter+-modified-sign "|")
  (global-git-gutter+-mode)
  :diminish (git-gutter+-mode . "gg"))
(use-package git-gutter-fringe+)

;; help with parens and delimiters
(use-package smartparens
  :hook ((prog-mode . smartparens-mode)))
(use-package rainbow-delimiters
  :hook((prog-mode . rainbow-delimiters-mode)))

;; project.el
(require 'project)
(define-key ctl-x-map "p" project-prefix-map)
(use-package project-x
  :load-path "~/dots/emacs/"
  :after project
  :config
  (setq project-x-save-interval 300)    ;Save project state every 5 min
  (project-x-mode t))

;; vterm
(use-package vterm)
(use-package vterm-toggle
  :custom
  (vterm-toggle-scope 'project)
  (vterm-toggle-hide-method 'reset-window-configration)
  :bind (("C-c t" . #'vterm-toggle)))

;; eglot
(use-package eglot
  :bind
  (("C-c r" . eglot-rename)
   ("C-c h" . eldoc))
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

;; consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history))


  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  :init

  ;; Configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

;; formatter
(use-package apheleia
  :config (apheleia-global-mode t))

;; tree-sitter
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package tree-sitter-langs)


;; neotree
(use-package neotree
  :config
  (setq neo-theme (if (display-graphic-p) 'arrow 'arrow)
	neo-smart-open t))

;;
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(package-selected-packages
   '(consult vterm-toggle vterm project-x apheleia git-gutter-fringe+ git-gutter+ eglot spacemacs-theme neotree tree-sitter-langs tree-sitter load-env-vars go-mode orderless company vertico wakatime-mode auto-virtualenv rainbow-delimiters smartparens use-package))
 '(wakatime-cli-path "/usr/bin/wakatime-cli"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
