
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 0.1)
 '(ac-auto-start nil)
 '(ansi-color-names-vector
   ["#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "dark red" "#ab9df2" "#a1efe4" "#fcfcfa"])
 '(auto-revert-check-vc-info t)
 '(beacon-blink-duration 2)
 '(custom-safe-themes
   (quote
    ("a325ba05dc3b5c2fa89af0ff354bbbe90251fb1a6e6d5682977cebe61ce72ab7" default)))
 '(default-input-method "TeX")
 '(display-line-numbers (quote relative))
 '(display-line-numbers-type (quote relative))
 '(dynamic-completion-mode t)
 '(elpy-rpc-python-command "python3")
 '(enable-recursive-minibuffers t)
 '(fa-delay 1)
 '(fa-do-comments (quote non-nil))
 '(fa-hint-position-below t)
 '(flycheck-checker-error-threshold nil)
 '(flycheck-checkers
   (quote
    (ada-gnat asciidoctor asciidoc awk-gawk bazel-buildifier c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint elixir-credo emacs-lisp emacs-lisp-checkdoc ember-template erlang-rebar3 erlang eruby-erubis eruby-ruumba fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc protobuf-prototool pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-standard ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar terraform terraform-tflint tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby yaml-yamllint)))
 '(flycheck-clang-args (quote ("-std=c++2a")))
 '(flycheck-clang-include-path
   (quote
    ("/usr/include/c++/10" "/usr/include/clang/10/include/")))
 '(flycheck-clang-language-standard nil)
 '(flycheck-cppcheck-standards nil)
 '(flycheck-gcc-args (quote ("-std=c++2a")))
 '(flycheck-gcc-include-path (quote ("/usr/local/include" "/usr/include/c++")))
 '(flycheck-gcc-language-standard "c++2a")
 '(flycheck-gcc-pedantic nil)
 '(flycheck-gcc-pedantic-errors nil)
 '(flycheck-global-modes nil)
 '(flycheck-highlighting-mode (quote sexps))
 '(gdb-enable-debug t)
 '(gdb-many-windows nil)
 '(gdb-stopped-functions nil)
 '(global-auto-complete-mode nil)
 '(global-display-line-numbers-mode t)
 '(global-flycheck-mode nil)
 '(global-linum-mode nil)
 '(helm-completion-style (quote emacs))
 '(helm-file-preview-only-when-line-numbers nil)
 '(helm-scroll-amount 8)
 '(ibuffer-always-show-predicates nil)
 '(inhibit-startup-screen t)
 '(lsp-clients-clangd-args (quote ("-std=c++17")))
 '(lsp-java-code-generation-generate-comments t)
 '(lsp-ui-peek-always-show t)
 '(lsp-ui-peek-fontify (quote always))
 '(lsp-ui-sideline-enable t)
 '(lsp-ui-sideline-show-hover t)
 '(moo-select-method (quote helm))
 '(org-export-backends (quote (ascii html icalendar latex md odt org)))
 '(org-fontify-whole-heading-line t)
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
                 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(org-hide-leading-stars t)
 '(org-highlight-latex-and-related (quote (latex script entities)))
 '(org-pretty-entities t)
 '(org-return-follows-link t)
 '(org-src-fontify-natively t)
 '(org-todo-keywords (quote ((sequence "TODO" "DONE"))))
 '(package-selected-packages
   (quote
    (xwidgete orgalist latex-pretty-symbols company-emoji lsp-ui auto-complete flycheck dap-mode virtualenvwrapper lsp-python-ms elpy try ox-reveal zeno misc golden-ratio-mode auto-complete-config helm-config org-mode php-mode go-mode rustic rust-mode which-key htmlize lsp-java windswap markdown-mode+ markdown-preview-mode info-beamer org-edit-latex org-bullets helm-c-yasnippet engine-mode multi-term mandm-theme use-package dired-rainbow leetcode zeno-theme sexy-monochrome-theme reverse-theme minimal-theme github-modern-theme helm-file-preview yasnippet-snippets company-c-headers sr-speedbar imenus helm-gtags function-args ggtags floobits sudo-edit modern-cpp-font-lock dummyparens smartparens duplicate-thing yasnippet company monokai-pro-theme)))
 '(semantic-default-c-path (quote ("/usr/include/")))
 '(semantic-mode t)
 '(send-mail-function (quote mailclient-send-it))
 '(zeno-theme-enable-italics t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-warning ((t (:underline (:color "yellow" :style wave)))))
 '(hl-line ((t (:background "#343850"))))
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))
