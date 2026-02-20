from flask import Flask, render_template, request
from pyswip import Prolog
import os

app = Flask(__name__)

# Load Prolog file
prolog = Prolog()
prolog.consult("loan_system.pl")


@app.route("/", methods=["GET", "POST"])
def home():
    result = ""
    error = ""

    if request.method == "POST":

        age = request.form.get("age", "").strip()
        income = request.form.get("income", "").strip()
        expenses = request.form.get("expenses", "").strip()
        credit = request.form.get("credit", "").strip()
        loan = request.form.get("loan", "").strip()
        period = request.form.get("period", "").strip()
        employment = request.form.get("employment")
        debts = 1 if request.form.get("debts") == "yes" else 0

        # ---------- VALIDATE NUMBERS ----------
        if not age.isdigit():
            error = "Age must be a valid number."
        elif not income.isdigit():
            error = "Income must be a valid number."
        elif not expenses.isdigit():
            error = "Expenses must be a valid number."
        elif not credit.isdigit():
            error = "Credit score must be a valid number."
        elif not loan.isdigit():
            error = "Loan amount must be a valid number."
        elif not period.isdigit():
            error = "Loan period must be a valid number."
        else:
            # Convert to integers
            age = int(age)
            income = int(income)
            expenses = int(expenses)
            credit = int(credit)
            loan = int(loan)
            period = int(period)

            # ---------- BUSINESS RULES ----------
            if age < 18:
                error = "You must be 18 or older to apply."

            elif income <= 0:
                error = "Income must be positive."

            elif expenses < 0:
                error = "Expenses cannot be negative."

            elif credit <= 0:
                error = "Credit score must be positive."

            elif loan <= 0:
                error = "Loan amount must be positive."

            elif period > 36:
                error = "Loan period cannot exceed 36 months (3 years)."

            else:
                query = f"decision({age},{employment},{income},{expenses},{credit},{debts},{loan},{period},Result)"
                answer = list(prolog.query(query))

                if answer:
                    result = answer[0]["Result"]
                else:
                    result = "rejected"

    return render_template("index.html", result=result, error=error)


if __name__ == "__main__":
    app.run(debug=True)
    
