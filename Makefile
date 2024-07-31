.PHONY: clear-log
clear-log:
	rm -rf ./logs
.PHONY: isort
isort:
	ruff check --select I --fix
.PHONY: check
check:
	ruff check
.PHONY: check-fix
check-fix:
	ruff check --fix 
