(defvar *data* (mapcar (lambda (x) (mapcar #'parse-integer
                                           (split-sequence:split-sequence #\Space x)))
                       (uiop:read-file-lines "input.txt")))
(defun p (x) (if x (+ (car (last x)) (p (mapcar #'- (cdr x) x))) 0))
(defun p-t (x) (if x (- (car x) (p (mapcar #'- (cdr x) x))) 0))
(format t "~A" (apply #'+ (mapcar #'p *data*)))
