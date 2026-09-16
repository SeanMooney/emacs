# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a personal Emacs configuration using a **literate programming** approach:

- **Main files**: hand-maintained `init.el` bootstraps Straight and Org, then `org-babel-load-file` loads `lit.org`
- **Generated file**: `lit.org` tangles to ignored `lit.el`; `org-babel-load-file` regenerates it only when needed, then loads it
- **Package management**: Uses `straight.el` with `use-package` for declarative configuration
- **Auto-tangling**: Saving `lit.org` regenerates `lit.el`, but does not reload the running Emacs

## Development Commands

### Configuration Management
- Edit normal configuration in `lit.org`; edit `init.el` only for pre-Org bootstrap changes
- Save `lit.org` to automatically tangle changes to generated `lit.el`
- Restart Emacs to load tangled changes: `C-c x r` (bound to `restart-emacs`)

### Package Management
- Packages are managed via `straight.el` and defined in `lit.org`
- Package versions are locked in `straight/versions/default.el`
- To update packages: `M-x straight-pull-all` then `M-x straight-rebuild-all`

### Testing Changes
- Saving `lit.org` only regenerates `lit.el`; it does not evaluate the new configuration
- Restart Emacs with `C-c x r` to test tangled changes
- Check startup time in `*Messages*` buffer (shows performance metrics)

### Pre-commit Configuration Validation
- Pre-commit hooks automatically validate configuration syntax before commits
- Setup: `source .venv/bin/activate && pre-commit install`
- Manual validation: `source .venv/bin/activate && pre-commit run --all-files`
- The validation hook prevents syntax errors that could break Emacs startup
- Hook checks: org-mode tangling, Emacs configuration loading, and basic file formatting

## Key Configuration Sections

### Core Setup
- `init.el`: performance bootstrap, Straight, use-package, and Straight's Org
- `lit.org`: UI tweaks and the rest of the declarative configuration

### Package Categories
- **Completion**: vertico, marginalia, orderless, consult, corfu, cape
- **UI/Themes**: ef-themes, fontaine, which-key, treemacs
- **Development**: eglot (LSP), flymake, treesit-auto, flyspell, envrc
- **Version Control**: magit, built-in VC
- **File Management**: dired, ibuffer, project.el
- **Terminal**: eat (modern terminal emulator)
- **AI Integration**: terminal launchers for Claude Code, OpenCode, Droid, and Pi

### Language Support
- **Python**: XDG-managed host tool and project runtime environments, Eglot/pylsp, and ruff linting
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
3. Save to auto-tangle `lit.el`
4. Run `M-x straight-use-package` if needed
5. Restart Emacs and test the configuration
6. Verify documentation consistency before committing

### Python Tool Environments
- `tool-requirements.txt` defines minimum versions for the host-local tox and pylsp environment
- Managed environments live under the local or TRAMP host's XDG data directory, not inside project repositories
- Explicit selections persist locally under the Emacs XDG state directory; loading them must never create environments or contact remote hosts
- Keep tool-environment updates independent from project runtime rebuilds
- Let each project's tox configuration own dependency and upper-constraints behavior

### Performance Considerations
- Native compilation is enabled (cache in `eln-cache/`)
- GC threshold increased during startup
- Startup time is measured and displayed

### AI Integration
- Terminal launchers provide project-local sessions for Claude Code, OpenCode, Droid, and Pi.
- Terminal-side integrations, including any MCP use, remain owned by those external tools.
- No in-Emacs model client or MCP server is configured.

This configuration prioritizes performance, modern development features, and clean, well-documented code structure.
