# Neovim Cheat Sheet (AstroNvim – Go Setup)

========================================
LSP NAVIGATION
========================================

gd            Go to definition
gD            Go to declaration
gr            Find all references (list)
gri           Go to implementation
grt           Go to type definition
K             Hover documentation
<leader>rn   Rename symbol
gra           Code actions

========================================
JUMPING AROUND (BACK / FORWARD)
========================================

<C-o>         Jump back
<C-i>         Jump forward
<leader>h    Jump back (alias)
<leader>l    Jump forward (alias)
:jumps        Show jump list

========================================
FORMATTING
========================================

:w            Format on save (Go)
:lua vim.lsp.buf.format()
              Format buffer manually

========================================
DIAGNOSTICS
========================================

]d            Next diagnostic
[d            Previous diagnostic
:lua vim.diagnostic.open_float()
              Show diagnostic under cursor

========================================
TERMINAL
========================================

<leader>t    Toggle terminal
<Esc>        Exit terminal mode

Shell: bash
Config sourced from: ~/.bashrc (via ~/.bash_profile)

========================================
FILES & PROJECT
========================================

<leader>e    Toggle file tree
<leader>ff   Find file
<leader>fw   Find text (ripgrep)
<leader>fr   Recent files
<leader>fb   Buffers

========================================
BUFFERS & WINDOWS
========================================

]b            Next buffer
[b            Previous buffer
<leader>bd   Close buffer

<C-w>s        Horizontal split
<C-w>v        Vertical split
<C-w>h/j/k/l  Move between splits

========================================
GIT
========================================

]h            Next hunk
[h            Previous hunk
<leader>hp   Preview hunk
<leader>hb   Blame line

========================================
WHICH-KEY
========================================

<leader>     Show leader key mappings
g            Show g-prefix mappings

========================================
NOTES
========================================

- gd / gr are explicitly overridden in astrocore.lua
- LSP configuration lives in astrolsp.lua
- Go format-on-save enforced via polish.lua
- Jump list = Vim's equivalent of VS Code back/forward
