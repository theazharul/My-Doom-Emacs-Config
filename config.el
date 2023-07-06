;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Azhar Ibn Mostafiz"
      user-mail-address "theazharul@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 15))

(setq doom-font (font-spec :family "Source Code Pro" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-zenburn)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/aimacs/aimorg/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
;; Org Mode
;;
  (setq org-directory "~/Dropbox/aimacs/aimorg")

(after! org

  (defun org-clocking-buffer (&rest _))
  (setq org-startup-indented 'f)
  (setq org-special-ctrl-a/e 't)
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (define-key global-map "\C-cc" 'org-capture)
  (setq org-mobile-directory "~/Dropbox/aimacs/aimorg")
  (setq org-src-fontify-natively 't)
  (setq org-src-tab-acts-natively t)
  (setq org-src-window-setup 'current-window)
(setq org-agenda-start-on-weekday 5)

  (setq org-agenda-files (append
			       (directory-files-recursively "~/Dropbox/aimacs/aimorg/" "\\.org$")
			       (directory-files-recursively "~/Workspace/" "\\.org$")
  ))
  ;; TODO Keywords
  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "IN_PROGRESS(i)" "|" "DONE(d)")
		(sequence "NEXT(n)" "WAITING(w@/)" "DELEGATED(D)" "HOLD(h@/)" "|" "CANCELLED(c@/)")))
	org-global-properties '(("Effort_ALL". "0:10 0:15 0:20 0:30 1:00 2:00 3:00 4:00 6:00 8:00"))
	org-columns-default-format "%50ITEM(Task) %TODO %TAGS %SCHEDULED %DEADLINE %Effort(Estimated Effort){:} %CLOCKSUM"
	create-lockfiles nil
	org-archive-location "~/Dropbox/aimacs/aimorg/archive/archive.org::* From %s"
	org-refile-targets '((org-agenda-files :maxlevel . 3))
	org-capture-templates
	'(("i" "Inbox" entry (file+headline "~/Dropbox/aimacs/aimorg/inbox.org" "Inbox")
	    "* TODO %? \n")
	))

;; Agenda files. Change to your chosen file(s)
  (global-set-key (kbd "C-c a") 'org-agenda)



(use-package! org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename "~/Dropbox/aimacs/aimorg/org-roam/"))
  (org-roam-dailies-capture-templates
    '(("d" "default" entry "* %<%I:%M %p>: %?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package! org-brain :ensure t
  :init
  (setq org-brain-path "~/Dropbox/aimacs/aimorg/brain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))
  )

;; Allows you to edit entries directly from org-brain-visualize
;; (use-package! polymode
;;   :config
;;   (add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode))

(+global-word-wrap-mode +1)

(use-package! lsp-tailwindcss)
(use-package! graphql-mode)
