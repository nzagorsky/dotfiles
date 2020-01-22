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
(setq default-frame-alist '((undecorated . t)))

;; Fix emacs terminal binary availability
(add-to-list 'exec-path "/usr/local/bin")

;;----------------------------------------
;; Initial
;;----------------------------------------
;; Set separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Bootstrap `use-package'
(require 'package)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
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
;; Style/Theme config
(use-package dracula-theme
  :ensure t
  :init (setq inhibit-startup-message t) ;; hide the startup message
  :config
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)

    (load-theme 'dracula t)

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


 
;;----------------------------------------
;; Git integration
;;----------------------------------------p
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

(use-package magit
  :ensure t
  )


(provide 'init)
; }}}
;; vim:foldmethod=marker:foldlevel=0
;;; init.el ends here
