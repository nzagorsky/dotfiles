;;; package --- Init file
;;; Commentary:
;;; Code:

;; GC dirty hacks
(setq gc-cons-threshold 50000000)
(add-hook 'emacs-startup-hook 'my/set-gc-threshold)
(defun my/set-gc-threshold ()
  "Reset `gc-cons-threshold' to its default value."
  (setq gc-cons-threshold 800000))

;;----------------------------------------
;; Initial
;;----------------------------------------
;; Set custom file in separate
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; Bootstrap `use-package'
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(setq package-enable-at-startup nil)

(package-initialize)
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
(use-package clues-theme
  :ensure t
  :defer 0.1
  :init (setq inhibit-startup-message t) ;; hide the startup message
  :config
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (set-window-fringes nil 0 0)
    (set-face-attribute 'vertical-border
			nil
			:foreground "#282a2e"))

(use-package auto-complete
  :ensure t)

(use-package auto-compile
  :ensure t
  :config
    (auto-compile-on-load-mode)
    (auto-compile-on-save-mode))

(use-package esup
  :ensure t
  :defer t)

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
  :defer 0.1
  :config
    (evil-leader/set-key
	"l" 'swiper
	"f" 'counsel-fzf
	"c" 'counsel-M-x
	"a" 'counsel-ag
	"b" 'ivi-switch-buffer))


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
    (evil-mode 1)
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
    (define-key evil-normal-state-map (kbd "C-p") nil))

;; Configure vim leader keys
(use-package evil-leader
    :ensure t
    :config
	(setq evil-leader/leader "<SPC>")
	(global-evil-leader-mode))
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
    :ensure t)

(use-package vimish-fold
    :ensure t
    :config
	(vimish-fold-global-mode 1))


;; Tmux navigation
(use-package navigate
  :ensure t)


;;----------------------------------------
;; Python setup
;;----------------------------------------
(use-package anaconda-mode
  :ensure t
  :defer t
  :init (add-hook 'python-mode-hook 'anaconda-mode)
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)

  :config
    (evil-leader/set-key-for-mode 'python-mode
	"d" 'anaconda-mode-find-definitions
	"n" 'anaconda-mode-find-references
	"K" 'anaconda-mode-show-doc
	)
    )


(use-package company-anaconda
    :ensure t
    :mode ("\\.py\\'" . python-mode)
    :interpreter ("python" . python-mode)
    :init (add-hook 'python-mode-hook 'anaconda-mode))
	  (eval-after-load "company"
	    '(add-to-list 'company-backends 'company-anaconda))


;;----------------------------------------
;; Markdown
;;----------------------------------------
(use-package markdown-mode
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode)))


;;----------------------------------------
;; Checkers setup (Flycheck)
;;----------------------------------------
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;----------------------------------------
;; Autocomplete window (Company)
;;----------------------------------------
;; TODO check why company doesn't load
(use-package company
  :ensure t
  :bind (:map company-active-map
	      ("C-p" . company-select-previous)
	      ("C-n" . company-select-next))
  :init
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-tooltip-limit 10
          company-idle-delay 0.1
	  company-echo-delay 0
	  company-require-match nil
	  company-selection-wrap-around t
	  company-tooltip-align-annotations t
	  company-tooltip-flip-when-above t
          company-transformers '(company-sort-by-occurrence))
)



;;----------------------------------------
;; Git integration
;;----------------------------------------
;; TODO set key bindings to move between hunks
;; TODO set changed lines count in status bar
(use-package evil-magit
  :ensure t
  :defer 3
  )

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

;;----------------------------------------
;; Docker
;;----------------------------------------
(use-package dockerfile-mode
  :mode (("Dockerfile\\'" . dockerfile-mode))
  :ensure t)

(use-package docker-compose-mode
  :mode (("docker-compose\\'" . dockerfile-mode))
  :ensure t)

(provide 'init)
;;; init.el ends here
