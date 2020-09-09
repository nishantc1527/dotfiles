(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package org
  :ensure t
  :config
  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil
        org-edit-src-content-indentation 0)
  (use-package org-bullets
    :init
    (add-hook 'org-mode-hook 'org-bullets-mode))
  (setq org-ellipsis "⤵")
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)
  (setq org-src-window-setup 'current-window)
  (add-to-list 'org-structure-template-alist
               '("el" . "src emacs-lisp"))
  (setq org-adapt-indentation nil)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)
  (require 'ox-md)
  (require 'ox-beamer)
  (use-package htmlize :ensure t)
  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq TeX-parse-self t)
  (setq TeX-PDF-mode t)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (LaTeX-math-mode)
              (setq TeX-master t)))
  (use-package orgalist
    :config
    (add-hook 'git-commit-mode-hook 'orgalist-mode)
    (add-hook 'markdown-mode-hook 'orgalist-mode)
    (add-hook 'message-mode-hook 'orgalist-mode))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)

  (defun my/org-render-latex-fragments ()
    (if (org--list-latex-overlays)
        (progn (org-toggle-latex-fragment)
               (org-toggle-latex-fragment))
      (org-toggle-latex-fragment)))

  (add-hook 'org-mode-hook
            (lambda ()
              (add-hook 'after-save-hook 'my/org-render-latex-fragments nil 'make-the-hook-local)))

  (add-hook 'post-command-hook 'cw/org-auto-toggle-fragment-display t))

;;
;; 28.07.2017
;; Charles Wang
;;

;;;;;;; Tweaks for Org & org-latex ;;;;;;

(defvar cw/org-last-fragment nil
  "Holds the type and position of last valid fragment we were on. Format: (FRAGMENT_TYPE FRAGMENT_POINT_BEGIN)"
  )

(setq cw/org-valid-fragment-type
      '(latex-fragment
        latex-environment
        link))

(defun cw/org-curr-fragment ()
  "Returns the type and position of the current fragment available for preview inside org-mode. Returns nil at non-displayable fragments"
  (let* ((fr (org-element-context))
         (fr-type (car fr)))
    (when (memq fr-type cw/org-valid-fragment-type)
      (list fr-type
            (org-element-property :begin fr))))
  )

(defun cw/org-remove-fragment-overlay (fr)
  "Remove fragment overlay at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type)
               (eq 'latex-environment fr-type))
           (let ((ov (loop for ov in (org--list-latex-overlays)
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov))))
          ((eq 'link fr-type)
           nil;; delete image overlay here?
           ))
    ))

(defun cw/org-preview-fragment (fr)
  "Preview org fragment at fr"
  (let ((fr-type (nth 0 fr))
        (fr-begin (nth 1 fr)))
    (goto-char fr-begin)
    (cond ((or (eq 'latex-fragment fr-type) ;; latex stuffs
               (eq 'latex-environment fr-type))
           (when (cw/org-curr-fragment) (org-preview-latex-fragment))) ;; only toggle preview when we're in a valid region (for inserting in the front of a fragment)


          ((eq 'link fr-type) ;; for images
           (let ((fr-end (org-element-property :end (org-element-context))))
             (org-display-inline-images nil t fr-begin fr-end))))
    ))


(defun cw/org-auto-toggle-fragment-display ()
  "Automatically toggle a displayable org mode fragment"
  (and (eq 'org-mode major-mode)
       (let ((curr (cw/org-curr-fragment)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            cw/org-last-fragment
            ;; and are on a fragment now
            curr
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (equal curr cw/org-last-fragment)))

           ;; go back to last one and put image back, provided there is still a fragment there
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment)
             ;; now remove current image
             (cw/org-remove-fragment-overlay curr)
             ;; and save new fragment
             )
           (setq cw/org-last-fragment curr))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not curr)
            ;; but we were on one
            cw/org-last-fragment)
           ;; put image back on, provided that there is still a fragment here.
           (save-excursion
             (cw/org-preview-fragment cw/org-last-fragment))

           ;; unset last fragment
           (setq cw/org-last-fragment nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not cw/org-last-fragment)
            ;; but now we are
            curr)
           ;; remove image
           (save-excursion
             (cw/org-remove-fragment-overlay curr)
             )
           (setq cw/org-last-fragment curr))

          ))))

(defvar org-latex-fragment-last nil
  "Holds last fragment/environment you were on.")

(defun org-latex-fragment-toggle ()
  "Toggle a latex fragment image "
  (and (eq 'org-mode major-mode)
       (let* ((el (org-element-context))
              (el-type (car el)))
         (cond
          ;; were on a fragment and now on a new fragment
          ((and
            ;; fragment we were on
            org-latex-fragment-last
            ;; and are on a fragment now
            (or
             (eq 'latex-fragment el-type)
             (eq 'latex-environment el-type))
            ;; but not on the last one this is a little tricky. as you edit the
            ;; fragment, it is not equal to the last one. We use the begin
            ;; property which is less likely to change for the comparison.
            (not (= (org-element-property :begin el)
                    (org-element-property :begin org-latex-fragment-last))))
           ;; go back to last one and put image back
           (save-excursion
             (goto-char (org-element-property :begin org-latex-fragment-last))
             (org-preview-latex-fragment))
           ;; now remove current image
           (goto-char (org-element-property :begin el))
           (let ((ov (loop for ov in org-latex-fragment-image-overlays
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov)))
           ;; and save new fragment
           (setq org-latex-fragment-last el))

          ;; were on a fragment and now are not on a fragment
          ((and
            ;; not on a fragment now
            (not (or
                  (eq 'latex-fragment el-type)
                  (eq 'latex-environment el-type)))
            ;; but we were on one
            org-latex-fragment-last)
           ;; put image back on
           (save-excursion
             (goto-char (org-element-property :begin org-latex-fragment-last))
             (org-preview-latex-fragment))
           ;; unset last fragment
           (setq org-latex-fragment-last nil))

          ;; were not on a fragment, and now are
          ((and
            ;; we were not one one
            (not org-latex-fragment-last)
            ;; but now we are
            (or
             (eq 'latex-fragment el-type)
             (eq 'latex-environment el-type)))
           (goto-char (org-element-property :begin el))
           ;; remove image
           (let ((ov (loop for ov in org-latex-fragment-image-overlays
                           if
                           (and
                            (<= (overlay-start ov) (point))
                            (>= (overlay-end ov) (point)))
                           return ov)))
             (when ov
               (delete-overlay ov)))
           (setq org-latex-fragment-last el))))))


(add-hook 'post-command-hook 'org-latex-fragment-toggle)

(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action)

  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (global-set-key (kbd "C-c h o") 'helm-occur)
  (global-set-key (kbd "C-c h g") 'helm-google-suggest)
  (global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)
  (require 'shell)
  (define-key shell-mode-map (kbd "C-c C-l") 'helm-comint-input-ring)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  (setq helm-split-window-inside-p           t
        helm-move-to-line-cycle-in-source     t
        helm-ff-search-library-in-sexp        t
        helm-scroll-amount                    8
        helm-ff-file-name-history-use-recentf t
        helm-echo-input-in-header-line t
        helm-autoresize-max-height 0
        helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (helm-mode 1)
  (use-package helm-file-preview
    :ensure t
    :config
    (setq helm-file-preview-only-when-line-numbers t)
    (setq helm-file-preview-preview-only t)
    (helm-file-preview-mode 1)))

;; (use-package helm-c-yasnippet
;;   :ensure t
;;   :config
;;   (setq helm-yas-space-match-any-greedy t)
;;   (global-set-key (kbd "C-c y") 'helm-yas-complete))

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
                (ggtags-mode 1))))
  (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
  (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
  (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
  (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
  (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
  (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

  (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index))

(use-package helm-gtags
  :ensure t
  :config
  (setq
   helm-gtags-ignore-case t
   helm-gtags-auto-update t
   helm-gtags-use-input-at-cursor t
   helm-gtags-pulse-at-cursor t
   helm-gtags-prefix-key "\C-ch"
   helm-gtags-suggested-key-mapping t
   )

  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)

  (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
  (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
  (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))

(add-hook 'dired-mode-hook 'gtags-mode 'helm-gtags-mode 'semantic-mode)
(add-hook 'eshell-mode-hook 'gtags-mode 'helm-gtags-mode 'semantic-mode)
(add-hook 'c-mode-hook 'gtags-mode 'helm-gtags-mode 'semantic-mode)
(add-hook 'c++-mode-hook 'gtags-mode 'helm-gtags-mode 'semantic-mode)
(add-hook 'asm-mode-hook 'gtags-mode 'helm-gtags-mode 'semantic-mode)

;; (ggtags-mode 1)
;; (gtags-mode 1)
;; (helm-gtags-mode 1)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

(org-babel-load-file (concat user-emacs-directory "programminginit.org"))

(global-set-key (kbd "C-x C-b") 'ibuffer)
(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (setq ibuffer-saved-filter-groups
		   '(("home"
		      ("emacs-config" (or (filename . ".emacs.d")
					  (filename . "emacs-config")))
		      ("Org" (or (mode . org-mode)
				 (filename . "OrgMode")))
		      ("code" (filename . "code"))
		      ("Web Dev" (or (mode . html-mode)
				     (mode . css-mode)))
		      ("Subversion" (name . "\*svn"))
		      ("Magit" (name . "\*magit"))
		      ("ERC" (mode . erc-mode))
		      ("Help" (or (name . "\*Help\*")
				  (name . "\*Apropos\*")
				  (name . "\*info\*"))))))
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")
	     (setq ibuffer-expert t)
	     (setq ibuffer-show-empty-filter-groups nil)))

(with-eval-after-load 'dired (define-key dired-mode-map "c" 'find-file))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package fish-completion
  :ensure t
  :config
  (global-fish-completion-mode))
;; (use-package eshell-prompt-extras 
;; :ensure t
;; :config
;; (setq epe-show-python-info nil)
;; )

(use-package eshell-git-prompt
  :ensure t
  :config
  (eshell-git-prompt-use-theme 'git-radar))

(setq scroll-step 1)
(require 'cl-lib)
(defun select-or-create (arg)
  "Commentary ARG."
  (if (string= arg "New eshell")
      (eshell t)
    (switch-to-buffer arg)))
(defun eshell-switcher (&optional arg)
  "Commentary ARG."
  (interactive)
  (let* (
         (buffers (cl-remove-if-not (lambda (n) (eq (buffer-local-value 'major-mode n) 'eshell-mode)) (buffer-list)) )
         (names (mapcar (lambda (n) (buffer-name n)) buffers))
         (num-buffers (length buffers) )
         (in-eshellp (eq major-mode 'eshell-mode)))
    (cond ((eq num-buffers 0) (eshell (or arg t)))
          ((not in-eshellp) (switch-to-buffer (car buffers)))
          (t (select-or-create (completing-read "Select Shell:" (cons "New eshell" names)))))))

(defun eshell/in-term (prog &rest args)
  "Run shell command in term buffer."
  (switch-to-buffer (apply #'make-term prog prog nil args))
  (term-mode)
  (term-char-mode))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode) t)
  (setq web-mode-engines-alist
        '(("django"    . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
        '(("css" . (ac-source-css-property))
          ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))

(use-package ox-reveal
:ensure ox-reveal)

(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(use-package htmlize
:ensure t)

(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)
(tool-bar-mode -1)
(global-set-key (kbd "<f5>") 'revert-buffer)
(setq visible-bell 1)
(toggle-scroll-bar -1)
(show-paren-mode 1)
(setq electric-pair-preserve-balance nil)
(global-hl-line-mode 1)
(save-place-mode t)
(setq-default indent-tabs-mode nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq-default cursor-type 'box)
(set-cursor-color "#AEFF40")
(set-face-attribute 'region nil 
:background "#cc02bb" 
:foreground "#d3e603")

(use-package nyan-mode
  :ensure t
  :config 
  (nyan-mode 1))

(use-package golden-ratio
  :ensure t
  :config 
  (golden-ratio-mode 1))

(use-package smartparens
  :ensure t)

(use-package duplicate-thing
  :ensure t
  :config
  (global-set-key (kbd "M-c") 'duplicate-thing))

(require 'misc)
(autoload 'zap-up-to-char "misc" 'interactive)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package sudo-edit
  :ensure t)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1)
  (setq beacon-color "#00aa33"))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-c C-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

(use-package which-key
  :config (which-key-mode))

(use-package ansi-color
  :ensure t
  :config
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on))

(require 'uniquify)
(setq uniquify-separator "/"               ;; The separator in buffer names.
      uniquify-buffer-name-style 'forward) ;; names/in/this/style

(use-package try
  :ensure t)

(setf custom-safe-themes t)
(use-package zeno-theme :ensure t)
(load-theme 'zeno)
