# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository using **GNU Stow** for configuration management. Each top-level directory is a "package" containing configuration files that mirror the home directory structure.

## Stow-Based Architecture

### How It Works

- Each package directory (e.g., `git/`, `tmux/`, `neovim/`) mirrors the target home directory structure
- Example: `git/.config/git/config` → `~/.config/git/config`
- Running `make stow` creates symlinks from the repository to your home directory
- Existing files are automatically backed up with timestamps before being replaced

### Package Structure

```
dotfiles/
├── git/.config/git/          → ~/.config/git/
├── neovim/.config/nvim/      → ~/.config/nvim/
├── tmux/.config/tmux/        → ~/.config/tmux/
├── zsh/.config/zsh/          → ~/.config/zsh/
├── bin/.local/bin/           → ~/.local/bin/
└── zshrc                     → ~/.zshrc (special case: root-level file)
```

**Important**: The root-level `zshrc` file is a special case - it gets symlinked directly to `~/.zshrc`, not to `~/zshrc`.

## Essential Commands

### Stow Management

```bash
make stow      # Create symlinks for all packages (includes automatic backup)
make restow    # Reapply symlinks after configuration changes
make unstow    # Remove all symlinks (CAUTION: dangerous operation)
make debug     # Dry run to preview what would be linked
make help      # Display all available targets
```

### Package Management

```bash
brew bundle                  # Install/update all packages from Brewfile
brew bundle --cleanup        # Remove packages not listed in Brewfile
brew bundle dump --force     # Update Brewfile with currently installed packages
```

### Submodules

The repository includes git submodules (e.g., ranger_devicons plugin):

```bash
git submodule update --init --recursive    # Initialize submodules after cloning
```

## Key Configuration Patterns

### Git Configuration

- **Delta pager**: Enhanced diff visualization with side-by-side view
- **nvimdiff**: Used for both diff and merge operations
- **Personal settings**: Use `~/.gitconfig.local` for user-specific config (name, email, etc.)
- **Aliases**: `pr` (pull rebase), `fp` (fetch prune), `hist` (formatted log), `co` (checkout), `root` (show repo root)
- **Default branch**: `main`
- **Auto setup remote**: Push automatically sets upstream branch

Configuration file: `git/.config/git/config`

### Zsh Configuration

- **Plugin manager**: Zinit (auto-installs on first run)
- **Prompt**: Starship (cross-shell prompt)
- **Navigation**: zoxide (smart cd replacement)
- **History**: 130,000 entries, shared across sessions, deduplication enabled
- **Custom bindkeys**:
  - `Ctrl+F`: Launch file finder
  - `Ctrl+N`: Open file manager (vifm)
  - `Ctrl+S`: Start search
- **FZF integration**: File previews with bat and tree
- **PATH additions**: Custom scripts in `~/.local/bin`, `~/go/bin`, and project-specific directories

Configuration file: Root-level `zshrc`

### Tmux Configuration

- **Prefix key**: `Ctrl+A` (not the default `Ctrl+B`)
- **Mode**: Vi-mode keybindings (`setw -g mode-keys vi`)
- **Status bar**: Top position (macOS style)
- **Key features**:
  - Mouse support enabled
  - System clipboard integration
  - Detach-on-destroy off (don't exit when closing session)
  - Window renumbering enabled
  - Focus events for Neovim compatibility
- **Quick edits**: `Ctrl+A, Ctrl+E` opens tmux.conf in editor
- **Reload config**: `Ctrl+A, Ctrl+R`

Configuration file: `tmux/.config/tmux/tmux.conf`

### Neovim Configuration

- **Base**: LazyVim distribution
- **Entry point**: `neovim/.config/nvim/init.lua`
- **Plugin manager**: lazy.nvim (bootstrapped automatically)
- **Structure**: Configuration loaded via `require("config.lazy")`

Configuration directory: `neovim/.config/nvim/`

## Custom Scripts and Utilities

### Location

All custom scripts are in `bin/.local/bin/` which is automatically added to PATH via zshrc.

### Notable Scripts

- `tmux-sessionizer`: Tmux session management helper
- `fzf-*`: FZF-based utilities (speed, command runner, jq integration)
- `jvm-*.sh`: Java/JVM version management scripts
- `tat`: Attach to tmux session helper

## Important Files

### Configuration Entry Points

- `zshrc` - Main shell configuration (root-level, not in a package directory)
- `git/.config/git/config` - Git configuration with delta and nvimdiff setup
- `tmux/.config/tmux/tmux.conf` - Tmux configuration with Ctrl+A prefix
- `neovim/.config/nvim/init.lua` - Neovim entry point
- `Brewfile` - Package manifest for Homebrew

### Ignored Files

The `.gitignore` excludes:
- Plugin directories (Zinit, tmux plugins)
- State files and caches
- `zshrc.zwc` (compiled zsh config)
- Python `__pycache__`
- Log files

### Personal Settings

- **Git**: Create `~/.gitconfig.local` for user-specific settings (name, email, signing keys)
- **Zsh**: Can source additional files from `~/dev/config/` directory if they exist

## Common Workflows

### Initial Setup

```bash
# Clone repository
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Initialize submodules
git submodule update --init --recursive

# Install Homebrew packages
brew bundle

# Create symlinks (automatically backs up existing files)
make stow
```

### Making Configuration Changes

```bash
# Edit configuration files in the repository
nvim git/.config/git/config

# Reapply symlinks (usually not needed since files are symlinked)
make restow

# For changes to Brewfile
brew bundle
```

### Adding a New Package

1. Create a new directory mirroring home structure (e.g., `newapp/.config/newapp/`)
2. Add configuration files inside
3. Run `make restow` to create symlinks

## Tool Versions and Dependencies

The Brewfile manages 200+ packages including:
- Languages: Python 3.13, Go, Rust, Node.js (via fnm), Ruby, Java (multiple versions)
- CLI tools: ripgrep, fd, fzf, jq, yq, kubectl, helm, terraform
- Development: Docker, VS Code, IntelliJ IDEs, Neovim
- Fonts: Nerd fonts, SF Pro, Fira Code

## Notes for Claude Code

- **Never use `--no-verify`** when making git commits
- **Text files should end with an empty line** (per .editorconfig standards)
- **Follow existing patterns**: When modifying configs, match the style and structure of existing files
- **Test changes incrementally**: Use `make debug` before `make stow` to preview changes
- **Respect .gitconfig.local**: Don't commit personal git settings; those belong in the local file
