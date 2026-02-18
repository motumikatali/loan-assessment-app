% -------- LOAN EXPERT SYSTEM WITH MENU --------

start :-
    nl,
    write('===================================='), nl,
    write('   MFS LOAN ASSESSMENT SYSTEM'), nl,
    write('===================================='), nl,
    write('Type answers followed by a DOT (.)'), nl,
    write('Example: 25.'), nl, nl,
    menu.

menu :-
    write('1. Assess Loan'), nl,
    write('2. Exit'), nl,
    write('Enter choice: '), read(Choice),
    handle_choice(Choice).

handle_choice(1) :- assess, menu.
handle_choice(2) :- write('Goodbye!'), nl.
handle_choice(_) :- write('Invalid choice'), nl, menu.

% -------- DATA INPUT --------

assess :-
    nl,
    write('--- Enter Applicant Information ---'), nl,
    write('Answer format example is shown in brackets'), nl, nl,

    write('1) Enter Age (example: 30.) : '), read(Age),
    write('2) Employment status (type employed. OR unemployed.) : '), read(Employment),
    write('3) Monthly income (example: 15000.) : '), read(Income),
    write('4) Monthly expenses (example: 5000.) : '), read(Expenses),
    write('5) Credit score 300-850 (example: 720.) : '), read(CreditScore),
    write('6) Existing debts (example: 2000.) : '), read(Debts),
    write('7) Loan amount requested (example: 80000.) : '), read(LoanAmount),
    write('8) Repayment period in months (example: 24.) : '), read(Period),

    decision(Age, Employment, Income, Expenses, CreditScore, Debts, LoanAmount, Period, Result),
    nl,
    write('===================================='), nl,
    write('         LOAN DECISION'), nl,
    write('===================================='), nl,
    write('Result: '), write(Result), nl, nl.


% -------- CALCULATIONS --------

disposable_income(Income, Expenses, DI) :-
    DI is Income - Expenses.

debt_ratio(Debts, Income, Ratio) :-
    Ratio is Debts / Income.

% -------- DECISION RULES --------

decision(Age, employed, Income, Expenses, CreditScore, Debts, LoanAmount, _, approved) :-
    Age >= 21,
    CreditScore >= 700,
    disposable_income(Income, Expenses, DI),
    DI > 2000,
    debt_ratio(Debts, Income, Ratio),
    Ratio < 0.3,
    LoanAmount =< Income * 10, !.

decision(Age, employed, Income, Expenses, CreditScore, Debts, LoanAmount, _, conditional_approved) :-
    Age >= 21,
    CreditScore >= 600,
    disposable_income(Income, Expenses, DI),
    DI > 1000,
    debt_ratio(Debts, Income, Ratio),
    Ratio < 0.5,
    LoanAmount =< Income * 15, !.

decision(_, _, _, _, _, _, _, _, rejected).
