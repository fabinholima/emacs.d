* Config Emacs Fabio Lima
  
** Configuração do servidores de pacotes

#+BEGIN_SRC emacs-lisp :tangle yes

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package delight :ensure t)
(use-package use-package-ensure-system-package :ensure t)
#+END_SRC


** Maximized Emacs
 Maximized Emacs 
#+BEGIN_SRC emacs-lisp :tangle yes
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; Bufer automatic
(global-auto-revert-mode 1)
(setq inhibit-startup-message t)  
(setq inhibit-startup-screen t
      initial-buffer-choice  nil)
;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
#+END_SRC



** Configurações Pessoais

#+BEGIN_SRC emacs-lisp :tangle yes
(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 cursor-in-non-selected-windows t                 ; Hide the cursor in inactive windows
 display-time-default-load-average nil            ; Don't display load average
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Prefers spaces over tabs
 inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 kill-ring-max 128                                ; Maximum length of kill ring
 load-prefer-newer t                              ; Prefers the newest version of a file
 mark-ring-max 128                                ; Maximum length of mark ring
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 tab-width 4                                      ; Set width for tabs
 use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
 user-full-name "Fabio Lima"               ; Set the full name of the current user
 user-mail-address "fabio.delima21@gmail.com"  ; Set the email address of the current user
 vc-follow-symlinks t                             ; Always follow the symlinks
 view-read-only t)                                ; Always open read-only buffers in view-mode
(cd "~/")                                         ; Move to the user directory
(column-number-mode 1)                            ; Show the column number
(display-time-mode 1)                             ; Enable time in the mode-line
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-hl-line-mode)                             ; Hightlight current line
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(show-paren-mode 1)                               ; Show the parent
#+END_SRC


** Configuração para o keyboard MacOSX

#+BEGIN_SRC emacs-lisp :tangle yes
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
;; Check the system 
(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none))
#+END_SRC


** PATH Exec

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package exec-path-from-shell)

(when (or (memq window-system '(mac ns x))
          (unless (memq system-type '(ms-dos windows-nt))
            (daemonp)))
  (exec-path-from-shell-initialize))
#+END_SRC



** Configuração de fontes 

#+BEGIN_SRC emacs-lisp :tangle yes
(set-face-attribute 'default nil
                    :family "Inconsolata" :height 125 :weight 'bold)
;(set-face-attribute 'default nil :font "Inconsolata" : height 140)
;(set-fontset-font t 'latin "Noto Sans-16")
;(defconst my-default-font "Hack-17")

#+END_SRC





** Themes Emacs

#+BEGIN_SRC emacs-lisp :tangle yes
;; Remember vscode 
;(use-package doom-themes)
;(load-theme 'doom-one t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The theme is good
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package nord-theme)
;;(load-theme 'nord t)
;;(use-package dracula-theme)
;;(load-theme 'dracula t)
;;(use-package solarized-theme)
;;(load-theme 'solarized-light t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (use-package doom-themes)
 ;;(load-theme 'doom-dark+ t)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Good               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(use-package monokei-theme)
;;(load-theme 'monokai t)
 (use-package moe-theme)
;;(load-theme 'moe-dark t)
;;(load-theme 'moe-light t)
;;(moe-theme-set-color 'blue)
;;(moe-theme-random-color)
;;(powerline-moe-theme)
(use-package kaolin-themes
  :config
  ;(load-theme 'kaolin-bubblegum t)
  (kaolin-treemacs-theme))

(defun set-light-theme ()
  "Set the light theme with some customization if needed."
  (interactive)
  (load-theme 'kaolin-light t))

(defun set-dark-theme ()
  "Set the dark theme with some customization if needed."
  (interactive)
  (load-theme 'kaolin-bubblegum t))

(let ((current-hour (string-to-number (format-time-string "%H"))))
  (if (or (< current-hour 6) (> current-hour 19)) (set-light-theme) (set-dark-theme)))


(defun theme-switcher ()
  (let ((current-hour (string-to-number (format-time-string "%H"))))
    (if (or (< current-hour 6) (> current-hour 19)) (set-light-theme) (set-dark-theme))))

;; Run at every 3600 seconds, after 0s delay
(run-with-timer 0 10800 'theme-switcher)
#+END_SRC




** Lines mode 

=linum-mode= is too heavy, so we use =display-line-numbers-mode= instead.

#+BEGIN_SRC emacs-lisp :tangle yes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
#+END_SRC




#+BEGIN_SRC emacs-lisp :tangle yes
  (global-set-key (kbd "C-+") #'text-scale-increase)
  (global-set-key (kbd "C--") #'text-scale-decrease)
#+END_SRC



** Scroll bar 

#+BEGIN_SRC emacs-lisp :tangle yes
(when window-system
  (menu-bar-mode -1)              ; Disable the menu bar
  (scroll-bar-mode -1)            ; Disable the scroll bar
  (tool-bar-mode -1)              ; Disable the tool bar
  (tooltip-mode -1))              ; Disable the tooltips
#+END_SRC





* Mode Line


#+BEGIN_SRC emacs-lisp :tangle yes
(use-package all-the-icons
:ensure t)
(use-package mode-icons)
#+END_SRC


#+BEGIN_SRC emacs-lisp :tangle yes
;(use-package svg-mode-line-themes)
;(use-package ocodo-svg-modelines)
;(ocodo-svg-modelines-init)
;(smt/enable)
;(smt/set-theme 'ocodo-kawaii-light-smt)
;(set-face-attribute 'mode-line nil :box nil)
;(set-face-attribute 'mode-line-inactive nil :box nil)

(use-package telephone-line)
(telephone-line-mode 1)
#+END_SRC


** Fancy Batery 

*** Show icon batery 

#+BEGIN_SRC emacs-lisp :tangle yes
;(use-package fancy-battery)
;(add-hook 'after-init-hook #'fancy-battery-mode)
#+END_SRC




 

* Complete Ivy Config 


#+BEGIN_SRC emacs-lisp :tangle yes
(use-package ivy
  :config (progn
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers  t
                  ivy-count-format         "(%d/%d) ")))

;; popup windows
(use-package popup :ensure t :defer t)
(use-package popwin :ensure t
  :config
  (popwin-mode 1)
  (setq popwin:close-popup-window-timer-interval 0.1)
  (setq popwin:close-popup-window-timer nil))


(defun ivy-display-function-popup (text)
  (with-ivy-window
    (popup-tip
     (setq ivy-insert-debug
           (substring text 1))
     :nostrip t)))
(use-package helm)
(require 'helm-config)
#+END_SRC

Config para o pdftools
 

* PDF Tools 

#+BEGIN_SRC emacs-lisp :tangle yes
;;; For 
;(use-package pdf-tools)
;(pdf-tools-install)
(use-package pdf-tools
  :defer 1
  :magic ("%PDF" . pdf-view-mode)
  :init (pdf-tools-install :no-query))

(use-package pdf-view
  :ensure nil
  :after pdf-tools
  :bind (:map pdf-view-mode-map
              ;("C-s" . isearch-forward)
              ;("d" . pdf-annot-delete)
              ;("h" . pdf-annot-add-highlight-markup-annotation)
              ;("t" . pdf-annot-add-text-annotation)
              ;("n" . pdf-view-next-page)
              ;("b" . pdf-view-previous-page)
        ("\\" . hydra-pdftools/body)
        ("<s-spc>" .  pdf-view-scroll-down-or-next-page)
        ("g"  . pdf-view-first-page)
        ("G"  . pdf-view-last-page)
        ("l"  . image-forward-hscroll)
        ("h"  . image-backward-hscroll)
        ("j"  . pdf-view-next-page)
        ("k"  . pdf-view-previous-page)
        ("e"  . pdf-view-goto-page)
        ("u"  . pdf-view-revert-buffer)
        ("al" . pdf-annot-list-annotations)
        ("ad" . pdf-annot-delete)
        ("aa" . pdf-annot-attachment-dired)
        ("am" . pdf-annot-add-markup-annotation)
        ("at" . pdf-annot-add-text-annotation)
        ("y"  . pdf-view-kill-ring-save)
        ("i"  . pdf-misc-display-metadata)
        ("s"  . pdf-occur)
        ("b"  . pdf-view-set-slice-from-bounding-box)
        ("r"  . pdf-view-reset-slice)

              )
  :custom
  (pdf-view-display-size 'fit-page)
  (pdf-view-resize-factor 1.1)
  (pdf-view-use-unicode-ligther nil))
#+END_SRC


* Spotify Config

#+BEGIN_SRC emacs-lisp :tangle yes 
;(add-to-list 'load-path "~/.emacs.d/spot4e")
;(require 'spot4e)
;(setq spot4e-refresh-token "AQCYO_dioYRsxYG8zJ4-c1n7jXKiarUUbKEk2gP-F1T-XZPJoEWfs5O7jxBUVrnMvJTFBfw265ny5cn1ahmiDlS63MQ8O01jIlGyapV6lTT7gORbt0mkp6QI08bU_PIVy-CcsVo08z3Ay5Thb6JEIDNIkIw-kY35kEm5Pk_0mJ1BJJSNtdwIm4sE_hzuP_Bh1-27KYcJf4bp4FJxtsq8n37d0vRU7GnYA9yX0Xra-2R4ftycdw3qyI7LIk8R4dKMKoimORd2yeUyFrWtV-vYkCpzAdXwOlmjjG73f5qvSG6kaXDtun0Z2gDv_svlUrg1lSmGc4uempyMdqRi_-2AE59IwV-P6xXIvUIElMUMzrD0fvHMIKbPh92EvhcSAFexZrTejQs3-Pn9pTdfb8U3U6y3JP6lW07hLzPg-rh42sCpL0krSc47MSw4a0fQG4iKiLjLP3CySo4siZBiKmdF4DtKfqa9sjIzdOf3yameTPME9InxPd6zhtGn-QJZNSCpCQyAhHDVLCkS")
#+END_SRC


* Org Mode 

** Org Bullets for mode org 

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  ;(org-bullets-bullet-list '("●" "►" "▸"))
  (org-bullets-bullet-list '("◉" "◎" "⚫" "○" "►" "◇"))
  )
#+END_SRC


** Persistent-scratch

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package persistent-scratch
  :config
  (persistent-scratch-setup-default))
#+END_SRC


* General

** Org packages 

Org mode already comes with Emacs, but it is important that we make
sure we have the latest version installed.

#+BEGIN_SRC emacs-lisp :tangle yes
;(use-package org :ensure org-plus-contrib)
#+END_SRC

As a general note, I just disable the prompts for code evaluation on
Org. You might want to remove this on your end.

#+BEGIN_SRC emacs-lisp :tangle yes
;(setq-default org-confirm-babel-evaluate nil)
#+END_SRC




** Agenda Views


#+BEGIN_SRC emacs-lisp :tangle yes
  (require 'org-agenda)
  (setq org-agenda-include-diary t
  calendar-week-start-day 0
  calendar-day-name-array ["Domingo" "Segunda" "Terça" "Quarta"
         "Quinta" "Sexta" "Sábado"]
  calendar-month-name-array ["Janeiro" "Fevereiro" "Março" "Abril"
           "Maio" "Junho" "Julho" "Agosto"
           "Setembro" "Outubro" "Novembro" "Dezembro"])


  (add-to-list 'org-agenda-custom-commands
         '("Y" "Agenda anual de aniversários e feriados" agenda "Visão Anual"
     ((org-agenda-span 365)
      (org-agenda-filter-by-category 'Aniversário)
      (org-agenda-time-grid nil))))
  (add-to-list 'org-agenda-custom-commands
         '("1" "Agenda mensal" agenda "Visão Mensal"
     ((org-agenda-span 31)
      (org-agenda-time-grid nil))))
  (add-to-list 'org-agenda-custom-commands
         '("7" "Agenda dos próximos sete dias" agenda "Visão de Sete Dias"
     ((org-agenda-span 7)
      (org-agenda-time-grid nil))))
(define-key global-map (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/Dropbox/Org"))
#+END_SRC



* Dasboard Emacs
 
** Dasboard

#+BEGIN_SRC emacs-lisp :tangle yes 
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-startup-banner 'logo)
(setq dashboard-banner-logo-title "With Great Power Comes Great Responsibility")
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)

(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)



 (setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-faicon "gitlab" :height 1.1 :v-adjust 0.0)
         "Homepage"
         "Browse homepage"
         (lambda (&rest _) (browse-url "http://www.gitlab.com/flima21")))
          ; Second Icon
                    ;        
          (,(all-the-icons-material "update" :height 1.1 :v-adjust 0.0)
          "Update"
          ""
          (lambda (&rest _) (package-refresh-contents " "))
          )

         ;("⚑" nil "Show flags" (lambda (&rest _) (message "flag")) error)
         )
        )
      )
  
 
 (setq dashboard-set-init-info t)
 
  (setq dashboard-items '((recents  . 5)
                        ;(bookmarks . 5)
                        ;(projects . 3)
                        (agenda . 7)
                        ;(registers . 5)
                        ))

(setq show-week-agenda-p t)

(setq dashboard-set-navigator t)
#+END_SRC


** Centaurs Tabs

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (setq centaur-tabs-show-navigation-buttons t)

#+END_SRC


** Magit config 

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package magit)
#+END_SRC



** Theemcas package 

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package treemacs
    :defines winum-keymap
    :commands (treemacs-follow-mode
               treemacs-filewatch-mode
               treemacs-fringe-indicator-mode
               treemacs-git-mode)
    :bind (([f8]        . treemacs)
           ("M-0"       . treemacs-select-window)
           ("C-x 1"     . treemacs-delete-other-windows)
           ("C-x t 1"   . treemacs-delete-other-windows)
           ("C-x t t"   . treemacs)
           ("C-x t b"   . treemacs-bookmark)
           ("C-x t C-t" . treemacs-find-file)
           ("C-x t M-t" . treemacs-find-tag)
           :map treemacs-mode-map
           ([mouse-1]   . treemacs-single-click-expand-action))
    :init
    (with-eval-after-load 'winum
      (bind-key (kbd "M-9") #'treemacs-select-window winum-keymap))
    :config
    (setq treemacs-collapse-dirs                 (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         30)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    ;; (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))

  ;; Projectile integration for treemacs
  (use-package treemacs-projectile
    :after treemacs projectile
    :bind (([M-f8] . treemacs-projectile)
           :map projectile-command-map
           ("h" . treemacs-projectile)))

 
  (use-package treemacs-magit
    :after treemacs magit
    :commands treemacs-magit--schedule-update
    :hook ((magit-post-commit
            git-commit-post-finish
            magit-post-stage
            magit-post-unstage)
. treemacs-magit--schedule-update))

#+END_SRC







* Company and Auto Complete

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode))
(use-package yasnippet)
(require 'yasnippet)
(yas/global-mode 1)
;;; Auto complete package
(use-package auto-complete)
(auto-complete-mode)
(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
#+END_SRC


* Language Configurations

Now we create configurations for programming languages.

** Django Emacs

 #+BEGIN_SRC emacs-lisp :tangle yes
(use-package pony-mode)
(use-package virtualenvwrapper
  :config
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  (setq venv-location (expand-file-name "~/appapi/"))
  (add-hook 'python-mode-hook (lambda ()
                               (hack-local-variables)
			       (venv-workon project-venv-name))))

;(use-package jedi
;  :config (add-hook 'python-mode-hook 'jedi:setup)
;  (setq jedi:setup-keys t)                      ; optional
;  (setq jedi:complete-on-dot t)                 ; optional
;  (jedi:setup))
(set-variable 'python-fill-docstring-style 'django)
#+END_SRC



** Config Emacs Js Java Script

auto-enable for .js/.jsx files

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package js2-mode
  :ensure
  :mode ("\\.js" . js2-mode)
  :init
  (setq js2-global-externs '("it" "afterEach" "beforeEach" "before" "after" "describe" "require" "module"))

  ;; todo: I think js2-refactor-mode should go in it's own use-package?
  ;; :hook (js2-imenu-extras-mode
  ;;     add-node-modules-path
  ;;     js2-refactor-mode
  ;;     flycheck-mode)

  :config
  (setq-default js2-basic-offset 2)
  (setq js-indent-level 2))

(use-package js2-refactor
  :requires js2-mode)

(use-package prettier-js
  :ensure
  :requires js2-mode)

(add-hook 'js2-mode-hook 'nvm-use-for-buffer)
(add-hook 'js2-mode-hook 'add-node-modules-path)
(add-hook 'js2-mode-hook 'flycheck-mode)
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'cov-mode)

(use-package tern)
(use-package tern-auto-complete
  :config (progn
	    (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
	    (add-hook 'js2-mode-hook 'auto-complete-mode)
	    (eval-after-load 'tern
	      '(progn
		 (require 'tern-auto-complete)
		 (tern-ac-setup)))))
#+END_SRC



** General
Indent-guide is useful for showing guide lines on code.

#+BEGIN_SRC emacs-lisp :tangle yes
 (use-package indent-guide
   :config (indent-guide-global-mode))
#+END_SRC

This should give us nice, highlighted numbers across all programming
languages.

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package highlight-numbers
  :config (add-hook 'prog-mode-hook 'highlight-numbers-mode))
#+END_SRC






** TeX


Use latex-preview-pane for comfortable editing.




#+BEGIN_SRC emacs-lisp :tangle yes
  
(use-package ob-latex
  :ensure nil
  :after org
  :custom (org-latex-compiler "xelatex"))

; (use-package latex-preview-pane
;    :config
;    (when (display-graphic-p)
;      (latex-preview-pane-enable)))

(use-package bibtex
  :after auctex
  :hook (bibtex-mode . my/bibtex-fill-column)
  :preface
  (defun my/bibtex-fill-column ()
    "Ensures that each entry does not exceed 120 characters."
    (setq fill-column 120)))


(use-package reftex
;  :after auctex
  :custom
  (reftex-plug-into-AUCTeX t)
  (reftex-save-parse-info t)
  (reftex-use-multiple-selection-buffers t))

(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;(setq global-set key (kbd "C-c j") 'org-ref-extract-bibtex-entries)


#+END_SRC
 

#+END_SRC

To compile the current file, we resort to Rubber, an external tool.

#+BEGIN_SRC emacs-lisp :tangle yes
  (defun rubber-compile-file ()
    (interactive)
    (shell-command
     (concat "rubber -d " buffer-file-name))
    (message "Finished LaTeX compilation."))
#+END_SRC

It is also interesting to have pretty symbols for our LaTeX files.

#+BEGIN_SRC emacs-lisp :tangle yes
  (use-package latex-pretty-symbols)
#+END_SRC

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package org-ref)

#+END_SRC






** R 

R languague

#+BEGIN_SRC emacs-lisp :tangle yes
;(require 'ess-site) ; This used org mode R install ess 
#+END_SRC




** Jupyter Emacs



#+BEGIN_SRC bash :eval no
pip install --user --upgrade pip
pip install --user --upgrade ipython
pip install --user --upgrade pyzmq
pip install --user --upgrade jupyter
#+END_SRC


#+BEGIN_SRC emacs-lisp :tangle yes
(use-package simple-httpd)
(use-package websocket)
;(add-hook 'prog-mode-hook 'goto-address-prog-mode)
(use-package ein)
(setq ein:polymode t)
;(setq ein:polymode t)
(require 'ein-notebook)

;(use-package jupyter)
(use-package ob-ipython)
(use-package python-mode
  :config (progn
            (setq py-shell-name                  "ipython"
                  py-which-bufname               "IPython"
                  py-python-command-args         '("-colors" "Linux")
                  py-smart-indentation           t)
            (add-hook 'python-mode-hook #'flycheck-mode)))

#+END_SRC



#+BEGIN_SRC emacs-lisp :tangle yes
(with-eval-after-load 'org
(org-babel-do-load-languages 'org-babel-load-languages
                             '((lisp   . t)
                               (shell  . t)
                               (gnuplot    . t)
                               (js     . t)
                               (R      . t)
                               (scheme . t)
                               (python   . t)
                               (ipython . t)
                               (ein    . t)
                               (ditaa . t)
                               (plantuml .t)
                               (latex .t)
                               )
                               )
                               )

#+END_SRC



** Gnuplot Mode 

Pacote tem dependencia com  o gnuplot 3.7, fortemente com bug. Necessario ter gnuplot instalado

#+BEGIN_SRC emacs-lisp :tangle yes
;(use-package 'ox-bibtex)
;; set path for program
(use-package gnuplot)
(setq gnuplot-program "/usr/bin/gnuplot") 
(setq auto-mode-alist 
(append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist))
(use-package ob-gnuplot :ensure nil :after org)
#+END_SRC




** Ditaa and Plantuml

Diagramm ditaa for emacs

#+BEGIN_SRC emacs-lisp :tangle yes
(defun sanityinc/grab-ditaa (url jar-name)
  "Download URL and extract JAR-NAME as `org-ditaa-jar-path'."
  ;; TODO: handle errors
  (message "Grabbing %s for org." jar-name)
  (let ((zip-temp (make-temp-name "emacs-ditaa")))
    (unwind-protect
        (progn
          (when (executable-find "unzip")
            (url-copy-file url zip-temp)
            (shell-command (concat "unzip -p " (shell-quote-argument zip-temp)
                                   " " (shell-quote-argument jar-name) " > "
                                   (shell-quote-argument org-ditaa-jar-path)))))
      (when (file-exists-p zip-temp)
        (delete-file zip-temp)))))


  (unless (and (boundp 'org-ditaa-jar-path)
               (file-exists-p org-ditaa-jar-path))
    (let ((jar-name "ditaa0_9.jar")
          (url "http://jaist.dl.sourceforge.net/project/ditaa/ditaa/0.9/ditaa0_9.zip"))
      (setq org-ditaa-jar-path (expand-file-name jar-name (file-name-directory user-init-file)))
      (unless (file-exists-p org-ditaa-jar-path)
        (sanityinc/grab-ditaa url jar-name))))


  (let ((jar-name "plantuml.jar")
        (url "http://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar"))
    (setq org-plantuml-jar-path (expand-file-name jar-name (file-name-directory user-init-file)))
    (unless (file-exists-p org-plantuml-jar-path)
      (url-copy-file url org-plantuml-jar-path)))

;(setq org-ditaa-jar-path "~/.emacs.d/ditaa.jar")
#+END_SRC




** Markdown 

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
  #+END_SRC



  ** Haskell

Just make sure we are using intero-mode.

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package intero
  :config (add-hook 'haskell-mode-hook 'intero-mode))
#+END_SRC




#+BEGIN_SRC emacs-lisp :tangle yes

; don't prompt me to confirm everytime I want to evaluate a block
(setq org-confirm-babel-evaluate nil)

;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)


(defun org-babel-tangle-block()
  (interactive)
  (let ((current-prefix-arg '(4)))
     (call-interactively 'org-babel-tangle)
))

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "C-c b") 'org-babel-tangle-block)
))
#+END_SRC


* Telegram Emacs

#+BEGIN_SRC emacs-lisp :tangle yes
(use-package telega)
  ;:load-path  "~/.telega/telega.el"
  ;:commands (telega)
  ;:defer t)
(setq telega-use-notifications t)
(add-hook 'telega-chat-mode-hook (lambda ()
    (setq company-backends '(telega-company-emoji))
    (company-mode 1)))
#+END_SRC



* Hydra Keys


** Configurações do pacote hydra custom menu


#+BEGIN_SRC emacs-lisp :tangle yes
(use-package hydra)
;(global-set-key (kbd "C-c w") 'hydra-window/body)
(global-set-key (kbd "C-c r") 'hydra-launcher/body)
;(global-set-key (kbd "C-c p") 'hydra-pdftools/body)
(global-set-key  (kbd "C-c v") 'hydra-tangle/body)
(global-set-key (kbd "C-c p") 'hydra-global-org/body)




(defhydra hydra-launcher (:color blue)
   "Launch"
   ("t" telega "Telegram")
   ("r" (browse-url "http://www.reddit.com/r/emacs/") "reddit")
   ("w" (browse-url "http://www.emacswiki.org/") "emacswiki")
   ("s" shell "shell")
   ("q" nil "cancel")
   )

(defhydra hydra-tangle (:color orange 
                        :hint nil)
  ("s" ein:stop "Stop Ein")
  ("r" ein:run "Run Ein")
  ("f" org-ref-extract-bibtex-to-file "Export Bibtex")
  ("p" org-latex-export-to-pdf "Make PDF")
  ("b" org-beamer-export-to-pdf "Beamer")
  ("q" nil "cancel")
  )


(defhydra hydra-global-org (:color blue
                            :hint nil)
  "
Timer^^        ^Clock^         ^Capture^
--------------------------------------------------
s_t_art        _w_ clock in    _c_apture
 _s_top        _o_ clock out   _l_ast capture
_r_eset        _j_ clock goto
_p_rint
"
  ("t" org-timer-start)
  ("s" org-timer-stop)
  ;; Need to be at timer
  ("r" org-timer-set-timer)
  ;; Print timer value to buffer
  ("p" org-timer)
  ("w" (org-clock-in '(4)))
  ("o" org-clock-out)
  ;; Visit the clocked task from any buffer
  ("j" org-clock-goto)
  ("c" org-capture)
  ("l" org-capture-goto-last-stored))
#+END_SRC


* Custom Block Org mode
** Custom Koma-class

#+BEGIN_SRC emacs-lisp :tangle yes 
     (add-to-list 'org-latex-classes
                   '("koma-article" "\\documentclass{scrartcl}"
                     ("\\section{%s}" . "\\section*{%s}")
                     ("\\subsection{%s}" . "\\subsection*{%s}")
                     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                     ("\\paragraph{%s}" . "\\paragraph*{%s}")
                     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
#+END_SRC


** Custom Beamer

#+BEGIN_SRC emacs-lisp :tangle yes 
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted) 

(setq org-latex-listings t
      org-latex-packages-alist '(("" "listings") ("" "color")))

#+END_SRC



#+BEGIN_SRC emacs-lisp :tangle yes 
;(require 'org-tempo)
;
(add-to-list 'org-structure-template-alist '("em" . "src emacs-lisp :tangle yes"))
(add-to-list 'org-structure-template-alist '("py" . "src ein-python :session py :results :exports none"))



;;;; CONFIG BLOCK LATEX
;(add-to-list 'org-structure-template-alist '("ba" . "#+ATTR_LATEX: :options [logo=\\bcattention, noborder=true, barre=none] {Alerta}"))
;(add-to-list 'org-structure-template-alist '("bc" "#+BEGIN_bclogo \n\n#+END_bclogo" "<src lang=\"?\">\n\n</src>"))
#+END_SRC
