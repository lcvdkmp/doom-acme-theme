;;; doom-acme-theme.el --- Inspired by Doom Solarized Light and Acme-*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Luca
;; Version: 0.1.0
;; Keywords: custom themes, faces
;; Homepage: https://github.com/lcvdkmp/doom-acme-theme
;; Package-Requires: ((emacs "25.1") (cl-lib "0.5") (doom-themes "2.2.1"))
;;
;;; Commentary:
;;
;; Inspired by the acme editor, acme-theme.el (https://github.com/ianyepan/acme-emacs-theme), and doom-solarized-light
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-acme-theme nil
  "Options for the `doom-acme' theme."
  :group 'doom-themes)

(defcustom doom-acme-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-acme-theme
  :type 'boolean)

(defcustom doom-acme-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-acme-theme
  :type 'boolean)

(defcustom doom-acme-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-acme-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme doom-acme
  "A light theme inspired by Solarized light"

  ;; name        default   256       16
  ((bg         '("#FFFFE8" "#FFFFE8" "white"        ))
   (fg         '("#000000" "#000000" "black"        ))

   ;; These are off-color variants of bg/fg, used primarily for `solaire-mode',
   ;; but can also be useful as a basis for subtle highlights (e.g. for hl-line
   ;; or region), especially when paired with the `doom-darken', `doom-lighten',
   ;; and `doom-blend' helper functions.
   (bg-alt     '("#EFEFD8" "#EFEFD8" "white"        ))
   (fg-alt     '("#988D6D" "#988D6D" "black"  ))

   (bg2        '("#e1faff" "#e1faff" "white"))
   (bg2-alt        '("#a8efeb" "#a8efeb" "white"))

   ;; These should represent a spectrum from bg to fg, where base0 is a starker
   ;; bg and base8 is a starker fg. For example, if bg is light grey and fg is
   ;; dark grey, base0 should be white and base8 should be black.
   (base0      '("white" "white" "white"        ))
   (base1      '("#eeeed7" "#eeeed7" "brightblack"  ))
   (base2      '("#dddec7" "#dddec7" "brightblack"  ))
   (base3      '("#cdcdb7" "#cdcdb7" "brightblack"  ))
   (base4      '("#bdbda7" "#bdbda7" "brightblack"  ))
   (base5      '("#9d9d88" "#9d9d88" "brightblack"  ))
   (base6      '("#70705c" "#70705c" "brightblack"  ))
   (base7      '("#1f200f" "#1f200f" "brightblack"  ))
   (base8      '("black" "black" "black"        ))

   (grey       base4)
   (red        '("#dc322f" "#dc322f" "red"          ))
   (orange     '("#cb4b16" "#cb4b16" "brightred"    ))
   (green      '("#007700" "#007700" "green"        ))
   (teal       '("#c4d8c4" "#c4d8c4" "brightgreen"  ))
   (yellow     '("#888838" "#888838" "yellow"       ))
   (blue       '("#1054af" "#1054af" "brightblue"   ))
   (dark-blue  '("#0024af" "#0024af" "blue"         ))
   (magenta    '("#562356" "#562356" "magenta"      ))
   (violet     '("#555599" "#555599" "brightmagenta"))
   (cyan       '("#388f8b" "#388f8b" "brightcyan"   ))
   (dark-cyan  '("#006666" "#006666" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   base4)
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-acme-brighter-comments
                       (doom-lighten teal 0.25)
                     base6))
   (doc-comments   green)
   (constants      magenta)
   (functions      violet)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        red)
   (variables      blue)
   (numbers        cyan)
   (region         `(,(doom-darken (car bg-alt) 0.1) ,@(doom-darken (cdr base0) 0.1)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-bright doom-acme-brighter-modeline)
   (-modeline-pad
    (when doom-acme-padded-modeline
      (if (integerp doom-acme-padded-modeline) doom-acme-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        bg2
      (doom-darken bg 0.05)))
   (modeline-bg-alt
    (if -modeline-bright
        (doom-lighten bg 0.7)
      (doom-lighten base3 0.2)))
   (modeline-bg-inactive     (doom-darken bg 0.025))
   (modeline-bg-inactive-alt (doom-darken bg 0.02)))


  ;;;; Base theme face overrides
  (((font-lock-comment-face &override)
    :slant 'italic
    :background (if doom-acme-brighter-comments
                    (doom-blend teal base0 0.07)))
   ((font-lock-type-face &override) :slant 'italic)
   ((font-lock-builtin-face &override) :slant 'italic)
   ((font-lock-function-name-face &override) :foreground type)
   ((font-lock-keyword-face &override) :weight 'bold)
   ((font-lock-constant-face &override) :weight 'bold)
   (hl-line :background base3)
   ((line-number &override) :foreground base6)
   ((line-number-current-line &override) :foreground fg :background region :weight 'bold)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-evil-emacs-state  :foreground magenta)
   (doom-modeline-evil-insert-state :foreground blue)

   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-alt)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-alt)))

   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;;;; lsp-ui
   (lsp-ui-sideline-code-action :foreground blue)

   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;;;; ivy
   (ivy-current-match :background (doom-lighten yellow 0.65) :distant-foreground fg)
   (ivy-minibuffer-match-face-1 :foreground blue :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-2 :foreground magenta :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-3 :foreground green   :background base3 :weight 'bold)
   (ivy-minibuffer-match-face-4 :foreground yellow  :background base3 :weight 'bold)
   (ivy-minibuffer-match-highlight :foreground violet :weight 'bold)

   ;;;; ivy-posframe
   (ivy-posframe :background modeline-bg-alt)

   ;;;; swiper
   (swiper-match-face-1 :inherit 'ivy-minibuffer-match-face-1)
   (swiper-match-face-2 :inherit 'ivy-minibuffer-match-face-2)
   (swiper-match-face-3 :inherit 'ivy-minibuffer-match-face-3)
   (swiper-match-face-4 :inherit 'ivy-minibuffer-match-face-4)

   ;;;; helm
   (helm-selection :foreground base0 :weight 'bold :background blue)

   ;;;; company
   (company-tooltip                              :background bg2)

   ;; (company-box-background :background bg2)
   (company-tooltip-selection                    :background bg2-alt)
   (company-tooltip-common-selection             :foreground blue :background bg2-alt :bold t)
   (company-tooltip-mouse                        :background bg2)
   (company-tooltip-search                       :foreground red)
   (company-tooltip-common                       :foreground blue :bold t)
   (company-tooltip-annotation                   :foreground yellow :italic t) ; parameter hints etc.
   (company-tooltip-annotation-selection         :foreground yellow :italic t)
   (company-scrollbar-fg                         :background cyan)
   (company-scrollbar-bg                         :background bg2-alt)
   (company-preview                              :foreground fg :background bg2-alt)
   (company-preview-common                       :foreground fg :background bg2-alt :underline t)

   ;;;; org <built-in>
   (org-block :background (doom-blend fg-alt bg-alt 0.00) :extend t)
   (org-block-background :background (doom-blend fg-alt bg-alt 0.00))
   (org-block-begin-line :foreground (doom-darken (doom-blend fg-alt bg-alt 0.08) 0.4) :background (doom-blend fg-alt bg-alt 0.08) :extend t)
   (org-block-end-line :foreground (doom-darken (doom-blend fg-alt bg-alt 0.08) 0.4) :background (doom-blend fg-alt bg-alt 0.08) :extend t)
   (org-document-info :foreground dark-cyan)
   (org-document-info-keyword :foreground dark-cyan :underline t)
   (org-cite :foreground cyan)
   (org-cite-key :foreground dark-cyan :underline t)
   (org-level-1 :foreground fg)
   (org-headline-done :foreground green)
   (org-agenda-done :foreground green)
   (org-link :foreground blue :weight 'normal)
   (org-superstar-header-bullet :weight 'normal)

   ;;;; widget
   (widget-field :foreground fg :background base3)
   (widget-single-line-field :foreground fg :background base3)

   ;;;; latex
   (font-latex-sedate-face :foreground base6)

   ;;;; notmuch
   (notmuch-message-summary-face :foreground teal)
   (notmuch-wash-cited-text :foreground base6)
   (cursor :foreground fg)

   ;;;; which-key
   (which-key-command-description-face :foreground fg)
   (which-key-highlight-command-face :foreground fg :underline t)
   (which-key-group-description-face :foreground dark-blue)
   (which-key-key-face :weight 'bold)

   ;;;; dashboard
   (doom-dashboard-menu-title :foreground fg)
   (doom-dashboard-menu-desc :foreground dark-blue)

   ;;;; Vertico
   (vertico-group-title :foreground base7 :slant 'italic)
   (marginalia-number :foreground cyan)
   (marginalia-null :foreground base6)

   ;;;; magit
   (magit-branch-current
    :foreground dark-cyan :background bg2 :weight 'normal :box '(:line-width 1 :color dark-cyan))
   (magit-branch-local
    :foreground cyan :background bg2 :weight 'normal :box '(:line-width 1 :color cyan))
   (magit-branch-remote
    :foreground green :background teal :weight 'normal :box '(:line-width 1 :color green))
   (magit-branch-remote-head
    :foreground green :background teal :weight 'bold :box '(:line-width 1 :color green))
   (magit-branch-upstream :box '(:line-width 1 :color fg))
   (diff-refine-added :background "#b8fcb8")
   (diff-refine-removed :background "#f8a8a8")))

;;; doom-acme-theme.el ends here
