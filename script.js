function assessLoan() {

    const age = parseInt(document.getElementById("age").value);
    const employment = document.getElementById("employment").value;
    const income = parseFloat(document.getElementById("income").value);
    const expenses = parseFloat(document.getElementById("expenses").value);
    const credit = parseInt(document.getElementById("credit").value);
    const debts = parseFloat(document.getElementById("debts").value);
    const loan = parseFloat(document.getElementById("loan").value);
    const period = parseInt(document.getElementById("period").value);

    const resultDiv = document.getElementById("result");

    // Basic Validation
    if (age < 18) {
        resultDiv.innerHTML = "<span class='rejected'>Rejected: Must be 18+</span>";
        return;
    }

    if (employment !== "employed") {
        resultDiv.innerHTML = "<span class='rejected'>Rejected: Must be employed</span>";
        return;
    }

    if (credit < 600) {
        resultDiv.innerHTML = "<span class='rejected'>Rejected: Credit score too low</span>";
        return;
    }

    const disposableIncome = income - expenses - debts;
    const monthlyPayment = loan / period;

    if (disposableIncome < monthlyPayment) {
        resultDiv.innerHTML = "<span class='rejected'>Rejected: Insufficient disposable income</span>";
        return;
    }

    resultDiv.innerHTML = "<span class='approved'>Approved: Loan requirements satisfied</span>";
}
