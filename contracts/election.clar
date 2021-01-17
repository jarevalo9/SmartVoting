;; candidate with most votes
(define-data-var highest-ranked-candidate (string-ascii 30) "")

;; mapping of candidates to vote count
(define-map canididate-vote-count {name: (string-ascii 30)}
 {count: int})

;; mapping of voters to candidates they voted for
(define-map voter-to-candidate {voter-name: (string-ascii 30)}
 {candidate-name: (string-ascii 30)})

;; checks is a user has voted yet
(define-private (has-voted (voter (string-ascii 30)))
 (is-some (get candidate-name (map-get? voter-to-candidate {voter-name: voter}))))

;; increases voter count, assuming the voter has not voted yet
(define-public (increase-vote-count (voter (string-ascii 30)) (candidate (string-ascii 30)))
 (if (has-voted voter)
  (ok false)
  (begin
    (map-set voter-to-candidate {voter-name: voter} {candidate-name: candidate})
    (let ((vote-count (candidate-vote-count candidate)))
      (begin
        (map-set canididate-vote-count {name: candidate} {count: (+ vote-count 1)})
        (if (> (candidate-vote-count candidate) (candidate-vote-count (var-get highest-ranked-candidate)))
         (ok (var-set highest-ranked-candidate candidate)) (ok true)))))))

;; get candidate vote count, or return 0
(define-private (candidate-vote-count (candidate (string-ascii 30)))
 (default-to 0 (get count (map-get? canididate-vote-count { name: candidate}))))

;; get leading candidate's name and vote count
(define-public (highest-vote-count)
  (ok {name: (var-get highest-ranked-candidate), count: (candidate-vote-count (var-get highest-ranked-candidate))}))

;; TESTS

;; (test= (highest-vote-count) (ok {name: "", count: 0}))

;; simulate voting
;; (test= (increase-vote-count "voter1" "candidate1") (ok true))
;; (test= (has-voted "voter1") true)
;; (test= (increase-vote-count "voter1" "candidate1") (ok false))
;; (test= (highest-vote-count) (ok {name: "candidate1", count: 1}))

;; (test= (has-voted "voter2") false)
;; (test= (increase-vote-count "voter2" "candidate1") (ok true))
;; (test= (highest-vote-count) (ok {name: "candidate1", count: 2}))

;; (test= (increase-vote-count "voter3" "candidate2") (ok true))
;; (test= (increase-vote-count "voter4" "candidate2") (ok true))
;; (test= (increase-vote-count "voter5" "candidate2") (ok true))
;; (test= (highest-vote-count) (ok {name: "candidate2", count: 3}))
