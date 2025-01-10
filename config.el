;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
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
(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :size 12 :weight 'semi-light))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
;;
;; Global keybindings for `[]` and `{}`
;; (map! :i "M-8" (lambda () (interactive) (insert "["))
;;       :i "M-9" (lambda () (interactive) (insert "]"))
;;       :i "S-M-8" (lambda () (interactive) (insert "{"))
;;       :i "S-M-9" (lambda () (interactive) (insert "}")))

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; Ensure the bindings also apply in c-mode
;; (after! cc-mode
;;   (map! :map c-mode-map
;;         :i "M-8" (lambda () (interactive) (insert "["))
;;         :i "M-9" (lambda () (interactive) (insert "]"))
;;         :i "S-M-8" (lambda () (interactive) (insert "{"))
;;         :i "S-M-9" (lambda () (interactive) (insert "}"))))

(setq display-line-numbers-type 'relative)
(setq doc-view-resolution 600) ; non-blurry doc-view PDFs

(after! consult
  (consult-customize
   consult-ripgrep
   :preview-key nil))

;;; config.el --- Your Doom Emacs Configuration -*- lexical-binding: t; -*-

;; LaTeX Configuration
(after! latex
  ;; Use latexmk for automatic compilation
  (setq TeX-command-default "LatexMk")

  ;; Use PDF Tools as the viewer
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-method 'synctex
        TeX-source-correlate-mode t)

  ;; Enable synctex correlation so that inverse and forward search works
  ;; (You can jump between PDF and TeX source)
  (setq TeX-source-correlate-start-server t)

  ;; Configure company backends for better completion (if using Company)
  (set-company-backend! 'latex-mode '(company-auctex company-yasnippet company-dabbrev))

  ;; Enable RefTeX for bibliographies and cross-references
  (add-hook 'LaTeX-mode-hook #'reftex-mode)
  (setq reftex-plug-into-AUCTeX t)

  ;; Automatically insert closing environments, math mode delimiters, etc.
  ;; If you have +cdlatex enabled in init.el, cdlatex-mode is already active,
  ;; but if not, uncomment the following line:
  ;; (add-hook 'LaTeX-mode-hook #'cdlatex-mode)

  ;; Use visual-line-mode for soft wrapping, which is often nicer for writing
  (add-hook 'LaTeX-mode-hook #'visual-line-mode)

  ;; Spell checking in LaTeX buffers (use `ispell` or `aspell` installed)
  (add-hook 'LaTeX-mode-hook #'flyspell-mode)
)
;; End LaTeX Configuration


;; Front Page Configuration
(setq +doom-dashboard-banner-file (expand-file-name "~/.config/doom/images/penger.png"))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; End Front Page Configuration

(after! org
  (setq org-file-apps
        '((auto-mode . emacs)
          ("\\.pdf\\'" . (lambda (file link) (find-file file))))))
