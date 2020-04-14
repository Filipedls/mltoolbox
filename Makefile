.PHONY: setup
setup: setup-venv setup-venv-post

.PHONY: setup-venv
setup-venv:
	poetry config virtualenvs.in-project true
	poetry install --no-interaction --no-ansi

.PHONY: setup-venv-post
setup-venv-post:
	(source .venv/bin/activate; plaidml-setup;)

.PHONY: update
update:
	poetry update

.PHONY: test
test:
	poetry run pytest

.PHONY: bench
bench:
	(source .venv/bin/activate; plaidbench keras mobilenet;)

.PHONY: run
run:
	(source .venv/bin/activate; sh entrypoint.sh; )

.PHONY: ipykernel
ipykernel:
	(source .venv/bin/activate; python -m ipykernel install --user --name=mltoolbox;)

.PHONY: docker
docker: docker-build docker-run

#  --build-arg jupyter_workdir='start_dir'
.PHONY: docker-build
docker-build:
	docker build -t mltoolbox .

.PHONY: docker-run
docker-run:
	docker run -t -i -p8888:8888 -v '$(PWD)':'/app/$(notdir $(CURDIR))/' -e JUPYTER_DIR='$(notdir $(CURDIR))' mltoolbox
