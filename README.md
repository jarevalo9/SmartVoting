# SmartVoting
A decentralized election system built with Smart Contracts!
## How it works
* The tally of votes for each candidate is held in a smart contract living in the blockchain.
* Users "vote" by sending a transaction and calling the `increase-vote-count` method. Our contract is designed such that each user can only vote once!
* At any time, users can query for the list of candidates/vote tallies as well as the winning candidate

## How to Run? 
* You can run the test by running the command on your bash terminal 
<br>`npm test`</br>
