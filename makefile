.PHONY: default setup swiftlint precommit

default: setup

setup: swiftlint precommit prepush
	@echo "✅ Entorno completamente configurado"

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

prepush:
	@echo "🔧 Instalando hook de pre-push..."
	@mkdir -p .git/hooks
	@cp scripts/pre-push .git/hooks/pre-push
	@chmod +x .git/hooks/pre-push
	@echo "✅ Hook de pre-push instalado correctamente"


lint-fix:
	@echo "🛠 Corrigiendo errores con SwiftLint..."
	@swiftlint --fix --config .swiftlint.yml
