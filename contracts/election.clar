;; maximum number of valid candidates in the election
(define-constant max-num-candidates u4)

;; list of valid candidates in the election
(define-data-var valid-candidates
 (list max-num-candidates (string-ascii 30)) (list))

;; mapping of candidates to vote count
(define-map canididate-vote-count {name: (string-ascii 30)}
 {count: int})

<<<<<<< HEAD
;; add single vote to candidate-name
(define-private (increase-vote-count (candidate-name (string-ascii 30)))
 (let ((vote-count (default-to 0 (get count (map-get? canididate-vote-count { name: candidate-name})))))
   (ok (map-set canididate-vote-count {name: candidate-name} {count: (+ vote-count 1)}))))
=======
;; mapping of voters to candidates they voted for
(define-map voter-to-candidate {voter-name: (string-ascii 30)}
 {candidate-name: (string-ascii 30)})

;; add candidate to list of valid-candidates
(define-private (add-candidate (candidate (string-ascii 30)))
 (if (or (is-valid-candidate candidate) (is-eq (len (var-get valid-candidates)) max-num-candidates)) (ok false)
  (begin (var-set valid-candidates (append (var-get valid-candidates) candidate)) (ok true))))
>>>>>>> ee94d34936200950de3aff4df7d2b50e9fc2679b

;; add mapping to candidate-voter
(define-private  body)

<<<<<<< HEAD
;;(test= (increase-vote-count "Peter"))

;;(test= (increase-vote-count "Michael"))

;;(test= (increase-vote-count "Peter"))
=======
(define-private (increase-vote-count (voter (string-ascii 30)) (candidate (string-ascii 30)))
 (if (or (has-voted voter) (is-none (index-of (var-get valid-candidates) candidate)))
  (ok false)
  (begin
    (map-set voter-to-candidate {voter-name: voter} {candidate-name: candidate})
    (let ((vote-count (candidate-vote-count candidate)))
      (ok (map-set canididate-vote-count {name: candidate} {count: (+ vote-count 1)}))))))

;; determines whether candidate is in valid-candidate or not
(define (is-valid-candidate (candidate (string-ascii 30))) (not (is-none (index-of (var-get valid-candidates) candidate))))


;; get candidate vote count, or return 0
(define-public (candidate-vote-count (candidate (string-ascii 30)))
 (default-to 0 (get count (map-get? canididate-vote-count { name: candidate}))))

;; TESTS

;; add candidates to list of viable candidates
(test= (add-candidate "candidate1") (ok true))
(test= (add-candidate "candidate1") (ok false))   ;; can only add unique candidates!
(test= (add-candidate "candidate2") (ok true))
(test= (add-candidate "candidate3") (ok true))
(test= (add-candidate "candidate4") (ok true))
(test= (add-candidate "candidate5") (ok false))   ;; can only add 4 candidates!

;; simulate voting
(test= (increase-vote-count "voter1" "candidate1") (ok true))
(test= (has-voted "voter1") true)
(test= (increase-vote-count "voter1" "candidate1") (ok false))

(test= (has-voted "voter2") false)
(test= (increase-vote-count "voter2" "candidate1") (ok true))
>>>>>>> ee94d34936200950de3aff4df7d2b50e9fc2679b
