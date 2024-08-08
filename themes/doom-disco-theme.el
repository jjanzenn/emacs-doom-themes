;;; doom-disco.el --- inspired by Atom One Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Jacob Janzen
;;
;;; Commentary:
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-disco-theme nil
  "Options for the `doom-disco' theme."
  :group 'doom-themes)

(defcustom doom-disco-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-disco-theme
  :type 'boolean)

(defcustom doom-disco-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-disco-theme
  :type 'boolean)

(defcustom doom-disco-comment-bg doom-disco-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
  :group 'doom-disco-theme
  :type 'boolean)

(defcustom doom-disco-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-disco-theme
  :type '(choice integer boolean))

(defcustom doom-disco-region-highlight t
  "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
  :group 'doom-disco-theme
  :type 'symbol)

;;
;;; Theme definition

(def-doom-theme doom-disco
                "A light theme inspired by Disco Elysium."


                ;; name        default   256       16
                ((bg         '("#ece0c9" nil       nil))
                 (bg-alt     '("#f4e6d1" nil       nil))
                 (base0      '("#fdfcf6" "white"   "white"))
                 (base1      '("#ece0c9" "brightwhite" "brightwhite"))
                 (base2      '("#eed5ac" "brightwhite" "brightwhite"))
                 (base3      '("#d2caa1" "brightwhite" "brightwhite"))
                 (base4      '("#cfbc8c" "brightwhite" "brightwhite"))
                 (base5      '("#c6ad76" "brightblack" "brightblack"))
                 (base6      '("#7d5b4b" "brightblack" "brightblack"))
                 (base7      '("#303f49" "brightblack" "brightblack"))
                 (base8      '("#191916" "black" "black"))
                 (fg         '("#191916" "black" "black"))
                 (fg-alt     '("#0f1013" "brightblack" "brightblack"))

                 (grey base4)
                 (red       '("#ac4438" "red" "red"))
                 (orange    '("#d8611c" "brightred" "brightred"))
                 (green     '("#354d52" "green" "green"))
                 (teal      '("#4b7b53" "brightgreen" "brightgreen"))
                 (yellow    '("#ba9151" "yellow" "yellow"))
                 (blue      '("#3B6EA8" "brightblue" "brightblue"))
                 (dark-blue '("#465b91" "blue" "blue"))
                 (magenta   '("#5b5489" "magenta" "magenta"))
                 (violet    '("#735e82" "brightmagenta" "brightmagenta"))
                 (cyan      '("#6b8f92" "brightcyan" "brightcyan"))
                 (dark-cyan '("#4e6062" "cyan" "cyan"))

                 ;; face categories -- required for all themes
                 (highlight (doom-blend blue bg 0.8))
                 (vertical-bar (doom-darken bg 0.15))
                 (selection (doom-blend blue bg 0.5))
                 (builtin teal)
                 (comments (if doom-disco-brighter-comments dark-cyan (doom-darken base5 0.2)))
                 (doc-comments (doom-darken (if doom-disco-brighter-comments dark-cyan base5) 0.25))
                 (constants magenta)
                 (functions teal)
                 (keywords blue)
                 (methods teal)
                 (operators blue)
                 (type yellow)
                 (strings green)
                 (variables violet)
                 (numbers magenta)
                 (region (pcase doom-disco-region-highlight
                           ((\` frost) (doom-lighten teal 0.5))
                           ((\` snowstorm) base0)
                           (_ base4)))
                 (error red)
                 (warning yellow)
                 (success green)
                 (vc-modified orange)
                 (vc-added green)
                 (vc-deleted red)

                 ;; custom categories
                 (hidden `(,(car bg) "black" "black"))
                 (-modeline-bright doom-disco-brighter-modeline)
                 (-modeline-pad
                  (when doom-disco-padded-modeline
                    (if (integerp doom-disco-padded-modeline) doom-disco-padded-modeline 4)))

                 (modeline-fg 'unspecified)
                 (modeline-fg-alt base6)

                 (modeline-bg
                  (if -modeline-bright
                      (doom-blend bg blue 0.7)
                    `(,(doom-darken (car bg) 0.02) ,@(cdr base0))))
                 (modeline-bg-l
                  (if -modeline-bright
                      (doom-blend bg blue 0.7)
                    `(,(doom-darken (car bg) 0.03) ,@(cdr base0))))
                 (modeline-bg-inactive   `(,(car bg) ,@(cdr base1)))
                 (modeline-bg-inactive-l (doom-darken bg 0.01)))


  ;;;; Base theme face overrides
                (((font-lock-comment-face &override)
                  :background (if doom-disco-comment-bg (doom-lighten bg 0.05) 'unspecified))
                 ((line-number &override) :foreground (doom-lighten 'base5 0.2))
                 ((line-number-current-line &override) :foreground base7)
                 (internal-border :foreground (doom-blend blue bg 0.2) :background (doom-blend blue bg 0.2))
                 (mode-line
                  :background modeline-bg :foreground modeline-fg
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
                 (mode-line-inactive
                  :background modeline-bg-inactive :foreground modeline-fg-alt
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
                 (mode-line-emphasis
                  :foreground (if -modeline-bright base8 highlight))
                 ((region &override)
                  :foreground (if (memq doom-disco-region-highlight '(frost snowstorm))
                                  bg-alt
                                'unspecified))

   ;;;; css-mode <built-in> / scss-mode <built-in>
                 (css-proprietary-property :foreground orange)
                 (css-property :foreground green)
                 (css-selector :foreground blue)
   ;;;; doom-modeline
                 (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
                 (doom-modeline-project-root-dir :foreground base6)
   ;;;; elscreen
                 (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; ivy
                 (ivy-minibuffer-match-face-1 :foreground (doom-blend fg bg 0.5) :weight 'light)
                 (ivy-virtual :foreground (doom-blend blue bg 0.8))
   ;;;; ivy-posframe
                 (ivy-posframe :background (doom-blend blue bg 0.2))
   ;;;; magit
                 (magit-diff-hunk-heading-highlight :foreground bg :background blue :weight 'bold)
                 (magit-diff-hunk-heading :foreground bg :background (doom-blend blue bg 0.3))
   ;;;; markdown-mode
                 (markdown-markup-face :foreground base5)
                 (markdown-header-face :inherit 'bold :foreground red)
                 ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; mic-paren
                 ((paren-face-match &override) :foreground red :background base3 :weight 'ultra-bold)
                 ((paren-face-mismatch &override) :foreground base3 :background red :weight 'ultra-bold)
   ;;;; nav-flash
                 (nav-flash-face :background region :foreground base8 :weight 'bold)
   ;;;; org <built-in>
                 (org-hide :foreground hidden)
   ;;;; solaire-mode
                 (solaire-mode-line-face
                  :inherit 'mode-line
                  :background modeline-bg-l
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
                 (solaire-mode-line-inactive-face
                  :inherit 'mode-line-inactive
                  :background modeline-bg-inactive-l
                  :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; vimish-fold
                 ((vimish-fold-fringe &override) :foreground teal)
                 ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light))

  ;;;; Base theme variable overrides-
                ()
                )

;;; doom-disco-theme.el ends here
