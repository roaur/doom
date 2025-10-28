
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:

;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14)
      ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12)
      )
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; PROJECTILE CONFIG ;;
;; Tell Projectile where to find packages. I like to use ~/git/ as my project
;; dir, so this is where we'll tell it to look with a depth of 1.
(setq
 projectile-project-search-path '("~/git/")
 projectile-enable-caching t
 )

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Installed packages:
;; (require 'ejc-sql)

;; ;; Set up ejc-sql
;; (setq clomacs-httpd-default-port 8090)

;; ;; Set up ejc-autocomplete
;; (require 'ejc-autocomplete)
;; (add-hook 'ejc-sql-minor-mode-hook (
;;                                     lambda ()
;;                                     (auto-complete-mode t)
;;                                     (ejc-ac-setup)
;;                                     ))
;; Import PATH/PYENV_ROOT from your shell (but not PYENV_VERSION)
;; Ensure PATH/PYENV_ROOT is imported (macOS)
(when (memq window-system '(mac ns))
  (after! exec-path-from-shell
    (exec-path-from-shell-copy-envs '("PATH" "PYENV_ROOT"))))

;; Poetry: auto-track project venvs
(use-package! poetry
  :hook (python-mode . poetry-tracking-mode))

;; Let lsp-mode use Pyright; rely on the active venv’s "python"
(use-package! lsp-pyright
  :after lsp-mode
  :hook (python-mode . lsp-deferred)
  :init
  (setq lsp-disabled-clients '(pyls pylsp mspyls)) ; prefer pyright
  :config
  (setq lsp-pyright-python-executable-cmd "python")) ; comes from your Poetry/pyenv venv

;; Flycheck: use project mypy if present
(after! flycheck
  (setq flycheck-python-mypy-executable
        (expand-file-name ".venv/bin/mypy" (projectile-project-root))))

;; Keep Doom from freezing a specific VENV into its global env
(setq doom-env-deny '("^PYENV_VERSION$" "^VIRTUAL_ENV$"))

;; (use-package! drag_stuff
;;   :config
;;   (drag-stuff-global-mode 1) ; enable everywhere
;;   ;; meta-arrow
;;   (map!
;;         :nv "M-<up>" #'drag-stuff-up
;;         :nv "M-<down>" #'drag-stuff-down
;;         ;; Visual mode:
;;         :v "K" #'drag-stuff-up
;;         :v "J" #'drag-stuff-down
;;         )
;;   )

;; The key is stored in ~/.config/doom/.gptel-key so it is separate
;; from your main config files. Make sure this file is in your .gitignore."
;;   ;; Remove any whitespace or newline characters from the result.
;;   (string-trim
;;    ;; Create a temporary buffer, insert the file’s contents, then return it.
;;    (with-temp-buffer
;;      ;; Load the contents of the key file into the temp buffer.
;;      (insert-file-contents "~/.config/doom/.gptel-key")
;;      ;; Return everything as a string.
;;      (buffer-string))))
(map! :n "M-h" #'previous-buffer
      :n "M-l" #'next-buffer)

(after! lsp-ui
  (setq lsp-ui-peek-enable t
        lsp-ui-peek-always-show t
        lsp-ui-peek-peek-height 20
        lsp-ui-peek-list-width 50))
