# Check pyenv
pyenv --version
# Install global python version with pyenv
pyenv install 3.9.2
pyenv global 3.9.2

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
source $HOME/.poetry/env

poetry --version
poetry config virtualenvs.in-project true

# Create Oh-My-Zsh completions
# see: https://python-poetry.org/docs/
mkdir $ZSH_CUSTOM/plugins/poetry
poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry
