# tests/test_main.py

from app.main import teorema_bayes

def test_teorema_bayes():
    assert teorema_bayes(2, 3, 2, 2) == 0.6
    assert teorema_bayes(-1, 1, -1, 1) == 0.5
    assert teorema_bayes(0, 0, 0, 0) == ZeroDivisionError
