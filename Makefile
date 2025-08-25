VENV_DIR := venv
WHEEL_DIR := dist

.PHONY: all venv install-deps build-ui build-wheel install-wheel clean

all: venv install-deps build-ui build-wheel install-wheel

venv:
    python3 -m virtualenv $(VENV_DIR)
    . $(VENV_DIR)/bin/activate

install-deps:
    . $(VENV_DIR)/bin/activate && \
    pip install -r misc/requirements.in && \
    pip install ruff

build-ui:
    . $(VENV_DIR)/bin/activate && \
    ./tools/ui2py.sh --force && \
    ./tools/qrc2py.sh --force && \
    ./tools/ts2qm.py

build-wheel:
    . $(VENV_DIR)/bin/activate && \
    python setup.py bdist_wheel

install-wheel:
    . $(VENV_DIR)/bin/activate && \
    python -m installer $(WHEEL_DIR)/rare-*-any.whl

clean:
    rm -rf $(VENV_DIR) $(WHEEL_DIR) *.egg-info
