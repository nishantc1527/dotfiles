;;; ox-mdx-deck-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ox-mdx-deck" "ox-mdx-deck.el" (0 0 0 0))
;;; Generated autoloads from ox-mdx-deck.el

(org-export-define-derived-backend 'mdx-deck 'blackfriday :menu-entry '(120 "MDX Deck" ((102 "File" ox-mdx-deck--export-to-file) (98 "Buffer" ox-mdx-deck--export-to-buffer))) :options-alist '((:with-toc) (:with-special-strings)) :translate-alist '((headline lambda (headline contents info) (concat (org-md-headline headline contents info) "---")) (src-block lambda (src-block contents info) (if (string-equal "rjsx" (org-element-property :language src-block)) (org-element-property :value src-block) (org-blackfriday-src-block src-block contents info)))))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ox-mdx-deck" '("ox-mdx-deck--export-to-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ox-mdx-deck-autoloads.el ends here
