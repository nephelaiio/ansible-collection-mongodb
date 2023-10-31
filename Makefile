.PHONY: all ${MAKECMDGOALS}

MOLECULE_SCENARIO ?= default
MOLECULE_DOCKER_IMAGE ?= ubuntu2004
GALAXY_API_KEY ?=
GITHUB_REPOSITORY ?= $$(git config --get remote.origin.url | cut -d: -f 2 | cut -d. -f 1)
GITHUB_ORG = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 1)
GITHUB_REPO = $$(echo ${GITHUB_REPOSITORY} | cut -d/ -f 2)
REQUIREMENTS = requirements.yml
ROLE_DIR = roles
ROLE_FILE = roles.yml
COLLECTION_NAMESPACE = $$(yq '.namespace' < galaxy.yml)
COLLECTION_NAME = $$(yq '.name' < galaxy.yml)

all: install version lint test

test: lint
	poetry run molecule test -s ${MOLECULE_SCENARIO}

install:
	@type poetry >/dev/null || pip3 install poetry
	@type yq || sudo apt-get install -y yq
	@poetry install

lint: install
	poetry run yamllint .

requirements: install
	@rm -rf ${ROLE_DIR}/*
	@poetry run ansible-galaxy role install \
		--force --no-deps \
		--roles-path ${ROLE_DIR} \
		--role-file ${ROLE_FILE}
	@poetry run ansible-galaxy collection install \
		--force-with-deps .

build: requirements
	@poetry run ansible-galaxy collection build

dependency create prepare converge idempotence side-effect verify destroy login reset list:
	MOLECULE_DOCKER_IMAGE=${MOLECULE_DOCKER_IMAGE} poetry run molecule $@ -s ${MOLECULE_SCENARIO}

ignore:
	@poetry run ansible-lint --generate-ignore

clean: destroy reset
	@poetry env remove $$(which python) >/dev/null 2>&1 || exit 0

publish: build
	@echo publishing repository ${GITHUB_REPOSITORY}
	@echo GITHUB_ORGANIZATION=${GITHUB_ORG}
	@echo GITHUB_REPOSITORY=${GITHUB_REPO}
	@find ./ -name "${COLLECTION_NAMESPACE}-${COLLECTION_NAME}.*.tar.gz" | \
		xargs poetry run ansible-galaxy collection publish --api-key ${GALAXY_API_KEY}

version:
	@poetry run molecule --version

debug: version
	@poetry export --dev --without-hashes
