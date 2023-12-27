from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse
from django.template import loader
from .utils import send_mail
from .models import Question

# Create your views here.


def index(request):
    latest_question_set = Question.objects.order_by("-pub_date")[:5]
    return render(
        request, "polls/index.html", {"latest_question_set": latest_question_set}
    )


def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, "polls/detail.html", {"question": question})


def results(request, question_id):
    return HttpResponse(
        f"You are looking at the results view of question {question_id}"
    )


def votes(request, question_id):
    return HttpResponse(
        f"This is the Voting results page for question {question_id} for polls apps."
    )
