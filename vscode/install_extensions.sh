set -e
set -u

extensions=$(code --list-extensions)

if echo $extensions | grep -q streetsidesoftware.code-spell-checker; then
  echo [✓] Code Spell Checker
else
  code --install-extension streetsidesoftware.code-spell-checker
  echo [✓] Code Spell Checker
fi

if echo $extensions | grep -q zhuangtongfa.material-theme; then
  echo [✓] One Dark Pro
else
  code --install-extension zhuangtongfa.material-theme
  echo [✓] One Dark Pro
fi

if echo $extensions | grep -q jdinhlife.gruvbox; then
  echo [✓] Gruvbox Theme
else
  code --install-extension jdinhlife.gruvbox
  echo [✓] Gruvbox Theme
fi

if echo $extensions | grep -q oderwat.indent-rainbow; then
  echo [✓] indent-rainbow
else
  code --install-extension oderwat.indent-rainbow
  echo [✓] indent-rainbow
fi

if echo $extensions | grep -q vscode-icons-team.vscode-icons; then
  echo [✓] vscode-icons
else
  code --install-extension vscode-icons-team.vscode-icons
  echo [✓] vscode-icons
fi

if echo $extensions | grep -q ms-vscode-remote.remote-ssh; then
  echo [✓] Remote - SSH
else
  code --install-extension ms-vscode-remote.remote-ssh
  echo [✓] Remote - SSH
fi

if echo $extensions | grep -q ms-vscode.remote-explorer; then
  echo [✓] Remote Explorer
else
  code --install-extension ms-vscode.remote-explorer
  echo [✓] Remote Explorer
fi

if echo $extensions | grep -q rust-lang.rust-analyzer; then
  echo [✓] rust-analyzer
else
  code --install-extension rust-lang.rust-analyzer
  echo [✓] rust-analyzer
fi

if echo $extensions | grep -q tamasfe.even-better-toml; then
  echo [✓] Even Better TOML
else
  code --install-extension tamasfe.even-better-toml
  echo [✓] Even Better TOML
fi
