;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:


;;; init.el --- GNU Emacs Configuration


;;

;;; Commentary:

;; Following lines build the configuration code out of the custom.el file.

;;; Code:

;; Make startup faster by reducing the frequency of garbage
;; collection.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'package)
(package-initialize)

(if (file-exists-p (expand-file-name "custom.el" user-emacs-directory))
    (load-file (expand-file-name "custom.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "custom.org" user-emacs-directory)))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-bullets-bullet-list (quote ("◉" "◎" "⚫" "○" "►" "◇")) t)
 '(org-latex-compiler "xelatex")
 '(package-selected-packages
   (quote
    (telega intero markdown-mode gnuplot python-mode ob-ipython ein websocket simple-httpd virtualenvwrapper use-package-ensure-system-package treemacs-projectile treemacs-magit tern-auto-complete telephone-line prettier-js popwin pony-mode persistent-scratch org-ref org-bullets nord-theme moe-theme mode-icons latex-pretty-symbols kaolin-themes js2-refactor indent-guide highlight-numbers exec-path-from-shell ess-view doom-themes delight dashboard company centaur-tabs all-the-icons)))
 '(pdf-view-display-size (quote fit-page))
 '(pdf-view-resize-factor 1.1)
 '(pdf-view-use-unicode-ligther nil)
 '(reftex-plug-into-AUCTeX t)
 '(reftex-save-parse-info t)
 '(reftex-use-multiple-selection-buffers t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
