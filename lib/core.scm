; Core scheme functionality

(define builtin-define define)

(define defmacro
  (macro (head . body)
    (list (quote builtin-define)
          (car head)
          (cons (quote macro)
                (cons (cdr head)
                      body)))))

(defmacro (or2 x y)
  ((lambda (x y) (if x x y)) x y))

(defmacro (and2 x y)
  ((lambda (x y) (if x y x)) x y))

(defmacro (define head . body)
  (if (pair? head)
      (list (quote builtin-define)
            (car head)
            (cons (quote lambda)
                  (cons (cdr head)
                        body)))
      (cons (quote builtin-define) (cons head body))))

(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

(define (caaar x) (car (car (car x))))
(define (caadr x) (car (car (cdr x))))
(define (cadar x) (car (cdr (car x))))
(define (caddr x) (car (cdr (cdr x))))
(define (cdaar x) (cdr (car (car x))))
(define (cdadr x) (cdr (car (cdr x))))
(define (cddar x) (cdr (cdr (car x))))
(define (cdddr x) (cdr (cdr (cdr x))))

(define (string-append . strings) (reduce-left string-append-2 "" strings))
(define (memq obj list)
  (if (pair? list)
      (if (eq? (car list) obj)
          list
          (memq obj (cdr list)))
      #f))

(define *features* (quote (x86-scheme)))

(define (add-feature! feature)
  (if (memq feature *features*)
    (begin)
    (set! *features* (cons feature *features*))))

(define (has-feature? feature)
  (if (memq feature *features*) #t #f))

(define (map f list)
  (if (pair? list)
      (cons (f (car list)) (map f (cdr list)))
      (quote ())))

(define (assq elem list)
  (if (pair? list)
      (if (eq? (caar list) elem)
          (car list)
          (assq elem (cdr list)))
      #f))

(define (alist-copy l)
  (map (lambda (el) (cons (car el) (cdr el))) l))
