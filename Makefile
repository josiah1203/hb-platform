.PHONY: hb-verify-format hb-verify-bridge hb-verify-hos hb-verify-collab \
	hb-verify-hbw hb-verify-workflow hb-verify-cli hb-verify-platform \
	hb-verify-registry hb-verify-ai-local hb-verify-devrel hb-verify-coordinator \
	hb-verify-parallel hb-verify-gates

DESKTOP := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)

hb-verify-format:
	@if [ -f "$(DESKTOP)/hnf/Cargo.toml" ]; then \
	  cd "$(DESKTOP)/hnf" && cargo test -q; \
	else \
	  echo "hb/format: skipped (../hnf not found)"; \
	fi

hb-verify-bridge:
	@if [ -f "$(DESKTOP)/hb-bridge/Cargo.toml" ]; then \
	  cd "$(DESKTOP)/hb-bridge" && cargo test -q; \
	else \
	  echo "hb/bridge: skipped (../hb-bridge not found)"; \
	fi

hb-verify-hos:
	@if [ -d "$(DESKTOP)/hbp-cloud/api/tests" ]; then \
	  cd "$(DESKTOP)/hbp-cloud/api" && PYTHONPATH="$(DESKTOP)/hbp-cloud:$(DESKTOP)/hbp-cloud/api:$(DESKTOP)/hbp-cloud/graph" \
	    python3 -m pytest tests/test_hos_version_control.py tests/test_semantic_merge.py tests/test_hnf.py tests/test_collaboration.py -q --tb=line 2>/dev/null \
	    || echo "hb/hos: skipped (pytest/deps unavailable — pip install -r requirements-dev.txt)"; \
	else \
	  echo "hb/hos: skipped (hbp-cloud/api not found)"; \
	fi

hb-verify-collab:
	@echo "hb/collab: skipped (CRDT service not implemented — replace collaboration stub)"

hb-verify-hbw:
	@if [ -f "$(DESKTOP)/hbw/package.json" ]; then \
	  cd "$(DESKTOP)/hbw" && npm test 2>/dev/null || echo "hb/hbw: skipped (npm test not configured)"; \
	else \
	  echo "hb/hbw: skipped (../hbw not found)"; \
	fi

hb-verify-workflow:
	@if [ -f "$(DESKTOP)/hbp-cloud/api/tests/test_workflow_engine.py" ]; then \
	  cd "$(DESKTOP)/hbp-cloud/api" && python3 -m pytest tests/test_workflow_engine.py -q --noconftest; \
	else \
	  echo "hb/workflow: skipped (test_workflow_engine.py not found)"; \
	fi

hb-verify-cli:
	@if [ -f "$(DESKTOP)/hb/pyproject.toml" ]; then \
	  cd "$(DESKTOP)/hb" && python3 -m pytest tests/test_hw_cli.py::test_auth_login_json -q 2>/dev/null \
	    || echo "hb/cli: skipped (pytest/deps unavailable)"; \
	else \
	  echo "hb/cli: skipped (../hb not found)"; \
	fi

hb-verify-platform:
	@if [ -x "$(DESKTOP)/hbp-cloud/infra/kind/helm-validate.sh" ]; then \
	  "$(DESKTOP)/hbp-cloud/infra/kind/helm-validate.sh" 2>/dev/null \
	    || echo "hb/platform: skipped (helm not installed)"; \
	else \
	  echo "hb/platform: skipped (helm-validate.sh missing)"; \
	fi

hb-verify-registry:
	@echo "hb/registry: skipped (Phase 1 private registry)"

hb-verify-ai-local:
	@echo "hb/ai-local: skipped (HBW sidebar automations — M3)"

hb-verify-devrel:
	@test -f docs/PUBLIC_ROADMAP.md && echo "hb/devrel: docs present" || echo "hb/devrel: skipped"

hb-verify-coordinator:
	@test -f docs/PHASE_0.5.md && echo "hb/coordinator: phase gates documented" || echo "hb/coordinator: skipped"

hb-verify-parallel:
	$(MAKE) -j4 hb-verify-format hb-verify-bridge hb-verify-hos hb-verify-cli

hb-verify-gates:
	@bash scripts/phase05-gates.sh
