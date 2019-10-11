/*
Syed Gilani - 500774969
Shail Patel - 500766622
Parth Patel - 500588969
*/

dependants(2).
saved(18000).
cash(1000).
earnings(10000).
minSavings(D,M):- dependants(D), M is D*9000.
minIncome(D,M) :- dependants(D), M is (D*8000+25000).

savingsAdequate(Amount, D, Min):- minSavings(D,Min), saved(Amount), (Amount>=Min) .
incomeAdequate(Amount, D, Min) :- minIncome(D,Min), earnings(Amount), Amount>=Min.

save(What) :- \+incomeAdequate(Amountsaved, D, Min), savingsAdequate(Amountincome, D, Min2), cash(S), What is S*0.2.
save(What) :- savingsAdequate(Amount,D,Min) , cash(C), What is C/2.
save(What) :- \+savingsAdequate(Amount,D,Min), cash(What).

invest(What) :-  \+incomeAdequate(Amountsaved, D, Min), savingsAdequate(Amountincome, D, Min2), cash(S), What is S*0.8.
invest(What) :- savingsAdequate(Amount, D, Min), cash(C), What is C/2.
invest(What) :- \+savingsAdequate(Amount, D, Min), What is 0.
