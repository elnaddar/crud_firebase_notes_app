# Makefile for deploying the Flutter web projects to GitHub Pages
OUTPUT = crud_firebase_notes_app
BASE_HREF = /$(OUTPUT)/
# Replace this with your GitHub username
GITHUB_USER = elnaddar
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
DEPLOY_BRANCH = gh-pages  # Set the branch you want to deploy to
OLD_BRANCH = $(DEPLOY_BRANCH)  # Set the old branch you want to delete

# Deploy the Flutter web project to GitHub
deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif

	# @echo "Clean existing repository"
	# flutter clean

	# @echo "Getting packages..."
	# flutter pub get

	# @echo "Generating the web folder..."
	# flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	# @echo "Deleting old branch locally and remotely"
	# git branch -D $(OLD_BRANCH)
	# git push origin --delete $(OLD_BRANCH)

	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git checkout -B $(DEPLOY_BRANCH) && \
	# git checkout $(DEPLOY_BRANCH) && \
	git add -f . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	(git remote add origin $(GITHUB_REPO) || git remote set-url origin $(GITHUB_REPO)) && \
	git push -u -f origin $(DEPLOY_BRANCH)

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

.PHONY: deploy

update:
	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	git checkout $(DEPLOY_BRANCH) && \
	git add -f . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	(git remote add origin $(GITHUB_REPO) || git remote set-url origin $(GITHUB_REPO)) && \
	git push -u -f origin $(DEPLOY_BRANCH)

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(OUTPUT)/"


