(package-initialize)

(require 'package)

; Disable fucking bell
(setq ring-bell-function 'ignore)


; Disable pointless stuff
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1) 


; TODO move to custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
