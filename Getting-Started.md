# Getting Started with This Emacs Configuration

Welcome to a modern, AI-enhanced Emacs configuration designed for both writing and development. This setup emphasizes accessibility, productivity, and the power of AI assistance while maintaining Emacs's flexibility.

## Table of Contents

- [Prerequisites & Installation](#prerequisites--installation)
- [What Makes This Configuration Special](#what-makes-this-configuration-special)
- [Quick Start: Essential Keybindings](#quick-start-essential-keybindings)
- [Your First 10 Minutes](#your-first-10-minutes)
- [Basic Workflows](#basic-workflows)
- [AI Integration Guide](#ai-integration-guide)
- [Migration Guide: Coming from Other Editors](#migration-guide-coming-from-other-editors)
- [Troubleshooting & Common Issues](#troubleshooting--common-issues)
- [Customization & Next Steps](#customization--next-steps)
- [Complete Reference](#complete-reference)

## Prerequisites & Installation

### **System Requirements**
- **Emacs 29.1+** (for best compatibility with modern features)
- **Git** (for package management with straight.el)
- **ripgrep** (`rg`) for fast project searching
- **Ollama** running locally for AI features (optional but recommended)

### **Installation Steps**
1. **Backup existing configuration**:
   ```bash
   mv ~/.config/emacs ~/.config/emacs-backup
   # or mv ~/.emacs.d ~/.emacs.d-backup
   ```

2. **Clone this configuration**:
   ```bash
   git clone [your-repo-url] ~/.config/emacs
   ```

3. **First launch**: Start Emacs - packages will install automatically (may take 2-3 minutes)

4. **Verify setup**: Check startup message in `*Messages*` buffer for any errors

### **Optional Dependencies**
- **Fonts**: Install Source Code Pro and FiraGO for best experience
- **OpenDyslexic**: For dyslexia-friendly font preset
- **Language servers**: For your programming languages (e.g., `pyright` for Python)
- **Spell checkers**: `aspell` or `hunspell` for enhanced spell checking
- **direnv + nix-direnv**: For automatic Nix devshell environment loading (optional)

**⚠️ Important**: If you encounter any issues, see [Troubleshooting](#troubleshooting--common-issues) section.

## What Makes This Configuration Special

This isn't vanilla Emacs. Here are the key differences you'll notice immediately:

### 🧠 **AI-Powered Everything**
- **5 AI writing functions** for improving, summarizing, and proofreading text
- **3 AI development functions** for code explanation, review, and documentation
- **Local AI integration** with your Ollama instance
- **Smart context awareness** through Model Context Protocol (MCP)

### ✍️ **Writing-First Design**
- **Dyslexia-friendly fonts** and visual feedback
- **Traditional spell checking** with Flyspell (reliable and well-tested)
- **Live word counting** in the mode line
- **Distraction-free writing mode** with Olivetti
- **Grammar and style analysis** with writegood-mode

### 🚀 **Modern Interface**
- **Fuzzy search everywhere** - find files, buffers, and text with partial matches
- **Rich completions** with previews and annotations
- **Three-pane file browser** alongside traditional dired
- **Smart window management** and layout controls

## Quick Start: Essential Keybindings

### Core Navigation (Learn These First)
| Key | Function | Description |
|-----|----------|-------------|
| `C-f` | Search in buffer | Fuzzy search with live preview |
| `C-x b` | Switch buffer | Smart buffer switching with preview |
| `C-x f` | Find file | Project-aware file finding |
| `C-j` | Navigate symbols | Jump to functions, classes, headers |

### AI Assistance (C-c g prefix)
| Key | Function | What it does |
|-----|----------|-------------|
| `C-c g i` | Improve writing | Enhance selected text for clarity and grammar |
| `C-c g t` | Adjust tone | Change text tone (professional/casual/academic) |
| `C-c g s` | Summarize | Create concise summary of selected text |
| `C-c g p` | Proofread | Check grammar, spelling, and style |
| `C-c g e` | Explain code | Get AI explanation of selected code |
| `C-c g r` | Review code | Get improvement suggestions for code |

### Essential Editing
| Key | Function | Description |
|-----|----------|-------------|
| `C-/` | Smart comment | Comment/uncomment line or region |
| `M-↑/↓` | Move text | Move lines or regions up/down |
| `C->` | Mark next | Select next occurrence of word/selection |
| `C-S-c C-S-c` | Multi-cursor lines | Edit multiple lines simultaneously |

## Your First 10 Minutes

### 1. **Open and Edit This Configuration**
```
C-x f lit.org
```
This opens the main configuration file. Notice it's written in Org-mode - this is "literate programming" where documentation and code live together.

### 2. **Try AI Writing Assistance**
- Select any text in this file
- Press `C-c g i` to improve it with AI
- Try `C-c g s` to summarize a paragraph

### 3. **Explore Smart Search**
- Press `C-f` and start typing - see live search with context
- Try `C-x b` to switch between buffers with fuzzy matching
- Use `C-j` to navigate through document sections

### 4. **Test the File Browser**
- Press `C-x r d` for the three-pane ranger view
- Try `C-x C-j` to jump to the current file in dired
- Use `C-x C-d` to see recently visited directories

### 5. **Adjust the Interface**
- Press `C-c f` to try different font presets
- Include the dyslexia-friendly option if helpful
- Try `C-c o` for distraction-free writing mode

## Basic Workflows

### **Daily Writing Workflow**
1. **Start focused**: `C-c o` (Olivetti mode) + `C-c f` (choose font)
2. **Write your draft** - notice live word count in mode line
3. **Get AI assistance**: Select text → `C-c g i` (improve) or `C-c g p` (proofread)
4. **Spell check**: `M-$` on any highlighted words
5. **Style check**: writegood-mode highlights issues automatically

### **Development Workflow**
1. **Open project**: `C-x p p` (switch to project)
2. **Find files**: `C-x p f` (fuzzy find) or `C-j` (navigate symbols)
3. **Understand code**: Select code → `C-c g e` (explain) or `C-c g r` (review)
4. **Work with Git**: `C-x g` (Magit) - see changes in fringe
5. **Run commands**: `C-c t p` (project terminal)

### **Emergency Commands (Learn These First!)**
- **Quit anything**: `C-g` (cancel current command)
- **Undo**: `C-z` (better undo system)
- **Save file**: `C-x C-s`
- **Get help**: `C-h k` then press any key to learn what it does
- **Find file**: `C-x C-f`

## AI Integration Guide

Your configuration includes powerful AI features that work with your local Ollama instance for privacy.

### **What Each AI Function Does**

#### **Writing AI Functions** (`C-c g` prefix)
- **`C-c g i`** - **Improve**: "Make this clearer and fix grammar"
- **`C-c g t`** - **Tone**: "Rewrite this professionally/casually/academically"
- **`C-c g s`** - **Summarize**: "Give me the key points"
- **`C-c g p`** - **Proofread**: "Check everything - grammar, style, clarity"
- **`C-c g x`** - **Expand**: "Add more detail and examples"

#### **Development AI Functions**
- **`C-c g e`** - **Explain**: "What does this code do?"
- **`C-c g r`** - **Review**: "How can I improve this code?"
- **`C-c g d`** - **Document**: "Write documentation for this"

### **AI Usage Tips**
- **Select text first** - AI works on selected regions
- **Be specific** - clear selection gives better results
- **Iterate** - use multiple AI functions in sequence
- **Privacy**: All processing happens locally with Ollama

### **Example AI Workflow**
1. Write a rough paragraph
2. Select it and use `C-c g i` to improve clarity
3. Use `C-c g t` to adjust tone for your audience
4. Use `C-c g p` for final proofreading

**Note**: If AI functions don't work, ensure Ollama is running at `192.168.16.172:11434`

### Complete Keybinding Reference

This configuration uses a systematic approach to keybindings with clear mnemonics. Here's the complete architecture:

### **C-c Prefix Organization (User/Custom Bindings)**

The `C-c` prefix is reserved for user customizations in Emacs. This configuration organizes them with clear mnemonics:

#### **C-c a** - **A**ssistant (Claude Code Integration)
```
C-c a [various] - Claude Code command map
```
*Mnemonic: "Assistant" - Direct Claude Code interface*

#### **C-c f** - **F**onts
```
C-c f - Switch font presets (Fontaine)
```
*Mnemonic: "Fonts" - Quick font/accessibility changes*

#### **C-c g** - **G**PT/Generative AI (All AI Functions)
**Development AI:**
```
C-c g e - Explain code with AI
C-c g r - Review code with AI
C-c g d - Document code with AI
```

**Writing AI:**
```
C-c g i - Improve writing with AI
C-c g t - adjust Tone with AI
C-c g s - Summarize text with AI
C-c g x - eXpand text with AI
C-c g p - Proofread with AI
```
*Mnemonic: "GPT/Generative" - All AI assistance functions*

#### **C-c l** - **L**SP/Language Server Protocol
```
C-c l c - Connect/reconnect LSP
C-c l d - show Diagnostics
C-c l f f - Format File
C-c l f b - Format Buffer
C-c l r n - Rename symbol
C-c l s - Shutdown LSP
C-c l i - toggle Inlay hints
```
*Mnemonic: "LSP" - Language intelligence features*

#### **C-c s** - **S**pell Checking & Language Tools
**Traditional Spell Checking (Flyspell):**
```
C-c s c - Correct spelling
C-c s n - Next spelling error
C-c s l - switch Languages/dictionaries
```

**Code Spell Checking (Codespell):**
```
C-c s b - check Buffer
C-c s r - check Region
C-c s p - check Project
```
*Mnemonic: "Spell" - All spelling and language checking*

#### **C-c t** - **T**erminals & Shells
```
C-c t s - Shell
C-c t e - Eshell
C-c t t - Terminal (eat)
C-c t a - Ansi-term
C-c t p - Project terminal
```
*Mnemonic: "Terminal" - All shell/terminal interfaces*

#### **C-c x** - E**x**ecute/System Operations
```
C-c x r - Restart Emacs
```
*Mnemonic: "eXecute" - System-level operations*

#### **Single C-c Bindings (High-Frequency Actions)**
```
C-c b - Build/compile
C-c B - Build again (recompile)
C-c d - Delete pair of delimiters
C-c e - Environment commands (envrc: reload, allow, deny)
C-c j - Join/toggle window split orientation
C-c k - Kill buffer (bury)
C-c n - Next error (flymake)
C-c o - Olivetti focus mode
C-c p - Previous error (flymake)
C-c r - Replace with regexp
C-c w - Whitespace mode toggle
C-c W - Writegood mode toggle
```

### **C-x Prefix Extensions (File/Buffer/Window Operations)**

Building on Emacs conventions with modern enhancements:

#### **C-x C-** (Enhanced Core Operations)
```
C-x C-b - iBuffer (enhanced buffer manager)
C-x C-d - Dired recent directories
C-x C-j - Jump to current file in dired
```

#### **C-x g** - **G**it (Magit Integration)
```
C-x g     - Git status (Magit)
C-x M-g   - Git dispatch (Magit)
```
*Mnemonic: "Git" - Version control operations*

#### **C-x p** - **P**roject Operations (Enhanced project.el)
```
C-x p p - switch Project
C-x p f - Find file in project
C-x p g - Grep in project
C-x p d - find Directory in project
C-x p s - Shell in project
C-x p e - Eshell in project
C-x p b - project Buffers
```
*Mnemonic: "Project" - Project-aware operations*

#### **C-x r** - **R**anger File Browser (Extends rectangles)
```
C-x r d - Ranger Directory browser (3-pane)
C-x r j - ranger Jump (deer minimal mode)
```
*Mnemonic: "Ranger" - Extends built-in rectangle prefix*

#### **C-x t** - **T**reemacs File Tree
```
C-x t 1 - Delete other windows
C-x t t - Treemacs toggle
C-x t d - select Directory in treemacs
```
*Mnemonic: "Treemacs/Tree" - File tree operations*

### **Meta/Alt Key Patterns**

#### **Enhanced Text Editing**
```
M-<up>/M-<down> - Move text up/down
M-j             - Duplicate line/region
M-o             - Other window
M-$             - Spell correct (flyspell)
M-0             - Select treemacs window
```

#### **Smart Search & Navigation (Consult Integration)**
```
M-s c - Consult locate
M-s e - Explore isearch history
M-s g - Grep with consult
M-s G - Git grep with consult
M-s r - Ripgrep with consult
M-y   - Yank pop with consult
M-g g - Goto line with consult
```

### **Multiple Cursors (Advanced Editing)**
```
C-S-c C-S-c     - Edit lines (add cursors to each line in region)
C->             - Mark next occurrence
C-<             - Mark previous occurrence
C-c C-<         - Mark all occurrences
C-S-<mouse-1>   - Add cursor with mouse click
```

### **Modern Undo System**
```
C-z   - Undo (undo-tree)
C-S-z - Redo (undo-tree)
```
*Replaces traditional C-/ undo with more intuitive bindings*

### **Core Navigation (Replaces Some Emacs Defaults)**
```
C-f - Consult line search (was forward-char)
C-j - Consult imenu (was newline-and-indent)
C-/ - Smart comment toggle (was undo)
```

### **Enhanced Help System (Helpful)**
```
C-h f - Helpful callable (enhanced function help)
C-h v - Helpful variable (enhanced variable help)
C-h k - Helpful key (enhanced key help)
C-h x - Helpful command (enhanced command help)
```

## Keybinding Design Philosophy

### **1. Mnemonic Consistency**
- **First letter matches category**: `C-c g` = GPT, `C-c s` = Spell, `C-c t` = Terminal
- **Logical secondary letters**: `C-c g e` = GPT Explain, `C-c s c` = Spell Correct
- **Easy to remember**: Natural language associations

### **2. Frequency-Based Placement**
- **Single letters**: High-frequency actions (`C-c o` for focus mode)
- **Two letters**: Specific functions (`C-c g i` for improve writing)
- **Three letters**: Specialized operations (`C-c l f f` for format file)

### **3. Conflict Avoidance**
- **Uses C-c prefix extensively** (reserved for users in Emacs)
- **Careful C-x extensions** without breaking existing workflows
- **Strategic overrides** only when significantly better

### **4. Contextual Grouping**
- **AI functions**: All under `C-c g` prefix
- **Spell checking**: All under `C-c s` prefix
- **Terminals**: All under `C-c t` prefix
- **Project operations**: All under `C-x p` prefix

### **5. Accessibility Features**
- **Which-key integration**: Shows available options after prefix
- **Consistent patterns**: Reduces memorization burden
- **Visual mnemonics**: Letters match function names

### **Notable Enhancements to Emacs Defaults**

#### **Improved but Familiar**
- `C-f` → Consult line search (much better than forward-char)
- `C-j` → Consult imenu (more useful than newline-and-indent)
- `C-x b` → Consult buffer (enhanced buffer switching)

#### **Preserved Muscle Memory**
- `C-x C-f` → Find file (unchanged)
- `C-x C-s` → Save file (unchanged)
- Most fundamental Emacs bindings remain intact

#### **Smart Additions**
- `C-/` → Smart comment function (better than basic undo)
- Multiple cursor system for modern editing
- AI integration with logical keybindings

## Learning Strategy

### **Start with These Core Bindings**
1. **Navigation**: `C-f`, `C-x b`, `C-j`
2. **AI assistance**: `C-c g i`, `C-c g e`
3. **Project work**: `C-x p p`, `C-x p f`
4. **Focus**: `C-c o`, `C-c f`

### **Build Up Gradually**
- **Learn one prefix at a time** (start with `C-c g` for AI)
- **Use which-key** - it shows options after you press a prefix
- **Practice the mnemonics** - they become natural quickly

### **Advanced Features**
- **Multiple cursors** for bulk editing
- **Advanced search** with Consult integration
- **Specialized tools** like ranger file browser

### Core Package Ecosystem

This configuration is built on carefully selected packages that work together seamlessly. Here's what powers your Emacs experience:

### **🏗️ Foundation Layer**

#### **straight.el** - Package Management
- **What it does**: Downloads packages directly from Git repositories
- **Why it's better**: No package conflicts, reproducible builds, latest versions
- **How to use**: Packages install automatically when you save `lit.org`
- **Key feature**: Version locking with `straight/versions/default.el`

#### **use-package** - Configuration Framework
- **What it does**: Declarative package configuration with lazy loading
- **Why it's better**: Clean, organized config that loads fast
- **How to use**: All packages configured with `:bind`, `:custom`, `:hook` sections
- **Key feature**: Only loads packages when needed

#### **gcmh** - Garbage Collection Magic Hack
- **What it does**: Optimizes Emacs garbage collection for better performance
- **Why it's better**: Reduces pause times, smoother editing experience
- **How to use**: Works automatically in background
- **Key feature**: Smart GC scheduling

### **🔍 Completion & Navigation Framework**

#### **Vertico** - Vertical Completion UI
- **What it does**: Modern completion interface with vertical candidate list
- **Why it's better**: Clean, fast, keyboard-driven completion
- **How to use**: Appears automatically when you press `M-x`, `C-x b`, etc.
- **Key features**: Cycling, filtering, candidate count display

#### **Marginalia** - Rich Annotations
- **What it does**: Adds helpful information to completion candidates
- **Why it's better**: See file permissions, command documentation, variable values
- **How to use**: Information appears automatically in completions
- **Key features**: Function documentation, file details, buffer info

#### **Orderless** - Out-of-Order Matching
- **What it does**: Match completion candidates in any order
- **Why it's better**: Type `buf proj` to find "project-buffer", very flexible
- **How to use**: Just type partial matches in any order
- **Key features**: Space-separated patterns, regexp support

#### **Consult** - Enhanced Commands
- **What it does**: Supercharged versions of built-in Emacs commands
- **Why it's better**: Live previews, better search, project integration
- **How to use**:
  - `C-f` → Search with live preview
  - `C-x b` → Buffer switching with previews
  - `C-j` → Symbol navigation with context
  - `M-s r` → Project-wide search with context
- **Key features**: Preview, context, project awareness

#### **Corfu** - In-Buffer Completion
- **What it does**: Popup completion at point (like VS Code IntelliSense)
- **Why it's better**: Fast, lightweight, integrates with LSP
- **How to use**: Appears automatically while typing code
- **Key features**: Fuzzy matching, documentation popup, icons

#### **Cape** - Completion at Point Extensions
- **What it does**: Additional completion sources for Corfu
- **Why it's better**: File names, dictionary words, more completion options
- **How to use**: Works automatically with Corfu
- **Key features**: File completion, spell completion, template expansion

### **🤖 AI Integration Stack**

#### **gptel** - LLM Client
- **What it does**: Interface to language models (Z.AI GLM-5 default, local Ollama fallback)
- **Why it's better**: Cloud AI for quality, local models for privacy — switchable on the fly
- **How to use**: Powers all `C-c g` AI functions; switch backends with `C-c RET b` in gptel buffers
- **Key features**: Streaming responses, multiple backends, secure API key via `~/.authinfo.gpg`
- **Setup**: Add your Z.AI API key to `~/.authinfo.gpg`:
  ```
  machine api.z.ai login apikey password <your-z-ai-api-key>
  ```

#### **MCP (Model Context Protocol)** - Smart Context
- **What it does**: Provides project file context to AI
- **Why it's better**: AI knows about your project structure and files
- **How to use**: Works automatically with AI functions
- **Key features**: File system access, project awareness, RAG capabilities

#### **claude-code** - Direct Claude Integration
- **What it does**: Native Claude Code interface within Emacs
- **Why it's better**: Seamless integration, side-window display
- **How to use**: `C-c a` prefix for all Claude Code commands
- **Key features**: Split-window display, conversation history

### **✍️ Writing & Language Tools**

#### **Flyspell** - Traditional Spell Checker
- **What it does**: Reliable spell checking using ispell/aspell backend
- **Why it's reliable**: Well-tested, stable, works with syntax highlighting
- **How to use**:
  - `M-$` → Quick correction
  - `C-c s c` → Correct spelling
  - `C-c s l` → Switch dictionaries
- **Key features**: Multiple dictionaries, programming mode support

#### **writegood-mode** - Writing Analysis
- **What it does**: Identifies weasel words, passive voice, readability issues
- **Why it's better**: Improves writing clarity beyond spell checking
- **How to use**: Activates automatically in text modes
- **Key features**: Real-time analysis, highlighting, suggestions

#### **wc-mode** - Live Word Count
- **What it does**: Shows word/character/line count in mode line
- **Why it's better**: Track writing progress in real-time
- **How to use**: Displays `WC[words,chars,lines]` automatically
- **Key features**: Live updates, goal tracking, region counting

#### **Olivetti** - Distraction-Free Writing
- **What it does**: Centers text, hides distractions, creates focus environment
- **Why it's better**: Reduces cognitive load, improves writing focus
- **How to use**: `C-c o` to toggle focus mode
- **Key features**: Centered text, customizable margins, clean interface

### **🎨 Interface & Accessibility**

#### **Fontaine** - Font Management
- **What it does**: Easy switching between font presets
- **Why it's better**: Quick accessibility adjustments, consistent sizing
- **How to use**: `C-c f` to switch presets (including dyslexia-friendly)
- **Key features**: Multiple presets, accessibility support, per-face configuration

#### **ef-themes** - Modern Color Themes
- **What it does**: High-contrast, accessible color themes
- **Why it's better**: Designed for accessibility, excellent contrast ratios
- **How to use**: Dark (ef-cherie) and light (ef-summer) themes toggle
- **Key features**: Accessibility-focused, consistent colors, legible

#### **Pulsar** - Cursor Tracking
- **What it does**: Briefly highlights current line after certain commands
- **Why it's better**: Helps track cursor movement, excellent for accessibility
- **How to use**: Works automatically (pulsar on navigation commands)
- **Key features**: Cursor tracking, accessibility aid, customizable pulse

#### **which-key** - Command Discovery
- **What it does**: Shows available keybindings after pressing a prefix
- **Why it's better**: Reduces memorization burden, aids learning
- **How to use**: Wait after pressing `C-c`, `C-x`, etc.
- **Key features**: Popup help, organized display, searchable

#### **helpful** - Enhanced Help System
- **What it does**: Better documentation and help for Emacs functions/variables
- **Why it's better**: More information, better formatting, source code links
- **How to use**: `C-h f/v/k/x` for enhanced help
- **Key features**: Source links, better formatting, more context

### **📁 File & Project Management**

#### **dired-x** - Enhanced File Manager
- **What it does**: Extended functionality for Emacs built-in file manager
- **Why it's better**: Omit mode, smart commands, better file operations
- **How to use**:
  - `C-x C-j` → Jump to current file in dired
  - `C-x M-o` → Toggle omit mode (hide dotfiles)
- **Key features**: File omitting, command guessing, virtual dired

#### **dired-recent** - Recent Directories
- **What it does**: Quick access to recently visited directories
- **Why it's better**: Faster navigation to common locations
- **How to use**: `C-x C-d` for recent directory list
- **Key features**: Persistent history, fuzzy matching

#### **ranger** - Three-Pane File Browser
- **What it does**: File browser with parent/current/preview panes
- **Why it's better**: Visual file browsing, instant previews
- **How to use**:
  - `C-x r d` → Full ranger mode
  - `C-x r j` → Minimal deer mode
- **Key features**: File previews, three-pane layout, vim-like navigation

#### **Treemacs** - File Tree Sidebar
- **What it does**: File tree sidebar with Git integration
- **Why it's better**: Project overview, Git status, bookmark integration
- **How to use**: `C-x t t` to toggle, `M-0` to select
- **Key features**: Git indicators, project management, customizable

### **🔧 Development Tools**

#### **Eglot** - LSP Client
- **What it does**: Language Server Protocol client for code intelligence
- **Why it's better**: Built into Emacs, fast, reliable
- **How to use**: `C-c l` prefix for all LSP operations
- **Key features**: Auto-completion, diagnostics, refactoring, jump-to-definition

#### **Flymake** - Real-time Error Checking
- **What it does**: Shows syntax errors and warnings in real-time
- **Why it's better**: Immediate feedback, integrates with LSP
- **How to use**: `C-c n/p` for next/previous error
- **Key features**: Real-time checking, multiple backends, visual indicators

#### **Tree-sitter** (treesit-auto) - Advanced Syntax Parsing
- **What it does**: Better syntax highlighting and code understanding
- **Why it's better**: More accurate parsing, better performance
- **How to use**: Works automatically for supported languages
- **Key features**: Incremental parsing, better highlighting, structural editing

#### **nix-ts-mode** - Nix Expression Editing
- **What it does**: Tree-sitter powered syntax highlighting for `.nix` files
- **Why it's better**: Accurate AST-level parsing for Nix expressions
- **How to use**: Opens automatically for `.nix` files
- **Key features**: Full syntax highlighting, structural awareness

#### **Magit** - Git Interface
- **What it does**: Powerful Git interface with staging, committing, branching
- **Why it's better**: More powerful than command line, visual workflow
- **How to use**: `C-x g` for status, learn the magit workflow
- **Key features**: Visual staging, branch management, commit interface

#### **diff-hl** - Git Diff Indicators
- **What it does**: Shows modified lines in the fringe
- **Why it's better**: Visual feedback for changes, git integration
- **How to use**: Appears automatically in git repositories
- **Key features**: Visual diff indicators, real-time updates

### **💻 Terminal Integration**

#### **eat** - Modern Terminal Emulator
- **What it does**: Full-featured terminal emulator within Emacs
- **Why it's better**: Better than built-in term modes, more features
- **How to use**: `C-c t t` for terminal, `C-c t p` for project terminal
- **Key features**: Full terminal emulation, better performance

### **✏️ Text Editing Enhancements**

#### **multiple-cursors** - Multi-Point Editing
- **What it does**: Edit multiple locations simultaneously
- **Why it's better**: Powerful bulk editing, better than search/replace
- **How to use**:
  - `C->` → Mark next occurrence
  - `C-S-c C-S-c` → Edit lines
  - `C-c C-<` → Mark all occurrences
- **Key features**: Smart selection, visual feedback, undo support

#### **move-text** - Text Movement
- **What it does**: Move lines or regions up and down
- **Why it's better**: Quick reorganization without cut/paste
- **How to use**: `M-↑/↓` to move text
- **Key features**: Smart indentation, region support

#### **undo-tree** - Advanced Undo System
- **What it does**: Tree-based undo with persistent history
- **Why it's better**: Never lose changes, visual undo tree, persistent across sessions
- **How to use**: `C-z/C-S-z` for undo/redo
- **Key features**: Persistent history, tree visualization, branch navigation

#### **rainbow-delimiters** - Bracket Highlighting
- **What it does**: Color-codes matching brackets/parentheses by depth
- **Why it's better**: Easier to read nested code, visual depth indication
- **How to use**: Works automatically in programming modes
- **Key features**: Depth-based coloring, customizable colors

### **🔗 Integration Packages**

#### **envrc** - Buffer-Local Environment Management
- **What it does**: Loads project-specific environment variables via direnv, buffer-locally
- **Why it's better**: Each buffer gets its own environment; essential for Nix devshell workflows
- **How to use**: Works automatically for files inside direnv-managed projects
- **Key features**: Buffer-local isolation, Nix devshell support, `C-c e` command map for reload/allow/deny

#### **editorconfig** - Consistent Code Style
- **What it does**: Applies project-defined coding standards
- **Why it's better**: Consistent formatting across team/projects
- **How to use**: Works automatically when `.editorconfig` file present
- **Key features**: Cross-editor compatibility, project standards

## How Packages Work Together

### **The Completion Stack**
`Vertico` + `Marginalia` + `Orderless` + `Consult` create a powerful completion experience where:
- You can search out-of-order (`buf proj` finds "project-buffer")
- See rich information about candidates
- Get live previews of files and buffers
- Navigate with keyboard efficiently

### **The AI Stack**
`gptel` + `MCP` + custom functions provide comprehensive AI assistance:
- Local privacy with your Ollama instance
- Project-aware context through MCP
- Custom functions for specific workflows
- Writing and coding assistance integrated

### **The Writing Stack**
`Flyspell` + `writegood-mode` + `wc-mode` + `Olivetti` + AI functions create a complete writing environment:
- Traditional spell checking with multiple languages
- Style analysis beyond spelling
- Progress tracking with word counts
- Distraction-free focus mode
- AI-powered improvement suggestions

### **The Development Stack**
`Eglot` + `Flymake` + `Tree-sitter` + `Magit` + project tools provide a complete IDE:
- Language intelligence through LSP
- Real-time error checking
- Advanced syntax understanding
- Powerful Git workflow
- Project-aware file management

### Understanding the Architecture

### Literate Programming Approach
- **Edit `lit.org`**, not `init.el` directly
- **Automatic tangling** - changes save to `init.el` automatically
- **Documentation with code** - explanations live alongside configuration
- **Easy customization** - find what you want to change and modify it

### Package Management
- **straight.el** manages packages directly from Git
- **use-package** provides clean, declarative configuration
- **No package conflicts** - reproducible setup across machines

### Keybinding Organization
All custom keybindings use consistent prefixes:
- `C-c g` - All AI functions (code and writing)
- `C-c s` - Spell checking and language tools
- `C-c t` - Terminal and shell commands
- `C-c a` - Claude Code integration
- `C-x p` - Project management
- `C-x r` - File browser functions

### Development Workflow Reference

### Starting a Project
1. **Navigate to project**: `C-x p p` (project switch)
2. **Find files quickly**: `C-x p f` (project find file)
3. **Search across project**: `M-s r` (ripgrep search)
4. **Open project terminal**: `C-c t p`

### Code Understanding
1. **Select unfamiliar code**
2. **Press `C-c g e`** for AI explanation
3. **Use `C-c g r`** for improvement suggestions
4. **Jump to definitions** with LSP (automatic in most languages)

### Version Control
- **Git status**: `C-x g` (opens Magit)
- **See changes visually** - diff indicators appear in the fringe
- **Stage and commit** through Magit interface

### Configuration Validation (Optional but Recommended)
To prevent Emacs configuration syntax errors:

```bash
# One-time setup
python3 -m venv .venv
source .venv/bin/activate
pip install pre-commit
pre-commit install
```

This automatically validates your configuration before commits, preventing syntax errors that could break Emacs startup.

### Writing Workflow Reference

### Setting Up for Writing
1. **Open your document** (Markdown, text, or Org file)
2. **Enable focus mode**: `C-c o` (Olivetti)
3. **Switch to writing font**: `C-c f` → choose appropriate preset
4. **Notice live word count** in the mode line: `WC[words,chars,lines]`

### AI-Enhanced Writing Process
1. **Draft your content** normally
2. **Select paragraphs** and use:
   - `C-c g i` - Improve clarity and grammar
   - `C-c g t` - Adjust tone for audience
   - `C-c g s` - Create summaries
   - `C-c g p` - Comprehensive proofreading

### Spell Checking & Grammar
- **Automatic spell check** with traditional Flyspell
- **Quick corrections**: `M-$` on misspelled words
- **Grammar analysis** automatic with writegood-mode
- **Advanced spell options**: `C-c s` prefix commands

### Accessibility Features Reference

This configuration is designed with accessibility in mind:

### For Dyslexic Users
- **OpenDyslexic font preset** available via `C-c f`
- **Enhanced visual feedback** for spelling errors
- **Pulsar mode** highlights cursor movement
- **Clear color coding** throughout interface

### For All Users
- **Consistent keybindings** with logical prefixes
- **Helpful mode** shows better documentation
- **Which-key** displays available commands
- **Rich completion** with context and previews

### Advanced Customization Reference

### Adding Your Own Functions
Edit `lit.org` and add functions in the "Custom Commands & Bindings" section. The configuration will automatically reload when you save.

### Changing Keybindings
Find the relevant section in `lit.org` and modify the `:bind` declarations in use-package blocks.

### Adding Packages
Use the `use-package` format following existing patterns. The configuration uses `straight.el` so packages come directly from Git repositories.

### AI Configuration
The AI functions connect to your local Ollama instance. Modify the `gptel` configuration in `lit.org` to change models or endpoints.

## Troubleshooting & Common Issues

### **Installation Issues**
- **"Package not found" errors**: Run `M-x straight-pull-all` then `M-x straight-rebuild-all`
- **Slow first startup**: Normal - packages are installing (2-3 minutes)
- **Font issues**: Install Source Code Pro or choose different preset with `C-c f`
- **Native compilation warnings**: Normal - they'll disappear after packages compile

### **Configuration Issues**
- **Changes don't take effect**: Edit `lit.org`, not `init.el`. Save to auto-tangle
- **Keybinding doesn't work**: Use `C-h k` then press key to see what it's bound to
- **Package seems broken**: Try `M-x straight-rebuild-package` then restart Emacs

### **Performance Issues**
- **Slow startup**: Check `*Messages*` buffer for errors, consider removing unused packages
- **High memory usage**: Normal for rich features, but restart Emacs if it gets excessive
- **Laggy typing**: Disable some visual features temporarily, check for runaway processes

### **AI & External Tool Issues**
- **AI auth errors**: Verify `~/.authinfo.gpg` contains `machine api.z.ai login apikey password <key>` and that GnuPG is installed
- **AI functions not working (Z.AI)**: Test with `M-: (gptel-api-key-from-auth-source "api.z.ai")` — should return your key after GPG passphrase prompt
- **AI functions not working (Ollama)**: Switch to Ollama backend with `C-c RET b` and verify Ollama running at `192.168.16.172:11434`
- **Spell check not working**: Install `aspell` or `hunspell` system packages
- **LSP not starting**: Install language server for your language (e.g., `pip install pyright`)
- **Search not working**: Install `ripgrep` (`rg` command)

### **Getting Help**
- **Immediate help**: `C-h k` (what does this key do?) or `C-h f` (what does this function do?)
- **Available commands**: `M-x` then type to search all commands
- **Package documentation**: `C-h P` then type package name
- **Configuration docs**: Read `lit.org` - it's designed to be human-readable

### **When Things Break**
1. **Stay calm**: `C-g` cancels any stuck command
2. **Check messages**: `C-x b *Messages*` for error details
3. **Restart if needed**: `C-c x r` (restart Emacs)
4. **Restore backup**: If all else fails, restore your backup configuration

### **Reset Nuclear Option**
If configuration is completely broken:
```bash
mv ~/.config/emacs ~/.config/emacs-broken
git clone [repo-url] ~/.config/emacs
```

## Customization & Next Steps

### **Safe Customization**
- **Always edit `lit.org`** (never edit `init.el` directly)
- **Test changes incrementally** (save `lit.org` after small changes)
- **Use version control** (`git add` and `git commit` your changes)
- **Keep backups** of working configurations

### **Common Customizations**
- **Add keybindings**: Find similar bindings in `lit.org` and copy the pattern
- **Change fonts**: Edit the fontaine presets section
- **Add packages**: Follow existing `use-package` patterns
- **Modify AI prompts**: Edit the AI function definitions

### **Growing Your Configuration**
- **Week 1**: Master basic navigation and AI features
- **Week 2**: Learn project management and Git workflow
- **Week 3**: Customize keybindings and add packages for your languages
- **Week 4**: Create your own custom functions and workflows

## Complete Reference

The following sections contain comprehensive reference material. Use them as needed, but don't feel pressured to learn everything at once.

### Advanced Features to Explore

### Explore Advanced Features
- **MCP integration** for project-aware AI assistance
- **Tree-sitter** for better syntax highlighting
- **Advanced project management** with project.el
- **Terminal integration** with eat

### Customize for Your Needs
- **Add language-specific configurations**
- **Create custom AI prompts**
- **Set up additional spell check languages**
- **Configure additional font presets**

### Learn the Ecosystem
- **Magit** for Git operations
- **Org-mode** for note-taking and planning
- **Consult/Vertico** for enhanced search and completion
- **LSP via Eglot** for language intelligence

### Getting Help Reference

- **Built-in help**: `C-h` prefix commands, enhanced with Helpful
- **Which-key**: Wait after `C-c` or other prefixes to see options
- **Configuration docs**: Read `lit.org` - it's designed to be human-readable
- **Command discovery**: `M-x` with completion shows all available commands

## Migration Guide: Coming from Other Editors

### **From Vim/Neovim**

If you're coming from Vim, this Emacs configuration provides familiar concepts with enhanced capabilities:

#### **Modal vs. Non-Modal Editing**
- **Emacs is non-modal** - you type text directly without mode switching
- **Multiple cursors replace visual block mode** - `C-S-c C-S-c` for line editing
- **Smart commenting** with `C-/` (similar to `gcc` in Vim)
- **Text objects via selection** - select text first, then operate on it

#### **Navigation Equivalents**
| Vim Command | This Emacs Config | Description |
|-------------|-------------------|-------------|
| `:e filename` | `C-x C-f` or `C-x f` | Find/open file |
| `:b buffer` | `C-x b` | Switch buffer (with fuzzy matching) |
| `/search` | `C-f` | Search in buffer (with live preview) |
| `*` / `#` | `C->` / `C-<` | Mark next/previous occurrence |
| `:%s/old/new/g` | `C-c r` | Replace with regexp |
| `:vs` / `:sp` | `C-c j` | Toggle window split |
| `gt` / `gT` | `C-x b` | Switch between buffers |
| `:terminal` | `C-c t t` | Open terminal |

#### **Vim-Style Features Available**
- **Project-wide search**: `M-s r` (ripgrep) instead of `:grep`
- **File tree**: `C-x t t` (Treemacs) instead of NERDTree
- **Git integration**: `C-x g` (Magit) instead of vim-fugitive
- **LSP support**: `C-c l` prefix instead of coc.nvim or built-in LSP
- **Fuzzy finding**: `C-x p f` instead of telescope/fzf

#### **AI Enhancements (Beyond Vim)**
- **Code explanation**: `C-c g e` - AI explains selected code
- **Writing assistance**: `C-c g i` - AI improves selected text
- **Smart completion**: Works automatically (like nvim-cmp)

#### **What You'll Love**
- **No plugin conflicts** - everything works together
- **Better discoverability** - which-key shows available commands
- **Consistent keybindings** - logical mnemonics throughout
- **Powerful text manipulation** - multiple cursors, smart movement

### **From VS Code**

This configuration provides VS Code's best features with additional power:

#### **Familiar Features, Enhanced**
| VS Code Feature | This Emacs Config | Enhancement |
|-----------------|-------------------|-------------|
| Command Palette | `M-x` | More comprehensive, all commands |
| Quick Open | `C-x f` | Fuzzy search with previews |
| Go to Symbol | `C-j` | Consult-imenu with live preview |
| Search in Files | `M-s r` | Ripgrep with context |
| Multi-cursor | `C->`, `C-S-c C-S-c` | More powerful selection modes |
| Terminal | `C-c t t` | Multiple terminal types |
| Git integration | `C-x g` | Magit (more powerful than VS Code) |
| Extensions | Built-in packages | No conflicts, faster startup |

#### **AI Integration (ChatGPT/Copilot Alternative)**
- **Local AI model** - your data stays private
- **Context-aware**: Knows about your project files
- **Multiple AI functions**: Explain, improve, summarize, review
- **Writing assistance**: Beyond just code completion

#### **Project Management**
- **Project switching**: `C-x p p` (like "Recent" in VS Code)
- **Project-wide search**: `C-x p g` with live results
- **Project terminal**: `C-c t p` opens in project root
- **File finding**: `C-x p f` with fuzzy matching

#### **LSP (Language Server Protocol)**
- **Same LSP servers** as VS Code work here
- **Better performance** - native Emacs integration
- **Consistent interface** - `C-c l` prefix for all LSP operations
- **Real-time diagnostics** with flymake

#### **What's Different (Better)**
- **Keyboard-first** - everything accessible via keys
- **Highly customizable** - modify any behavior
- **No Electron overhead** - faster, uses less memory
- **Literate configuration** - documentation with code
- **Powerful text editing** - designed for text manipulation

### **Editor Philosophy Differences**

#### **Vim → Emacs Mindset**
- **From modes to modeless** - no insertion vs command modes
- **From commands to functions** - operations are functions, not commands
- **From minimal to comprehensive** - Emacs is an environment, not just an editor
- **From plugins to packages** - integrated ecosystem vs separate tools

#### **VS Code → Emacs Mindset**
- **From mouse to keyboard** - optimize for keyboard efficiency
- **From settings UI to code** - configuration is programmable
- **From extensions to packages** - deeper integration possible
- **From GUI to text-based** - powerful within terminal or GUI

### **Learning Path for Migrants**

#### **Week 1: Basic Navigation**
1. **Learn core movement**: `C-f`, `C-x b`, `C-j`
2. **Try AI assistance**: Select text, use `C-c g i` or `C-c g e`
3. **Use project features**: `C-x p p`, `C-x p f`
4. **Practice window management**: `C-c j`, `M-o`

#### **Week 2: Advanced Editing**
1. **Multiple cursors**: `C->` for selections, `C-S-c C-S-c` for lines
2. **Text manipulation**: `M-↑/↓` to move text
3. **Smart commenting**: `C-/` for regions and lines
4. **Search and replace**: `C-c r` for regexp replacement

#### **Week 3: Workflow Integration**
1. **Git with Magit**: `C-x g` for status, learn staging/committing
2. **Terminal integration**: `C-c t p` for project terminals
3. **LSP features**: `C-c l` prefix for language intelligence
4. **Writing mode**: `C-c o` for focus, AI writing assistance

#### **Week 4: Customization**
1. **Edit `lit.org`** - modify keybindings and add packages
2. **Font accessibility**: `C-c f` for different presets
3. **Create custom AI prompts** - modify the AI functions
4. **Add language-specific configurations**

### **Common Migration Pitfalls**

#### **From Vim**
- **Don't look for modes** - Emacs is always in "insert mode"
- **Use selection first** - select text, then operate (opposite of Vim)
- **Embrace the mouse** - it's okay to use it occasionally
- **Learn incremental search** - `C-f` is more powerful than `/`

#### **From VS Code**
- **Keyboard over mouse** - resist reaching for the mouse
- **Learn the help system** - `C-h` is more comprehensive than VS Code
- **Embrace text configuration** - don't look for settings GUI
- **Trust the integration** - packages work together better than VS Code extensions

### **Why This Migration Is Worth It**

#### **Unique Advantages**
- **AI integration with privacy** - local models, your data stays local
- **Literate programming** - documentation and configuration together
- **Unlimited customization** - modify any behavior
- **Powerful text editing** - designed for text manipulation
- **Consistent environment** - same interface for code, writing, email, etc.
- **Performance** - no Electron, efficient memory usage
- **Longevity** - Emacs has been stable for decades

#### **What You Gain**
- **Efficiency** - keyboard-driven workflow
- **Power** - more sophisticated text manipulation
- **Integration** - everything works together
- **AI assistance** - beyond simple completion
- **Accessibility** - dyslexia-friendly options built-in
- **Flexibility** - adapt the editor to your needs

---

**Remember**: This configuration grows with you. Start with the basics, then gradually explore the advanced features as you become comfortable. The AI assistance is there to help you understand both your code and your writing better.

**Migration tip**: Keep your old editor available for the first month while you build muscle memory. Most users find themselves preferring Emacs within 2-3 weeks of consistent use.

Happy Emacs-ing! 🎉
