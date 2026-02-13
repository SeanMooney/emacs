# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Emacs configuration using a **literate programming** approach:

- **Main files**: `init.el` (bootstrap) loads `lit.org` (literate config)
- **Package management**: Uses `straight.el` with `use-package` for declarative configuration
- **Configuration pattern**: All settings are written in `lit.org` using Org-mode, then tangled to `init.el`
- **Auto-tangling**: The configuration automatically re-tangles when `lit.org` is saved

## Development Commands

### Configuration Management
- Edit configuration in `lit.org` (not `init.el` directly)
- Save `lit.org` to automatically tangle changes to `init.el`
- Restart Emacs: `C-c x r` (bound to `restart-emacs`)

### Package Management
- Packages are managed via `straight.el` and defined in `lit.org`
- Package versions are locked in `straight/versions/default.el`
- To update packages: `M-x straight-pull-all` then `M-x straight-rebuild-all`

### Testing Changes
- Most changes take effect immediately when `lit.org` is saved and tangled
- For major changes, restart Emacs with `C-c x r`
- Check startup time in `*Messages*` buffer (shows performance metrics)

### Pre-commit Configuration Validation
- Pre-commit hooks automatically validate configuration syntax before commits
- Setup: `source .venv/bin/activate && pre-commit install`
- Manual validation: `source .venv/bin/activate && pre-commit run --all-files`
- The validation hook prevents syntax errors that could break Emacs startup
- Hook checks: org-mode tangling, Emacs configuration loading, and basic file formatting

## Key Configuration Sections

### Core Setup (Early Init)
- Performance optimizations (GC threshold, native compilation)
- UI tweaks (disable toolbar, menu bar, etc.)
- Package management bootstrap

### Package Categories
- **Completion**: vertico, marginalia, orderless, consult, corfu, cape
- **UI/Themes**: ef-themes, fontaine, which-key, treemacs
- **Development**: eglot (LSP), flymake, treesit-auto, flyspell, envrc
- **Version Control**: magit, built-in VC
- **File Management**: dired, ibuffer, project.el
- **Terminal**: eat (modern terminal emulator)
- **AI Integration**: gptel, claude-code, MCP (Model Context Protocol)

### Language Support
- **Python**: pyvenv for virtual environments, ruff for linting
- **Markdown**: markdown-mode with GitHub flavor
- **Nix**: nix-ts-mode for expression editing
- **Tree-sitter**: Automatic parser installation for syntax highlighting
- **General**: All prog-mode features (LSP, completion, etc.)

## Important Configuration Patterns

### Use-package Pattern
All package configuration follows this pattern in `lit.org`:
```elisp
(use-package package-name
  :bind (("C-c key" . command))
  :custom (variable value)
  :config (setup-code))
```

### Built-in Packages Require `:straight (:type built-in)`
**CRITICAL**: Because `straight-use-package-by-default` is set to `t`, any `use-package` declaration for a built-in Emacs package **must** include `:straight (:type built-in)` in addition to `:ensure nil`. Without it, straight.el will attempt to download the package from recipe repositories and fail.

```elisp
;; CORRECT - built-in package
(use-package files
  :ensure nil
  :straight (:type built-in)
  :custom
  (load-prefer-newer t))

;; WRONG - will cause "Could not find package" error
(use-package files
  :ensure nil
  :custom
  (load-prefer-newer t))
```

**Never remove `:straight (:type built-in)` from built-in packages.** If wrapping a built-in feature (e.g., `pixel-scroll`) in a new `use-package` form, always include both `:ensure nil` and `:straight (:type built-in)`.

### Don't Move Computed Values from `:config` to `:custom`
`:custom` values are evaluated early (at macro-expansion time), before the package is loaded. Only move `setq` to `:custom` when the value is a **simple literal** (number, string, symbol, quoted list). If the value references a **package-defined variable or function**, it must stay as `setq` in `:config`.

```elisp
;; CORRECT - computed value stays in :config
:config
(setq treemacs-collapse-dirs (if treemacs-python-executable 3 0))

;; WRONG - treemacs-python-executable is void at :custom evaluation time
:custom
(treemacs-collapse-dirs (if treemacs-python-executable 3 0))
```

### Key Binding Conventions
- `C-c` prefix for custom commands
- `C-c f` - fontaine (font management)
- `C-c l` - LSP/eglot commands
- `C-c a` - claude-code commands
- `C-c e` - envrc (environment management)
- `C-x g` - magit-status

### File Persistence
- Undo history: saved to `~/.config/emacs/undo/`
- Place (cursor position): automatically saved/restored
- Minibuffer history: persisted between sessions

## Development Notes

### Documentation Consistency
- **CRITICAL**: Always check that `Getting-Started.md` is updated to be consistent with `lit.org` before committing
- The documentation must reflect the actual configuration:
  - Package additions/removals
  - Key binding changes
  - Feature descriptions
  - Dependencies and requirements
- Both files serve different but related purposes:
  - `lit.org`: The actual configuration code
  - `Getting-Started.md`: User-facing documentation

### When Adding New Packages
1. Add `use-package` declaration to appropriate section in `lit.org`
2. Update corresponding documentation in `Getting-Started.md`
3. Save to auto-tangle
4. Run `M-x straight-use-package` if needed
5. Test configuration
6. Restart Emacs if needed
7. Verify documentation consistency before committing

### Performance Considerations
- Native compilation is enabled (cache in `eln-cache/`)
- GC threshold increased during startup
- Startup time is measured and displayed

### AI Integration
- gptel configured for local Ollama instance at `192.168.16.172:11434`
- MCP filesystem server provides project context to LLMs
- claude-code provides direct Claude integration

This configuration prioritizes performance, modern development features, and clean, well-documented code structure.
