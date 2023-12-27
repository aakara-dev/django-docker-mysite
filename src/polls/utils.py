from django.core.mail import send_mail


def send_test_email(p_from, p_to, p_subject, p_body, fail_silently=False):
    try:
        send_mail(p_subject, p_body, p_from, p_to)
        return "Email sent successfully!"
    except Exception as e:
        return f"Error sending email: {e}"
