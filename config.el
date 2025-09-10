;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Azhar Ibn Mostafiz"
      user-mail-address "theazharul@gmail.com")

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
(setq doom-font (font-spec :family "Fira Code" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 22))
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
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;
;; Org mode configuration
;; (defvar my-org-dir "~/Sync/aimacs/aimorg" "Directory for Org files")
(setq my-org-dir "~/Sync/aimacs/aimorg")  ; Define my-org-dir first

(setq org-directory my-org-dir
      org-use-sub-superscripts nil
      org-log-done t
      org-startup-indented t
      org-hide-leading-stars t
      org-pretty-entities t
      org-mobile-directory org-directory
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-src-window-setup 'current-window
      org-agenda-start-on-weekday 5
      org-default-notes-file (concat my-org-dir "/0.Inbox.org")
      org-special-ctrl-a/e t
      org-agenda-files
      (remove (concat my-org-dir "/4.Archives.org")
              (append (directory-files-recursively my-org-dir "\\.org$")
                      (directory-files-recursively "~/Workspace/" "\\.org$")))
      org-todo-keywords '((sequence "TODO(t)" "IN_PROGRESS(i)" "IN_REVIEW(r)" "|" "DONE(d)")
                          (sequence "NEXT(n)" "WAITING(w@/)" "DELEGATED(D)" "HOLD(h@/)" "|" "CANCELLED(c@/)"))
      org-global-properties '(("Effort_ALL" . "0:10 0:15 0:20 0:30 1:00 2:00 3:00 4:00 6:00 8:00"))
      org-columns-default-format "%50ITEM(Task) %TODO %TAGS %SCHEDULED %DEADLINE %Effort(Estimated Effort){:} %CLOCKSUM"
      org-archive-location (concat my-org-dir "/4.Archives.org::* From %s")
      org-refile-targets '((org-agenda-files :maxlevel . 3))
      org-capture-templates
      `(("i" "Inbox" entry
         (file+headline ,(expand-file-name "0.Inbox.org" my-org-dir) "Inbox")
         "*  %?\n  %i\n  %a"))
      org-agenda-window-setup 'current-window)

;; Org Roam
(after! org-roam
  (setq org-roam-directory (file-truename "~/Sync/aimacs/aimorg/org-roam/")
        org-roam-completion-everywhere t
        org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%dT%H%M>--${slug}.org"
                              "#+title: ${title}\n#+date: %U\n#+roam_tags:\n\n")
           :unnarrowed t))
        org-roam-dailies-directory "dailies/"
        org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :if-new (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n#+filetags: :journal:\n\n")))

        ;; Org roam ui config
        org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        ))

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
