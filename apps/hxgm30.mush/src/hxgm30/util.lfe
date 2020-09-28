(defmodule hxgm30.util
  (export
   (confirmation-code 1)
   (uuid3 1) (uuid3 2)
   (uuid4 0) (uuid4 1)
   (uuid->ascii-quad 1)))

(defun ascii-a () 65)
(defun alphabet-len () 25)

(defun uuid3 (data)
  (uuid3 data #m()))

(defun uuid3
  ((data opts) (when (is_list data))
   (uuid3 (list_to_binary data) opts))
  ((data `#m(return string))
   (uuid:uuid_to_string (uuid:get_v3 data)))
  ((data _)
   (uuid:get_v3 data)))

(defun uuid4 ()
  (uuid4 #m()))

(defun uuid4
  ((`#m(return string))
   (uuid:uuid_to_string (uuid:get_v4 'strong)))
  ((_)
   (uuid:get_v4)))

(defun confirmation-code
  ((data) (when (is_list data))
   (confirmation-code (list_to_binary data)))
  ((data)
   (++ (uuid->ascii-quad (uuid3 data))
       "-"
       (uuid->ascii-quad (uuid4)))))

(defun ->ascii-upper (int-list)
  (+ (ascii-a) (rem (lists:sum int-list) (alphabet-len))))

(defun uuid->ascii-quad
  ((data) (when (not (is_binary data)))
   #(error "UUID must be in binary form"))
  ((data)
   (lists:map #'->ascii-upper/1
              (clj:partition 4 (binary:bin_to_list data)))))