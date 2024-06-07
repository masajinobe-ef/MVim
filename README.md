# 💤 LazyVim

Install the LazyVim 

Make a backup of your current Neovim files:

```sh
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/masajinobe-ef/nvim-config ~/.config/nvim
```

Start Neovim!

for Windows:

```sh
# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak

git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
```
