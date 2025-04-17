;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
 (setq user-full-name "Jakub Mandula"
       user-mail-address "jakub@mandula.cz")

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
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
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
(setq display-line-numbers-type 'relative)

(setq evil-want-fine-undo t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(defun my/org-agenda-get-files (dir)
   "Return a list of all .org files recursively from DIR."
   (directory-files-recursively dir "\\.org$"))

(setq org-directory "~/Documents/org/"
      org-roam-directory "~/Documents/RoamNotes"
      org-roam-dailies-directory "journal/"
      org-roam-db-location (file-name-concat org-roam-directory ".org-roam.db")
     ;; org-archive-location (file-name-concat org-directory ".archive/%s::")
      org-agenda-files (append (my/org-agenda-get-files org-directory) (my/org-agenda-get-files org-roam-directory))
      org-attach-id-dir (file-name-concat org-roam-directory ".attach"))
(after! org
	(require 'org-bullets)
	(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
        (setq org-startup-with-inline-images t
         org-startup-with-latex-preview t)
)


(after! org-roam
  (setq org-roam-node-display-template "${title:*} ${tags:10}")
  (setq org-roam-capture-templates
        `(("d" "default" plain
           ,(format "#+title: ${title}\n%%[%s/.template/default.org]" org-roam-directory)
           :target (file "%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("f" "definition" plain
           ,(format "#+title: ${title}\n%%[%s/.template/definition.org]" org-roam-directory)
           :target (file "definitions/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("n" "note" plain
           ,(format "#+title: ${title}\n%%[%s/.template/note.org]" org-roam-directory)
           :target (file "note/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("t" "thought" plain
           ,(format "#+title: ${title}\n%%[%s/.template/thought.org]" org-roam-directory)
           :target (file "thought/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("p" "project" plain
           ,(format "#+title: ${title}\n%%[%s/.template/project.org]" org-roam-directory)
           :target (file "projects/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("a" "paper" plain
           ,(format "#+title: ${title}\n%%[%s/.template/paper.org]" org-roam-directory)
           :target (file "paper/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)
          ("s" "student" plain
           ,(format "#+title: ${title}\n#+date: %%U\n#+filetags: student\n\n* Tasks\n** TODO Set up server access for ${title} \n** TODO ${title} Kickoff meeting\n** TODO ${title} Task description\n\n %%[%s/.template/student.org]" org-roam-directory)
           :target (file "phd/%<%Y%m%d%H%M%S>-${slug}.org")
           :unnarrowed t)))
;;          ("i" "invoice" plain
;;           ,(format "#+title: %%<%%Y%%m%%d>-${title}\n%%[%s/.template/invoice.org]" org-roam-directory)
;;           :target (file "invoice/%<%Y%m%d>-${slug}.org")
;;           :unnarrowed t)
;;          ("c" "contact" plain
;;           ,(format "#+title: ${title}\n%%[%s/.template/contact.org]" org-roam-directory)
;;           :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
;;           :unnarrowed t)
        ;; Use human readable dates for dailies titles
;;        org-roam-dailies-capture-templates
;;        `(("d" "default" plain ""
;;           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" ,(format "%%[%s/template/default.org]" org-roam-directory))))))
)

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("🟥" "🟧" "🟨")))



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

(setq default-frame-alist (append (list '(width . 72) '(height . 40))))
(setq help-window-select t)

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

;;(add-hook 'org-mode-hook #'org-modern-mode)
;;(add-hook 'org-agenda-finalize-hook #'org-agenda-modern)

;;(setq org-agenda-prefix-format '((agenda . "  %-12t  ")))


(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


