# alex-fddz's dotfiles

Use GNU Stow.

## Structure

Clone into `~/.dotfiles`.
Each module dir mirrors `~/`:

```
tree -La 5 -I ".git|README.*"
```

## Stow

From repo root:

```
stow -v <pkg> # or */ for all
```

### Exceptions

* Firefox: use `firefox/stow.sh`.

### Fallback

```
ln -s "$PWD/vim/.vimrc" ~/.vimrc
```

