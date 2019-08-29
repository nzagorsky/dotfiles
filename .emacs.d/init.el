;;; package --- Init file
;;; Commentary:
;;; Code:

;; GC dirty hacks to speed up opening of Emacs.
(setq gc-cons-threshold 50000000)
(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))


;; Disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;;----------------------------------------
;; Initial
;;----------------------------------------
;; Set separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Bootstrap `use-package'
(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")  ;; Fix for some packages downloading
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))

(setq package-enable-at-startup nil)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; Bindings for configuration update
(defun reload-init-file ()
  "Reload user configuration."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun open-init-file ()
  "Open user configuration."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(define-key global-map (kbd "C-c g e v") 'open-init-file)
(define-key global-map (kbd "C-c g s v") 'reload-init-file)

;; ----------------------------------------
;; Plugins
;; ----------------------------------------
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Style/Theme config
(use-package gruvbox-theme
  :ensure t
  :init (setq inhibit-startup-message t) ;; hide the startup message
  :config
    (load-theme 'gruvbox t)

    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (set-window-fringes nil 0 0)

    ; Setup transparent background for terminal.
    (defun on-after-init ()
      (unless (display-graphic-p (selected-frame))
	(set-face-background 'default "unspecified-bg" (selected-frame))))
    (add-hook 'window-setup-hook 'on-after-init)

    (set-face-attribute 'vertical-border
			nil
			:foreground "#282a2e"))


;; System setup
(setq vc-follow-symlinks t)

;; Popup quick docs
(use-package eldoc
  :ensure t
  :config
    (global-eldoc-mode))

;; Parens autocompletion
(use-package smartparens
  :ensure t
  :config
    (smartparens-global-mode))


(use-package magit
  :ensure t
  )


(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (add-to-list 'flycheck-disabled-checkers 'python-flake8)
)


(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

(use-package ripgrep
  :ensure t)



;;----------------------------------------
;; Ivy
;;----------------------------------------
(use-package ivy
  :ensure t
  :init

  ;; Human fuzzy search
  (setq enable-recursive-minibuffers t)
  (setq ivy-use-virtual-buffers t)

  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
	'((ivy-switch-buffer . ivy--regex-plus)
	  (t . ivy--regex-fuzzy)))

  :config
  (ivy-mode 1)
  
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-c c f") 'counsel-fzf)
  (global-set-key (kbd "C-c c a") 'counsel-rg)
)

(use-package counsel
;; Brings Swiper and Counsel
  :ensure t
)


;;----------------------------------------
;; Autocomplete window (Company)
;;----------------------------------------
(use-package company
  :ensure t
  :bind (:map company-active-map
	      ("C-p" . company-select-previous)
	      ("C-n" . company-select-next))
  :init
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-tooltip-limit 10
          company-idle-delay 0.1
	  company-require-match nil
	  company-selection-wrap-around t
	  company-tooltip-align-annotations t
	  company-tooltip-flip-when-above t
          company-transformers '(company-sort-by-occurrence))
)


;;----------------------------------------
;; Git integration
;;----------------------------------------
(use-package git-gutter
  :ensure t
  :config
    (global-git-gutter-mode +1)

    ;; Hide gitgutter in case of no updates
    (custom-set-variables
	'(git-gutter:hide-gutter t))

    ;; Color setup
    (custom-set-variables
    '(git-gutter:modified-sign "~"))

    ;; Define minor mode name
    (custom-set-variables
    '(git-gutter:lighter " gitgutter"))

    ;; Set update interval
    (custom-set-variables
	'(git-gutter:update-interval 0.2))
)

;;----------------------------------------
;; Docker
;;----------------------------------------
(use-package dockerfile-mode
  :mode (("Dockerfile\\'" . dockerfile-mode))
  :ensure t)

(use-package docker-compose-mode
  :mode (("docker-compose\\'" . dockerfile-mode))
  :ensure t)


;;----------------------------------------
;; LSP mode {{{
;;----------------------------------------
(use-package lsp-mode
  :ensure t
  :commands lsp
  :init
  (require 'lsp-clients)
  (add-hook 'python-mode-hook 'lsp)
  
  :config
  (lsp-mode))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends))

(use-package csv-mode
  :ensure t
)


(provide 'init)
; }}}
;; vim:foldmethod=marker:foldlevel=0
;;; init.el ends here
