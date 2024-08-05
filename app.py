from flask import Flask, request, jsonify, render_template
import json
import os

app = Flask(__name__)
QUESTIONS_FILE = 'questions.json'

# Load questions from JSON file


def load_questions():
    if os.path.exists(QUESTIONS_FILE):
        with open(QUESTIONS_FILE, 'r') as file:
            return json.load(file)
    return []

# Save questions to JSON file


def save_questions(questions):
    with open(QUESTIONS_FILE, 'w') as file:
        json.dump(questions, file, indent=4)


@app.route('/')
def index():
    questions = load_questions()
    return render_template('index.html', questions=questions)


@app.route('/add_question', methods=['POST'])
def add_question():
    grade = request.form.get('Grade')
    subject = request.form.get('Subject')
    question = request.form.get('Question')
    marks = request.form.get('Marks')

    new_entry = {
        "Grade": grade,
        "Subject": subject,
        "Question": question,
        "Marks": marks
    }

    # Load current questions and check for duplicates
    questions = load_questions()
    if new_entry not in questions:
        questions.append(new_entry)
        save_questions(questions)

    return render_template('index.html', questions=questions)


if __name__ == '__main__':
    app.run(debug=True)
