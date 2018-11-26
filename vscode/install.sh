#!/bin/sh
if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi
	mkdir -p "$VSCODE_HOME/User"

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -sf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	# from `code --list-extensions`
	modules="
    CraigMaslowski.erb
    Riey.erb
    annsk.alignment
    atefth.ruby-on-rails-snippets
    castwide.solargraph
    dbaeumer.vscode-eslint
    deerawan.vscode-whitespacer
    DotJoshJohnson.xml
    dzannotti.vscode-babel-coloring
    earshinov.simple-alignment
    emilast.LogFileHighlighter
    felixfbecker.php-intellisense
    formulahendry.auto-rename-tag
    groksrc.ruby
    HookyQR.beautify
    hoovercj.ruby-linter
    karunamurti.rspec-snippets
    linyang95.php-symbols
    mbessey.vscode-rufo
    mikestead.dotenv
    misogi.ruby-rubocop
    mohsen1.prettify-json
    ms-vscode.csharp
    noku.rails-run-spec-vscode
    PeterJausovec.vscode-docker
    qub.qub-xml-vscode
    rebornix.ruby
    Shan.code-settings-sync
    shanoor.vscode-nginx
    steve8708.Align
    vortizhe.simple-ruby-erb
    zovorap.ab-html-formatter
  "
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi


