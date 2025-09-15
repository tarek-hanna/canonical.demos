
# Makefile for running gradle tasks
#===============================================
.PHONY: help
help:
	@echo "Available make targets for 'nowinandroid' :"
	@echo "  nia-build - Build nia app"
	@echo "  nia-install - Install nia app on connected device"
	@echo "  nia-lint - Run lint checks on nia app"
	@echo "  nia-unit-test - Run unit tests on nia app"
	@echo "  nia-screenshot-test - Run screenshot tests on nia app"
	@echo "  nia-clean - Clean build directory in nia app"
	@echo "  nia-tasks - List available gradle tasks for nia app"


.PHONY: nia-build
nia-build:
	./nowinandroid/gradlew -p nowinandroid :app:assembleDemoDebug

.PHONY: nia-install
nia-install:
	./nowinandroid/gradlew -p nowinandroid :app:installDemoDebug

.PHONY: nia-lint
nia-lint:
	./nowinandroid/gradlew -p nowinandroid :app:lintDemoDebug

.PHONY: nia-unit-test
nia-unit-test:
	./nowinandroid/gradlew -p nowinandroid :app:testDemoDebugUnitTest

.PHONY: nia-screenshot-test
nia-screenshot-test:
	./nowinandroid/gradlew -p nowinandroid :app:compareRoborazziDemoDebug

.PHONY: nia-clean
nia-clean:
	./nowinandroid/gradlew -p nowinandroid app:clean

.PHONY: nia-tasks
nia-tasks:
	./nowinandroid/gradlew -p nowinandroid :app:tasks