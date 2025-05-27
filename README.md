# send2tmux

This simple plugin sends text from Neovim to a neighboring tmux pane. Use it to
develop a (shell, python, R ...) script in Neovim while testing in in the REPL
running in a tmux pane next to it. This approach is language agnostic: It works
for any language having a REPL. The downside is - maybe - that you have to
start the (right) REPL yourself.


## Installation

Use your favorite plugin manager. For `packer.nvim`:

```lua
use { 'adrianschlatter/send2tmux' }
```


## Configuration

You'll want keybinding to use `send2tmux`. If you want that

* `<leader>ss` in normal mode sends the current line to tmux
* `<leader>s` in visual mode sends the selection to tmux
* `<leader>s<motion>` in normal mode sends the text defined by the <motion> to
  tmux. <motion> is any vim motionFor example, `<leader>sap` sends the paragraph under the cursor, or
  `<leader>si(` sends the text inside parentheses.

then add the following to your config (e.g., in your `init.lua`):

```lua
local send2tmux = require('send2tmux')
vim.keymap.set('n', '<leader>ss', send2tmux.send_current_line,
        { noremap = true, silent = true, desc = 'send current line to tmux' })
vim.keymap.set('v', '<leader>s', send2tmux.send_selection,
        { noremap = true, silent = true, desc = 'send selection to tmux' })
vim.keymap.set('n', '<leader>s',
        [[:set opfunc=v:lua.require'send2tmux'.send_text_with_motion<CR>g@]],
        { noremap = true, silent = true,
        desc = 'send text with motion to tmux' })
```


## Usage

Start a tmux session, open nvim in one pane and open, say, `fantastic.py`.
Start a python REPL, say, `ipython --pylab` in the neighboring tmux pane. Send
over parts of your script to the REPL while keeping the focus within nvim. Of
course, you can switch over to the REPL and use it directly whenever you want.


## Still reading?

If you read this far, you're probably not here for the first time. If you use
and like this project, would you consider giving it a Github Star? (The button
is at the top of this website.) If not, maybe you're interested in one of
[my other projects](
https://github.com/adrianschlatter/ppf.sample/blob/develop/docs/list_of_projects.md)?


## Change Log

* 0.0:      Initial draft
