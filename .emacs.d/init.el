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
    ("2a739405edf418b8581dcd176aaf695d319f99e3488224a3c495cb0f9fd814e3" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "78c1c89192e172436dbf892bd90562bc89e2cc3811b5f9506226e735a953a9c6" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" default)))
 '(fci-rule-color "#383838")
 '(git-gutter:hide-gutter t)
 '(git-gutter:lighter " GG")
 '(git-gutter:modified-sign "~")
 '(git-gutter:update-interval 0.2)
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (origami navigate term+mux yaml-mode counsel company-anaconda company-mode anaconda-mode smooth-scroll zenburn-theme zenburn git-gutter magit flycheck elpy material-theme smex helm-descbinds neotree emacs-neotree helm-projectile helm-ag helm-config evil-escape base16-theme helm use-package markdown-mode evil-visual-mark-mode)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
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
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

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


;;----------------------------------------
;; Neotree
;;----------------------------------------
(use-package neotree
  :ensure t
  :demand
  :bind (("C-e" . neotree-toggle))
  :config
    ;; Release C-e for neotree
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
;; Ivy
;;----------------------------------------
(use-package ivy
  :ensure t
  :config
    (ivy-mode 1)

    ;; Human fuzzy search
    (setq ivy-re-builders-alist
	'((ivy-switch-buffer . ivy--regex-plus)
	    (t . ivy--regex-fuzzy)))

    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
)

(use-package counsel
;; Brings Swiper and Counsel
  :ensure t
  :config

    (evil-leader/set-key
	"l" 'swiper
	"f" 'counsel-fzf
	"c" 'counsel-M-x
	"a" 'counsel-ag
	"b" 'ivi-switch-buffer)
)


;;----------------------------------------
;; Projectile
;;----------------------------------------
(use-package projectile
  :ensure t
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

    (setq evil-leader/leader "<SPC>")
    (evil-mode 1)
    (global-evil-leader-mode))

    ;; Folding
    (hs-minor-mode 1)

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

  (use-package evil-indent-textobject
    :ensure t))

(use-package navigate
  ;; Tmux navigation
  :ensure t)


;;----------------------------------------
;; Python setup
;;----------------------------------------
(use-package anaconda-mode
  :ensure t
  :config
    (evil-leader/set-key-for-mode 'python-mode
	"d" 'anaconda-mode-find-definitions
	"n" 'anaconda-mode-find-references
	"K" 'anaconda-mode-show-doc
	)

    (add-hook 'python-mode-hook 'anaconda-mode))


;;----------------------------------------
;; Checkers setup (Flycheck)
;;----------------------------------------
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;----------------------------------------
;; Autocomplete window (Company)
;;----------------------------------------
(use-package company
  :ensure t
  :config
    (company-mode 1)
)

(use-package company-anaconda
:ensure t
:config
    (eval-after-load "company"
      '(add-to-list 'company-backends 'company-anaconda))
)

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
    ;; Color setup
    (custom-set-variables
    '(git-gutter:modified-sign "~"))

    ;; Define minor mode name
    (custom-set-variables
    '(git-gutter:lighter " GG"))

    ;; Set update interval
    (custom-set-variables
	'(git-gutter:update-interval 0.2))
)


(provide 'init)
;;; init.el ends here
