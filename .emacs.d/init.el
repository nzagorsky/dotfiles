;;; package --- Init file
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" default)))
 '(git-gutter:hide-gutter t)
 '(git-gutter:update-interval 0.2)
 '(package-selected-packages
   (quote
    (smooth-scroll zenburn-theme zenburn git-gutter magit flycheck elpy material-theme smex helm-descbinds neotree emacs-neotree helm-projectile helm-ag helm-config evil-escape base16-theme helm use-package markdown-mode evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;----------------------------------------
;; Initial
;;----------------------------------------
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defun reload-init-file ()
  "Reload user configuration."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun open-init-file ()
  "Open user configuration."
  (interactive)
  (find-file "~/.emacs.d/init.el"))


;; Style config
(use-package zenburn-theme
  :ensure t
  :config
    (load-theme 'zenburn t)
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (set-window-fringes nil 0 0)
    (set-face-attribute 'vertical-border
			nil
			:foreground "#282a2e")
    (setq inhibit-startup-message t) ;; hide the startup message

  )

;; System setup
(setq vc-follow-symlinks t)
(setq debug-on-error  t)

;;----------------------------------------
;; Neotree
;;----------------------------------------
(use-package neotree
  :ensure t
  :config
    ;; Release C-e for neotree
    (define-key global-map (kbd "C-e") #'neotree-toggle)
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (add-hook 'neotree-mode-hook
	(lambda ()
	(define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	(define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
	(define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
	(define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
	(define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
	(define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
	(define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)

	(define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
	(define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)

	(define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
  )

;;----------------------------------------
;; Helm
;;----------------------------------------
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (setq helm-split-window-inside-p t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 40)
  (helm-mode 1)
  (helm-autoresize-mode 1)

  (define-key global-map (kbd "C-p") #'helm-find)
  (evil-leader/set-key
    "a" 'helm-ag
    "b" 'helm-buffers-list)
  )

(use-package helm-ag
  :ensure t
  :config
    (setq-default helm-ag-fuzzy-match 1)
  )


;;----------------------------------------
;; Smex
;;----------------------------------------
(use-package smex
  :ensure t
  :config
    (evil-leader/set-key
	"c" 'smex)
  
    (smex-initialize))

;;----------------------------------------
;; Projectile
;;----------------------------------------
(use-package projectile
  :ensure t
  :defer t
  :config
    (projectile-mode))


;;----------------------------------------
;; Evil
;;----------------------------------------
(use-package evil
  :ensure t
  :config

  (define-key global-map (kbd "C-h") #'evil-window-left)
  (define-key global-map (kbd "C-j") #'evil-window-down)
  (define-key global-map (kbd "C-k") #'evil-window-up)
  (define-key global-map (kbd "C-l") #'evil-window-right)

  ;; Fix C-u
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
      (interactive)
      (evil-delete (point-at-bol) (point))))


  ;; Unbind key for neotree
  (define-key evil-motion-state-map (kbd "C-e") nil)

  ;; Unbind key for neotree
  (define-key evil-normal-state-map (kbd "C-p") nil)

  ;; Configure vim leader keys
  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-key
    "<SPC>" 'evil-visual-line
    "b" 'switch-to-buffer
    "e" 'find-file
    "gev" 'open-init-file
    "gsv" 'reload-init-file
    "q" 'evil-quit
    "w" 'save-buffer
    )

    ;; TODO
    ;; jnnoremap <leader>t :Tags<CR>
    ;; jnnoremap <leader>h :Helptags<CR>
    ;; jnnoremap <leader>l :BLines<CR>

    (setq evil-leader/leader "<SPC>")
    (evil-mode 1)
    (global-evil-leader-mode))

  ;; Configure `jj`
  (use-package evil-escape
    :ensure t
    :config
    (evil-escape-mode)
    (setq evil-escape-inhibit-functions '(evil-visual-state-p))
    (setq-default evil-escape-key-sequence "jj")
    (setq-default evil-escape-delay 0.3))

  ;; Vim surround config
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  ;; TODO
  (use-package evil-indent-textobject
    :ensure t))



;;----------------------------------------
;; Python setup
;;----------------------------------------
(use-package elpy
  :ensure t
  :config
    (elpy-use-ipython)
    (elpy-enable))


;;----------------------------------------
;; Checkers setup
;;----------------------------------------
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;----------------------------------------
;; Git integration
;;----------------------------------------
;; TODO set key bindings to move between hunks
;; TODO set changed lines count in status bar
(use-package magit
  :ensure t)

(use-package git-gutter
  :ensure t
  :config
    (global-git-gutter-mode +1)

    ;; Hide gitgutter in case of no updates
    (custom-set-variables
	'(git-gutter:hide-gutter t))

    ;; Set update interval
    (custom-set-variables
	'(git-gutter:update-interval 0.2))
)


(provide 'init)
;;; init.el ends here
