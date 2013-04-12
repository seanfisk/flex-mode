;;; flex-mode.el --- Major mode for Flex lexical analyzer files
;;
;; Author: Jordon Biondo, Sean Fisk
;; URL: https://github.com/seanfisk/flex-mode
;; Keywords: c, languages, tools, unix
;; Compatibility: Emacs 24.x
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Provide a major mode for Flex files.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defun flex-make-regexp-opt (strings)
  "Make a regexp to match a string in STRINGS.
STRINGS should have one string per line."
  ;; consider adding 'words or 'symbols to this call
  (regexp-opt (split-string strings "\n" t)))

(defun flex-insert-or-expression ()
  "Insert another expression separated by the or symbol (`|')."
  (interactive)
  (delete-horizontal-space)
  (insert " |\n"))


(defun flex-jump-block()
  "Jump forward to the next flex section delimiter, wrap to the top of the buffer if needed"
  (interactive)
  (let ((new-pos nil))
    (save-excursion
      (setq new-pos (search-forward-regexp flex-section-delimiters nil t))
      (if (not new-pos)
	  (progn (beginning-of-buffer)
		 (setq new-pos (search-forward-regexp flex-section-delimiters nil t)))))
    (if new-pos (goto-char new-pos))))


(defconst flex-section-delimiters "\\(\\%%\\|%}\\|%{\\)"
  "Regexp matching flex section delimiters %{ %} and %%")


(defconst flex-font-lock-keywords
  `((,(flex-make-regexp-opt "%option") . font-lock-keyword-face)
    (,flex-section-delimiters . font-lock-constant-face))
  "A list of Flex keywords.")

(define-derived-mode flex-mode c-mode "Flex"
  ;; CC Mode has three levels of fontification. Level 3 is the most
  ;; accurate, so that's the one we'd like to use. CC Mode also does
  ;; some other stuff with `font-lock-defaults' that we want to keep,
  ;; so we just set the car of it to be our keywords plus the CC Mode
  ;; level 3 keywords. This somewhat likely to change later because
  ;; the other elements of `font-lock-defaults' will also be important
  ;; to customize.
  (setcar font-lock-defaults (append flex-font-lock-keywords c-font-lock-keywords-3))
  ;; The variable `flex-mode-map' is automatically created by
  ;; `define-derived-mode'.
  (define-key flex-mode-map (kbd "M-RET") 'flex-insert-or-expression)
  (easy-menu-define flex-menu flex-mode-map "Flex Mode menu"
    '("Flex"
      :help "Flex-specific features"
      ["Insert Alternative" flex-insert-or-expression
       :help "Insert a | and move to the next line."])))

(provide 'flex-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flex-mode.el ends here
