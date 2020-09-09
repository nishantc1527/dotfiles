;;; info-beamer-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "info-beamer" "info-beamer.el" (0 0 0 0))
;;; Generated autoloads from info-beamer.el

(autoload 'info-beamer-connect "info-beamer" "\
Connect to info-beamer node NODE.

\(fn &optional NODE)" t nil)

(autoload 'info-beamer-data "info-beamer" "\
Send DATA via UDP to info-beamer NODE.
If NODE is NIL use current directory.

\(fn DATA &optional NODE)" t nil)

(autoload 'info-beamer-osc "info-beamer" "\
Send OSC packet with ARGS to path /NODE/SUFFIX.

\(fn SUFFIX &optional NODE &rest ARGS)" t nil)

(autoload 'info-beamer-run "info-beamer" "\
Run info-beamer NODE or current directory.

\(fn &optional NODE)" t nil)

(autoload 'info-beamer-doc "info-beamer" "\
Open info-beamer documentation for ANCHOR or symbol under cursor.

\(fn &optional ANCHOR)" t nil)

(autoload 'info-beamer-mode "info-beamer" "\
Minor mode to interact with info-beamer nodes.

\\{info-beamer-mode-map}

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "info-beamer" '("info-beamer-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; info-beamer-autoloads.el ends here
