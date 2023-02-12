# Neverflix

Neverflix is a simple bash script that will scrape the website 1337xxx.to, fetch the magnet url of torrent for the requested movie/show and stream it using peerflix.


## Dependencies

- `peerflix`
- `node (nodejs)`
- `curl`
- `mpv`
- `fzf`
- `bash`


## Installation

1. First install the dependencies listed above using your package manager
2. Follow the following instructions


### Root install using git (You can use this if you're not sure which install method to pick)

```bash
git clone https://github.com/zypherfunk/neverflix
cd neverflix
sudo cp neverflix.sh /usr/local/bin/neverflix
cd ..
rm -rf neverflix/
```


### Root install using curl

```bash
curl -L "https://raw.githubusercontent.com/zypherfunk/neverflix/main/neverflix.sh" | sudo tee /usr/local/bin/neverflix
sudo chmod +x /usr/local/bin/neverflix
```


### User install using curl

```bash
curl -L "https://raw.githubusercontent.com/zypherfunk/neverflix/main/neverflix.sh" > ~/.local/bin/neverflix
chmod +x ~/.local/bin/neverflix
```

Add ~/.local/bin to PATH if not added. Change to zshrc if your'e using that.

```bash
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
```


### Usage

`neverflix <Search Term>`

Eg: `neverflix Mr Robot`
