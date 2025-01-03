;;; doom-pink.el --- inspired by Atom One Dark -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added October 3, 2024
;; Author: Jacob Janzen <https://github.com/JacobJanzen>
;; Maintainer: Jacob Janzen <https://github.com/JacobJanzen>
;;
;;; Commentary:
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-pink-theme nil
  "Options for the `doom-pink' theme."
  :group 'doom-themes)

(defcustom doom-pink-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-pink-theme
  :type 'boolean)

(defcustom doom-pink-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-pink-theme
  :type 'boolean)

(defcustom doom-pink-comment-bg doom-pink-brighter-comments
  "If non-nil, comments will have a subtle highlight to enhance their
legibility."
  :group 'doom-pink-theme
  :type 'boolean)

(defcustom doom-pink-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-pink-theme
  :type '(choice integer boolean))

(defcustom doom-pink-region-highlight t
  "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
  :group 'doom-pink-theme
  :type 'symbol)

;;
;;; Theme definition

(def-doom-theme doom-pink
                "A fun pink theme to annoy a friend."

                ;; name        default   256       16
                ((bg         '("#ff8cd9" nil       nil))
                 (bg-alt     '("#ff9c86" nil       nil))
                 (base0      '("#ccc075" "white"   "white"))
                 (base1      '("#94d4aa" "brightwhite" "brightwhite"))
                 (base2      '("#96d8e1" "brightwhite" "brightwhite"))
                 (base3      '("#c7d4ee" "brightwhite" "brightwhite"))
                 (base4      '("#e2d7e1" "brightwhite" "brightwhite"))
                 (base5      '("#87a0bd" "brightblack" "brightblack"))
                 (base6      '("#8c868c" "brightblack" "brightblack"))
                 (base7      '("#625d61" "brightblack" "brightblack"))
                 (base8      '("#373537" "black" "black"))
                 (fg         '("#0c0c0c" "black" "black"))
                 (fg-alt     '("#000000" "brightblack" "brightblack"))

                 (grey base4)
                 (red       '("#a80f20" "red" "red"))
                 (orange    '("#d91329" "brightred" "brightred"))
                 (green     '("#bafc8b" "green" "green"))
                 (teal      '("#d3ffaf" "brightgreen" "brightgreen"))
                 (yellow    '("#ffef50" "yellow" "yellow"))
                 (blue      '("#0075ea" "brightblue" "brightblue"))
                 (dark-blue '("#145fcd" "blue" "blue"))
                 (magenta   '("#9b215f" "magenta" "magenta"))
                 (violet    '("#ff36a2" "brightmagenta" "brightmagenta"))
                 (cyan      '("#79ecd5" "brightcyan" "brightcyan"))
                 (dark-cyan '("#6bd1bc" "cyan" "cyan"))

                 ;; face categories -- required for all themes
                 (highlight (doom-blend blue bg 0.8))
                 (vertical-bar (doom-darken bg 0.15))
                 (selection (doom-blend blue bg 0.5))
                 (builtin teal)
                 (comments (if doom-pink-brighter-comments dark-cyan (doom-darken base5 0.2)))
                 (doc-comments (doom-darken (if doom-pink-brighter-comments dark-cyan base5) 0.25))
                 (constants magenta)
                 (functions teal)
                 (keywords blue)
                 (methods teal)
                 (operators blue)
                 (type yellow)
                 (strings green)
                 (variables violet)
                 (numbers magenta)
                 (region (pcase doom-pink-region-highlight
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
                 (-modeline-bright doom-pink-brighter-modeline)
                 (-modeline-pad
                  (when doom-pink-padded-modeline
                    (if (integerp doom-pink-padded-modeline) doom-pink-padded-modeline 4)))

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
                  :background (if doom-pink-comment-bg (doom-lighten bg 0.05) 'unspecified))
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
                  :foreground (if (memq doom-pink-region-highlight '(frost snowstorm))
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
                ())


;;; doom-pink-theme.el ends here
