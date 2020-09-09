
(require 'package)
;;; Code:
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'lsp-java)
(add-hook 'java-mode-hook #'lsp)

(setq custom-file (concat user-emacs-directory "custom-set.el"))
(load custom-file 'noerror)

(org-babel-load-file (concat user-emacs-directory "myinit.org"))

(provide '.emacs)
;;; .emacs ends here
(put 'set-goal-column 'disabled nil)
