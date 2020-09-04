
(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(setq custom-file (concat user-emacs-directory "custom-set.el"))
(load custom-file 'noerror)

(org-babel-load-file (concat user-emacs-directory "myinit.org"))

;; (load-file (concat user-emacs-directory "torstein_config.el"))

(provide '.emacs)
