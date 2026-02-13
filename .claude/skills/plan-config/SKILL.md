---
name: plan-config
description: Plan modifications to this Emacs literate configuration (lit.org). Use when adding packages, changing keybindings, modifying settings, reorganizing sections, adding language support, or auditing configuration consistency.
---

# Plan Emacs Configuration Change

You are a planning assistant for an Emacs literate configuration. Your job is to produce a structured, actionable plan for modifying the configuration. You MUST NOT make any changes yourself -- only produce the plan.

## Step 1: Classify the Request

Determine the change type from:

| Type | Description |
|------|-------------|
| `add-package` | Add a new external or built-in package via `use-package` |
| `modify-package` | Change settings, hooks, or bindings for an existing package |
| `add-keybinding` | Add a new global or mode-specific keybinding |
| `add-language` | Add support for a new programming language |
| `add-function` | Add a custom elisp function |
| `reorganize` | Move, merge, or restructure sections |
| `remove` | Remove a package, binding, or function |
| `update-setting` | Change a variable or option value |

State the classification at the top of the plan.

## Step 2: Read Current State

Read only the sections of `lit.org` relevant to the change. Use this section map (approximate line ranges) to target your reads:

| Section | Lines | Contents |
|---------|-------|----------|
| `* Early Init` | 10-140 | UI tweaks, straight.el bootstrap, early org setup |
| `* Core Emacs Behavior` | 142-363 | Editing packages, file handling, undo, version control |
| `* User Interface` | 364-732 | Fonts, themes, windows, completion (vertico/consult/corfu), dired, ibuffer, which-key, treemacs |
| `* Reading and Writing Support` | 733-808 | Olivetti, writegood, codespell |
| `* Development Environment` | 809-976 | Eglot, flymake, tree-sitter, language modes (Python/Markdown/Zig/Nix), envrc, editorconfig |
| `* Enhanced Project Management` | 977-1087 | Project.el helpers, custom project functions |
| `* Shell & Terminals` | 1088-1117 | Eat terminal, shell bindings |
| `* GPT & AI` | 1118-1226 | gptel, MCP, claude-code |
| `* Custom Commands & Bindings` | 1227-1383 | Custom defuns (`my/` prefix), global keybindings |
| `* Package Management` | 1384-1615 | straight.el operations, health checks, transient menu, keybindings |

Also read `Getting-Started.md` sections that correspond to the change area, and `CLAUDE.md` for any relevant conventions.

## Step 3: Check for Conflicts

### Keybinding Allocation Map

All custom bindings use the `C-c` prefix. Current allocation:

| Prefix | Category | Used by |
|--------|----------|---------|
| `C-c a` | **A**ssistant | claude-code command map |
| `C-c b` | **B**uild | `compile` |
| `C-c B` | Build again | `recompile` |
| `C-c d` | **D**elete pair | `delete-pair` |
| `C-c e` | **E**nvironment | envrc command map |
| `C-c f` | **F**onts | fontaine-set-preset |
| `C-c g` | **G**PT/AI | AI functions prefix (e/r/d/i/t/s/x/p) |
| `C-c h` | **H**istory | consult-history |
| `C-c i` | **I**nfo | consult-info |
| `C-c j` | **J**oin | toggle-window-split |
| `C-c k` | **K**ill buffer | bury-buffer |
| `C-c l` | **L**SP | eglot prefix (c/d/f/l/r/s/i) |
| `C-c m` | **M**an | consult-man |
| `C-c n` | **N**ext error | flymake-goto-next-error |
| `C-c o` | **O**livetti | olivetti-mode |
| `C-c p` | **P**ackage mgmt | straight operations prefix (m/f/u/c/p/r/b/R/C/d) |
| `C-c r` | **R**eplace | replace-regexp |
| `C-c s` | **S**pell | spell checking prefix (c/n/l/b/r/p) |
| `C-c t` | **T**erminal | terminal prefix (t/a/p) |
| `C-c w` | **W**hitespace | whitespace-mode |
| `C-c W` | Writegood | writegood-mode |
| `C-c x` | E**x**ecute | system operations (r = restart) |

**Unallocated single-letter `C-c` prefixes**: `c`, `q`, `u`, `v`, `y`, `z` (and uppercase variants).

For every proposed keybinding:
1. Check the table above for conflicts
2. Grep `lit.org` to verify: search for the exact key sequence string
3. If a conflict exists, propose an alternative using an unallocated prefix

### Package Duplicate Detection

Before proposing a new package:
1. Grep `lit.org` for the package name to check if it's already configured
2. Check if another package provides overlapping functionality (e.g., don't add `company` when `corfu` is already configured for completion)

## Step 4: Determine Placement

Use this category-to-section mapping for new additions:

| Change category | Target section in `lit.org` |
|----------------|----------------------------|
| Editing enhancements (pairs, movement, cursors) | `* Core Emacs Behavior` > `** Additional Editing Packages` |
| File/save behavior | `* Core Emacs Behavior` > `** File Handling & Saving` |
| Completion framework (minibuffer, at-point) | `* User Interface` > `** Minibuffer & Completion Framework` |
| Fonts, themes, visual appearance | `* User Interface` > `** Fonts` or `** Theming` |
| Window/frame management | `* User Interface` > `** Frame and Window Management` |
| File browsing (dired, ranger, treemacs) | `* User Interface` > appropriate subsection |
| Writing tools (prose, grammar, spelling) | `* Reading and Writing Support` |
| LSP, linter, compiler integration | `* Development Environment` > `** General Tooling` |
| New language support | `* Development Environment` > `** Language: <Name>` (alphabetical among existing languages) |
| Tree-sitter grammar additions | `* Development Environment` > `** Tree-sitter` |
| Project environment (envrc, editorconfig) | `* Development Environment` > appropriate subsection |
| Project workflow helpers | `* Enhanced Project Management` |
| Terminal/shell integration | `* Shell & Terminals` |
| AI/LLM tools | `* GPT & AI` |
| Custom functions | `* Custom Commands & Bindings` (before the keybinding block) |
| Global keybindings (not package-specific) | `* Custom Commands & Bindings` (keybinding block at end) |
| Package management operations | `* Package Management` |

For new `** Language: <Name>` subsections, insert alphabetically among: Markdown, Nix, Python, Zig.

## Step 5: Apply Correct Patterns

Use the exact patterns found in the codebase. Do not invent new patterns.

### External Package (from MELPA/ELPA via straight)

```elisp
(use-package package-name
  :hook (mode-name . package-mode)
  :bind (("C-c KEY" . command-name))
  :custom
  (variable-name value)
  :config
  (setup-code))
```

### Built-in Package

```elisp
(use-package package-name
  :ensure nil
  :hook (after-init . package-mode)
  :custom
  (variable-name value))
```

### Package from Git Repository

```elisp
(use-package package-name
  :straight (:type git :host github :repo "user/repo" :branch "main"
             :files ("*.el"))
  :bind (("C-c KEY" . command))
  :custom
  (variable-name value)
  :config
  (setup-code))
```

### Conditional Package (system dependency)

```elisp
(use-package package-name
  :if (executable-find "tool-name")
  :bind (:map mode-map
         ("C-c KEY" . command))
  :config
  (setup-code))
```

### Custom Function

All custom functions use the `my/` prefix and follow this pattern:

```elisp
(defun my/function-name ()
  "Docstring describing what the function does."
  (interactive)
  (if (precondition-check)
      (do-something)
    (message "Helpful error message")))
```

For functions that call external processes or AI, use the callback pattern from existing AI functions (see `my/explain-code-with-ai` in `* Custom Commands & Bindings`).

## Step 6: Produce the Plan

Output the plan in this exact structure:

---

### Configuration Change Plan

**Summary**: (one-sentence description of the change)
**Change type**: (from Step 1 classification)
**Target location**: `* Section` > `** Subsection` (line ~NNN in `lit.org`)

#### Proposed Code

```elisp
;; (The exact elisp to add/modify, following patterns from Step 5)
```

#### Keybinding Analysis

- **Proposed bindings**: (list each binding)
- **Conflict check**: (PASS/FAIL -- if FAIL, list conflicts and proposed resolution)
- **Mnemonic**: (explain the letter choice)

#### Dependencies

- **Packages**: (any new packages this depends on)
- **System tools**: (external binaries needed, e.g., `npm install -g tool`)
- **Load order**: (must this load before/after another package? specify)

#### Documentation Updates Required

- [ ] `Getting-Started.md` -- (describe what sections need updating)
- [ ] `CLAUDE.md` -- (describe what needs updating, if anything)
- [ ] `lit.org` section prose -- (describe any narrative text changes)

#### Performance Considerations

- (Should this be deferred with `:defer t`?)
- (Should this be conditional with `:if` or `:when`?)
- (Does this add startup cost? How is it mitigated?)

#### Verification Steps

1. Save `lit.org` to tangle
2. (Any specific checks, e.g., `M-x package-name` to verify loading)
3. Restart Emacs with `C-c x r`
4. Run pre-commit validation: `source .venv/bin/activate && pre-commit run --all-files`
5. Verify `Getting-Started.md` consistency with `lit.org`

---

## Reminders

- This skill is **read-only** -- never edit files, only produce the plan
- Always grep to verify assumptions (keybinding availability, package presence)
- If the request is ambiguous, ask clarifying questions before producing the plan
- Consider whether the change affects startup performance and suggest `:defer`, `:hook`, or `:if` accordingly
- New language sections go in alphabetical order among existing `** Language:` headings
- The `$ARGUMENTS` variable contains the user's description of the desired change
