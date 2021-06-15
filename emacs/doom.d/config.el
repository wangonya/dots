;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(load-file "~/dots/emacs/doom.d/modeline.el")

(setq user-full-name "Kinyanjui Wangonya"
      user-mail-address "kwangonya@gmail.com")

(setq doom-theme 'doom-moonlight)


(if IS-MAC (setq doom-font (font-spec :family "JetBrains Mono" :size 14)
                doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 13 :weight 'light)
                ivy-posframe-font (font-spec :family "JetBrains Mono" :size 13 :weight 'light))
  (setq doom-font (font-spec :family "JetBrainsMono" :size 14)
                doom-variable-pitch-font (font-spec :family "JetBrainsMono" :size 13 :weight 'light)
                ivy-posframe-font (font-spec :family "JetBrainsMono" :size 13 :weight 'light)))

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

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1))

(defun presentation-end ()

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  (text-scale-mode 0))

(add-hook 'org-tree-slide-play-hook 'presentation-setup)
(add-hook 'org-tree-slide-stop-hook 'presentation-end)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
