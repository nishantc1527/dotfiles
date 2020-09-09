;;; dummyparens-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "dummyparens" "dummyparens.el" (0 0 0 0))
;;; Generated autoloads from dummyparens.el

(defvar global-dummyparens-mode nil "\
Non-nil if Global Dummyparens mode is enabled.
See the `global-dummyparens-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-dummyparens-mode'.")

(custom-autoload 'global-dummyparens-mode "dummyparens" nil)

(autoload 'global-dummyparens-mode "dummyparens" "\
Toggle Dummyparens mode in all buffers.
With prefix ARG, enable Global Dummyparens mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Dummyparens mode is enabled in all buffers where
`turn-on-dummyparens-mode' would do it.
See `dummyparens-mode' for more information on Dummyparens mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dummyparens" '("turn-on-dummyparens-mode" "dp-" "dummyparens-mode")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dummyparens-autoloads.el ends here
