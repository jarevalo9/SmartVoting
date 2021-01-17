;; mapping of candidates to vote count
(define-map canididate-vote-count {name: (string-ascii 100)}
 {count: uint})

;; mapping of voters to candidates they voted for
(define-map voter-to-candidate {voter-name: (string-ascii 100)}
 {candidate-name: (string-ascii 100)})

;; checks is a user has voted yet
(define-private (has-voted (voter (string-ascii 30)))
 (is-some (get candidate-name (map-get? voter-to-candidate {voter-name: voter}))))

;; add single vote to candidate-name, if the voter has not cast a vote yet
(define-private (increase-vote-count (voter (string-ascii 30)) (candidate (string-ascii 30)))
 (if (has-voted voter) (ok false)
  (begin
   (map-set voter-to-candidate {voter-name: voter} {candidate-name: candidate})
   (let ((vote-count (default-to 0 (get count (map-get? canididate-vote-count { name: candidate})))))
     (ok (map-set canididate-vote-count {name: candidate} {count: (+ vote-count 1)}))))))


(test= (increase-vote-count "voter1" "candidate1") (ok true))
(test= (has-voted "voter1") true)
(test= (increase-vote-count "voter1" "candidate1") (ok false));; cannot vote twice!

(test= (has-voted "voter2") false)
(test= (increase-vote-count "voter2" "candidate1") (ok true))


(test= (increase-vote-count "voter1" "candidate2"))
