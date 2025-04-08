.PHONY: default setup swiftlint precommit

default: setup

setup: swiftlint precommit
	@echo "✅ Entorno listo"

swiftlint:
	@echo "🔍 Verificando SwiftLint..."
	@if ! command -v swiftlint > /dev/null; then \
		echo "🚫 SwiftLint no está instalado. Instalando..."; \
		brew install swiftlint; \
	else \
		echo "✅ SwiftLint ya está instalado"; \
	fi

precommit:
	@echo "🔍 Verificando pre-commit..."
	@if ! command -v pre-commit > /dev/null; then \
		echo "🚫 pre-commit no está instalado. Instalando..."; \
		brew install pre-commit; \
	else \
		echo "✅ pre-commit ya está instalado"; \
	fi
	@echo "🔧 Configurando hooks de pre-commit..."
	@pre-commit install