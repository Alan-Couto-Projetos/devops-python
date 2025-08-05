# tests/test_main.py
import pytest
from app.main import teorema_bayes

def test_teorema_bayes():
    assert teorema_bayes(2, 3, 2, 2) == 0.6
    assert teorema_bayes(-1, 1, -1, 1) == 0.5
    
    with pytest.raises(ZeroDivisionError):
        teorema_bayes(0, 0, 0, 0)


print(test_teorema_bayes)