#!/bin/bash
set -x

brew update
brew install ripgrep git make unzip gcc xclip nodejs go powershell gopls

# install npm packages (azure lsp, bash lsp, and other nvim requirements)
npm install -g azure-pipelines-language-server
npm i -g bash-language-server

# install powershell_es package
PSES_TARGET_DIR="/opt/powershell_es"
PSES="powershell_es.zip"
sudo mkdir $PSES_TARGET_DIR
sudo chmod 777 $PSES_TARGET_DIR
curl -L -o $PSES "https://github.com/PowerShell/PowerShellEditorServices/releases/download/v3.20.1/PowerShellEditorServices.zip"
unzip -f $PSES -d $PSES_TARGET_DIR
rm -f $PSES


