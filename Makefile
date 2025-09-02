
# Makefile for running gradle tasks
#===============================================
.PHONY: help
help:
	@echo "Available make targets for 'nowinandroid' :"
	@echo "  nia-build - Build nowinandroid app"
	@echo "  nia-install - Install nowinandroid app on connected device"
	@echo "  nia-test - Test nowinandroid project"
	@echo "  nia-clean - Clean build directory in nowinandroid project"
	@echo "  nia-tasks - List available gradle tasks for nowinandroid project"


.PHONY: nia-build
nia-build:
	./nowinandroid/gradlew -p nowinandroid :app:assembleDemoDebug

.PHONY: nia-install
nia-install:
	./nowinandroid/gradlew -p nowinandroid :app:installDemoDebug

.PHONY: nia-lint
nia-lint:
	./nowinandroid/gradlew -p nowinandroid :app:lintDemoDebug

.PHONY: nia-test
nia-test:
	./nowinandroid/gradlew -p nowinandroid :app:testDemoDebugUnitTest

.PHONY: nia-clean
nia-clean:
	./nowinandroid/gradlew -p nowinandroid app:clean

.PHONY: nia-tasks
nia-tasks:
	./nowinandroid/gradlew -p nowinandroid :app:tasks