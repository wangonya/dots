;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Kinyanjui Wangonya"
      user-mail-address "kwangonya@gmail.com")

(setq doom-theme 'doom-moonlight)

(if IS-MAC (setq doom-font (font-spec :family "JetBrains Mono" :size 14)
                ivy-posframe-font (font-spec :family "JetBrains Mono" :size 12 :weight 'light))
  (setq doom-font (font-spec :family "JetBrainsMono" :size 14)
                ivy-posframe-font (font-spec :family "JetBrainsMono" :size 12 :weight 'light)))

(setq org-directory "~/org/")

(setq display-line-numbers-type 'nil)

;; clean up modeline
(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
  (setq doom-modeline-buffer-encoding nil))
(setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon nil)

;; treesitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; enable time tracking
(global-wakatime-mode)
(setq wakatime-cli-path "/home/kelvin/.local/bin/wakatime")

;; ignore venv from lsp watcher
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

;; python isort on save
(add-hook 'before-save-hook 'py-isort-before-save)

;; auto revert buffer after save to reload lsp
;; (add-hook 'after-save-hook 'revert-buffer)
(remove-hook 'doom-first-buffer-hook #'ws-butler-global-mode)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; python docs
(add-hook 'python-mode-hook (lambda ()
                                  (require 'sphinx-doc)
                                  (sphinx-doc-mode t)))

;; presentations
(global-set-key (kbd "<f8>") 'org-tree-slide-mode)
(global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)
(setq org-tree-slide-activate-message "Presentation started!")
(setq org-tree-slide-deactivate-message "Presentation finished!")
(setq org-tree-slide-header t)
(setq org-tree-slide-breadcrumbs " > ")
(setq org-image-actual-width nil)
(setq org-tree-slide-cursor-init nil)
(with-eval-after-load "org-tree-slide"
  (define-key org-tree-slide-mode-map (kbd "<f9>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f10>") 'org-tree-slide-move-next-tree))

(defun presentation-setup ()

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 2)
  (text-scale-mode 1)

  ;; activate zen mode
  (+zen/toggle 1)

  ;; change face for meta lines
  (set-face-attribute 'org-meta-line nil :height 0.8 :slant 'normal))

(defun presentation-end ()

  ;; activate zen mode
  (+zen/toggle 0)

 ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
 (text-scale-mode 0))

(add-hook 'org-tree-slide-play-hook 'presentation-setup)
(add-hook 'org-tree-slide-stop-hook 'presentation-end)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; autosave on lose focus
(add-function :after after-focus-change-function
              (lambda () (save-some-buffers t)))

;; better splits
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; org images
(setq org-startup-with-inline-images t)

;; django
(require 'pony-mode)
