# alex-fddz's dotfiles

Use GNU Stow.

## Structure

Clone into `~/.dotfiles`.
Each module dir mirrors `~/`:

```
tree -La 4 -I ".git|README.*"
```

## Stow

From repo root:

```
stow -v <pkg> # or */ for all
```

## Stowless

```
ln -s "$PWD/vim/.vimrc" ~/.vimrc
```
