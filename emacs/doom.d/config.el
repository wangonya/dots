(setq user-full-name "Kinyanjui Wangonya"
      user-mail-address "kwangonya@gmail.com")

(setq doom-theme 'doom-moonlight)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'light)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13 :weight 'light)
      ivy-posframe-font (font-spec :family "JetBrainsMono Nerd Font" :size 13 :weight 'light))

(setq org-directory "~/org/")

(setq display-line-numbers-type 'nil)

;; enable time tracking
(global-wakatime-mode)

;; ignore venv from lsp watcher
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\venv\\'"))

