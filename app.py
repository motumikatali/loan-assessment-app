from flask import Flask, render_template, request
from pyswip import Prolog

app = Flask(__name__)
prolog = Prolog()
prolog.consult("loan_system.pl")

@app.route("/", methods=["GET", "POST"])
def home():
    result = ""
    if request.method == "POST":
        age = request.form["age"]
        emp = request.form["employment"]
        income = request.form["income"]
        expenses = request.form["expenses"]
        credit = request.form["credit"]
        debts = request.form["debts"]
        loan = request.form["loan"]
        period = request.form["period"]

        query = f"decision({age},{emp},{income},{expenses},{credit},{debts},{loan},{period},Result)"
        answer = list(prolog.query(query))

        if answer:
            result = answer[0]["Result"]
        else:
            result = "rejected"

    return render_template("index.html", result=result)

app.run()
