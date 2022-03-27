;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'doom-tokyo-night)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; treesitter
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; clean up modeline
(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
  (setq doom-modeline-buffer-encoding nil))
(setq doom-modeline-buffer-file-name-style 'truncate-with-project)
(setq doom-modeline-icon nil)

;; enable time tracking
(global-wakatime-mode)

;; ignore venv from lsp watcher
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

;; autosave on lose focus
(add-function :after after-focus-change-function
              (lambda () (save-some-buffers t)))

;; better splits
(setq evil-vsplit-window-right t
      evil-split-window-below t)
