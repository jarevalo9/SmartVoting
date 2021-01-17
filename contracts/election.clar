;; mapping of candidates to vote count
(define-map canididate-vote-count {name: (string-ascii 100)}
 {count: uint})

;; add single vote to candidate-name
(define-private (increase-vote-count (candidate-name (string-ascii 30)))
 (let ((vote-count (default-to 0 (get count (map-get? canididate-vote-count { name: candidate-name})))))
   (ok (map-set canididate-vote-count {name: candidate-name} {count: (+ vote-count 1)}))))

;; add mapping to candidate-voter
(define-private  body)

;;(test= (increase-vote-count "Peter"))

;;(test= (increase-vote-count "Michael"))

;;(test= (increase-vote-count "Peter"))
