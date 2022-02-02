;;; package --- Finds the numerological value of a string
;;; Commentary:
;; =============================================================================
;; Numerlogizer
;; =============================================================================
;; Written by Jeff Russell
;; Updated: 2022-02-01 0008
;; jpowellrussell.com
;; -----------------------------------------------------------------------------

;;; Code:
(require 'cl)

(defun numerologizer-number-to-list (number)
  "Turn a multi-digit NUMBER into a list of its digits."
  (map 'list (lambda (c)(or (cl-digit-char-p c) '-)) (prin1-to-string number)))

(defun numerologizer-sum-list-items (l)
  "Sum items in list L together."
  (let ((s 0))
    (dolist (n l)
      (setf s (+ n s)))
    s))

(defun numerologizer-build-hash ()
  "Build a hash table of numerological values for letters.
Follows the Pythagorean, not Chaldean, correspondences."
  #s(hash-table
     size 60
     test equal
     data (
           "a" 1 "b" 2 "c" 3 "d" 4 "e" 5 "f" 6 "g" 7 "h" 8 "i" 9
           "j" 1 "k" 2 "l" 3 "m" 4 "n" 5 "o" 6 "p" 7 "q" 8 "r" 9
           "s" 1 "t" 2 "u" 3 "v" 4 "w" 5 "x" 6 "y" 7 "z" 8
           "1" 1 "2" 2 "3" 3 "4" 4 "5" 5 "6" 6 "7" 7 "8" 8 "9" 9
           " " 0 "," 0 "." 0 "/" 0 ";" 0 ":" 0 "<" 0 ">" 0 "?" 0
           "[" 0 "]" 0 "{" 0 "}" 0 "|" 0 "\\" 0 "`" 0 "~" 0 "!" 0
           "@" 0 "#" 0 "$" 0 "%" 0 "^" 0 "&" 0 "*" 0 "(" 0 ")" 0
           "-" 0 "_" 0 "=" 0 "+" 0)))

(defun numerologizer-get-numerological-values (string)
  "Get numerological values for letters from STRING, return list of numbers."
  (let ((c-number 0)
        (num-list (list 0))
        (sum 0)
        (numerology-hash (numerologizer-build-hash)))
    ;; for some reason, any use of numerologizer is throwing an error until I evaluate this buffer directly, with the message "Symbol's value as variable is void: for", which I assume has something to do with the common lisp package not being loaded yet? Maybe I need to require cl?
    (cl-loop for c across string do
             (progn
               (setf c-number (gethash (char-to-string c) numerology-hash 0))
               (setf num-list (cons c-number num-list))))
    (reverse num-list)))

(defun numerologizer (string)
  "Return the numerological value of a STRING."
  (let ((final-sum 10)
        (letter-nums (list 0))
        (interim-list (list 0))
        (letter-sum 0))
    (progn
      (setf letter-nums (numerologizer-get-numerological-values string))
      (setf interim-list letter-nums)
      (while (> final-sum 9)
        (setf final-sum (numerologizer-sum-list-items interim-list))
        (setf interim-list (numerologizer-number-to-list final-sum))))
    final-sum))

(defun numerologizer-prompt (string)
  "Print the numerological value of prompted STRING."
  (interactive "sString to find the numerological value of: ")
  (let ((value ""))
    (setf value (numerologizer string))
    (message "The numerological value of %s is %s" string value)))
(provide 'numerologizer)

;;; numerologizer.el ends here
