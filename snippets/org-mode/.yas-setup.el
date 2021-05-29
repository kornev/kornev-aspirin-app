(defun yas-touch-file (dir suffix)
  (let ((temporary-file-directory dir))
    (unless (file-exists-p temporary-file-directory)
      (make-directory temporary-file-directory))
    (make-temp-file nil nil suffix)))

(defun yas-touch-png ()
  (substring (yas-touch-file "./img/" ".png") 2))
