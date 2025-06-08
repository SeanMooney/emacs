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

## Key Configuration Sections

### Core Setup (Early Init)
- Performance optimizations (GC threshold, native compilation)
- UI tweaks (disable toolbar, menu bar, etc.)
- Package management bootstrap

### Package Categories
- **Completion**: vertico, marginalia, orderless, consult, corfu, cape
- **UI/Themes**: ef-themes, fontaine, which-key, treemacs
- **Development**: eglot (LSP), flymake, treesit-auto, flyspell
- **Version Control**: magit, built-in VC
- **File Management**: dired, ibuffer, project.el
- **Terminal**: eat (modern terminal emulator)
- **AI Integration**: gptel, claude-code, MCP (Model Context Protocol)

### Language Support
- **Python**: pyvenv for virtual environments, ruff for linting
- **Markdown**: markdown-mode with GitHub flavor
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

### Key Binding Conventions
- `C-c` prefix for custom commands
- `C-c f` - fontaine (font management)
- `C-c l` - LSP/eglot commands
- `C-c a` - claude-code commands
- `C-x g` - magit-status

### File Persistence
- Undo history: saved to `~/.config/emacs/undo/`
- Place (cursor position): automatically saved/restored
- Minibuffer history: persisted between sessions

## Development Notes

### When Adding New Packages
1. Add `use-package` declaration to appropriate section in `lit.org`
2. Save to auto-tangle
3. Run `M-x straight-use-package` if needed
4. Test configuration
5. Restart Emacs if needed

### Performance Considerations
- Native compilation is enabled (cache in `eln-cache/`)
- GC threshold increased during startup
- Startup time is measured and displayed

### AI Integration
- gptel configured for local Ollama instance at `192.168.16.172:11434`
- MCP filesystem server provides project context to LLMs
- claude-code provides direct Claude integration

This configuration prioritizes performance, modern development features, and clean, well-documented code structure.