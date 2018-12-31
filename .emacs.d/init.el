;;; package --- Init file
;;; Commentary:
;;; Code:

;; GC dirty hacks
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
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

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

;; Style/Theme config 
(use-package gruvbox-theme
  :ensure t
  :init (setq inhibit-startup-message t) ;; hide the startup message
  :config
    (toggle-scroll-bar -1)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (set-window-fringes nil 0 0)
    (set-face-attribute 'vertical-border
			nil
			:foreground "#282a2e"))

; Emacs super profiler
; (use-package esup
;   :ensure t
;   :defer t)

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

;; Configure vim leader keys
; (use-package evil-leader
;     :ensure t
;     :config
; 	(setq evil-leader/leader "<SPC>")
; 	(global-evil-leader-mode)
; 	(evil-leader/set-key
; 	    "<SPC>" 'evil-visual-line
; 	    "b" 'switch-to-buffer
; 	    "e" 'find-file
; 	    "gev" 'open-init-file
; 	    "gsv" 'reload-init-file
; 	    "q" 'evil-quit
; 	    "w" 'save-buffer
; 	    "l" 'swiper
; 	    "c" 'counsel-M-x
; 	    "a" 'counsel-projectile-ag
; 	    "p" 'counsel-fzf
; 	    )
;     )

(use-package projectile
  :ensure t
  :config
    (projectile-mode +1)
)



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
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)

  ; (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
)

(use-package counsel
;; Brings Swiper and Counsel
  :ensure t
)
(define-key global-map (kbd "C-c g e v") 'open-init-file)
(define-key global-map (kbd "C-c g s v") 'reload-init-file)

;;----------------------------------------
;; Evil
;;----------------------------------------
; (use-package evil
;   :ensure t
;   :config
;     (evil-mode 1)
; 
;     ;; Fix C-u
;     (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
;     (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
;     (define-key evil-insert-state-map (kbd "C-u")
;     (lambda ()
; 	(interactive)
; 	(evil-delete (point-at-bol) (point))))
; 
;     ;; Replace with system clipboard
;     (fset 'evil-visual-update-x-selection 'ignore)
; 
; )



;; Configure `jk`
; (use-package evil-escape
;     :ensure t
;     :config
; 	(evil-escape-mode)
; 	(setq evil-escape-inhibit-functions '(evil-visual-state-p))
; 	(setq-default evil-escape-key-sequence "jk")
; 	(setq-default evil-escape-delay 0.3))
; 
; ;; Vim surround config
; (use-package evil-surround
;     :ensure t
;     :config
; 	(global-evil-surround-mode))
; 
; (use-package evil-indent-textobject :ensure t)
; 
; (use-package vimish-fold
;     :ensure t
;     :config
; 	(vimish-fold-global-mode))


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


;;----------------------------------------
;; LSP mode
;;----------------------------------------
(use-package lsp-mode
  :commands lsp
  :init
  (require 'lsp-clients)
  (add-hook 'python-mode-hook 'lsp)
  :config
  (lsp-mode)
 )


(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(provide 'init)
