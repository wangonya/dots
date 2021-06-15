;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load-file "~/dots/emacs/doom.d/modeline.el")

(setq user-full-name "Kinyanjui Wangonya"
      user-mail-address "kwangonya@gmail.com")

(setq doom-theme 'doom-moonlight)

(setq doom-font (font-spec :family "JetBrainsMono" :size 14)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono" :size 13 :weight 'light)
      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 13 :weight 'light))

(setq org-directory "~/org/")

(setq display-line-numbers-type 'nil)

;; enable time tracking
(global-wakatime-mode)

;; ignore venv from lsp watcher
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

;; isort on save
(add-hook 'before-save-hook 'py-isort-before-save)

;; auto revert buffer after save to reload lsp
(add-hook 'after-save-hook 'revert-buffer)
