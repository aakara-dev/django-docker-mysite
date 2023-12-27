from django.shortcuts import render
from django.http import HttpResponse
from .utils import send_mail
from .models import Question

# Create your views here.


def index(request):
    text = """
    <html>
    <h2>Hello,</h2>
    <p>This is the index page of Polls Apps.
    An email has been sent to the user with confirmation.
    <br></p>
    <strong>Cheers,<br>
    DjangoTeam</strong>
    </html>
    """
    subject = "Polls Index Page"
    body = "Test Email from Mailpit"
    from_ids = "polls@mysite.com"
    to_ids = ["to@mysite.com"]

    send_mail(subject, body, from_ids, to_ids)

    return HttpResponse(f"<html>{text}</html>")


def detail(request, question_id):
    return HttpResponse(
        f"You are looking at the Details page of question {question_id}"
    )


def results(request, question_id):
    return HttpResponse(
        f"You are looking at the results view of question {question_id}"
    )


def votes(request, question_id):
    return HttpResponse(
        f"This is the Voting results page for question {question_id} for polls apps."
    )
