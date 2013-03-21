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
  ;; consider adding 'words to this call
  (regexp-opt (split-string strings "\n" t)))

(defun flex-insert-or-expression ()
  "Insert another expression separated by the or symbol (`|')."
  (interactive)
  (insert " |\n"))

(defconst flex-font-lock-keywords
  `((,(flex-make-regexp-opt "%%
%option
%{
%}") . font-lock-keyword-face)
    (,(flex-make-regexp-opt "")))
  "A list of Flex keywords.")

(define-derived-mode flex-mode fundamental-mode "Flex"
  (set (make-local-variable 'font-lock-defaults)
       '(flex-font-lock-keywords))
  ;; The variable `flex-mode-map' is automatically created by
  ;; `define-derived-mode'.
  (define-key flex-mode-map (kbd "M-RET") 'flex-insert-or-expression))

(provide 'flex-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flex-mode.el ends here
