# frozen_string_literal: true

###############################################################################
# GLOBAL RUBY GEMS MANAGEMENT
###############################################################################

# List of essential global gems for Ruby development
GLOBAL_RUBY_GEMS=(
  # Code Quality & Linting
  "rubocop"
  "rubocop-rails"
  "rubocop-rspec"
  "rubocop-performance"
  "reek"

  # Development & Debugging
  "pry"
  "pry-byebug"
  "pry-doc"
  "amazing_print"

  # Language Server & IDE Support
  "solargraph"
  "standard"

  # Performance & Benchmarking
  "benchmark-ips"
  "memory_profiler"
  "stackprof"

  # Documentation
  "yard"

  # Project Management
  "tmuxinator"
  "foreman"

  # Utilities
  "colorize"
)

alias rake='bundle exec rake'

# Install all global Ruby gems
function install_ruby_gems() {
  echo "🔷 Installing essential Ruby development gems..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for gem_name in "${GLOBAL_RUBY_GEMS[@]}"; do
    if gem list "^${gem_name}$" -i > /dev/null 2>&1; then
      echo "✓ ${gem_name} already installed"
    else
      echo "📦 Installing ${gem_name}..."
      gem install "${gem_name}" --no-document
    fi
  done

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✨ Done! All gems installed."
}

# Update all global Ruby gems
function update_ruby_gems() {
  echo "🔄 Updating essential Ruby development gems..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for gem_name in "${GLOBAL_RUBY_GEMS[@]}"; do
    if gem list "^${gem_name}$" -i > /dev/null 2>&1; then
      echo "⬆️  Updating ${gem_name}..."
      gem update "${gem_name}" --no-document
    else
      echo "⚠️  ${gem_name} not installed, skipping..."
    fi
  done

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✨ Done! All gems updated."
}

# List installed global gems from our list
function list_ruby_gems() {
  echo "📋 Global Ruby Development Gems:"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for gem_name in "${GLOBAL_RUBY_GEMS[@]}"; do
    if gem list "^${gem_name}$" -i > /dev/null 2>&1; then
      version=$(gem list "^${gem_name}$" | grep "^${gem_name}" | sed 's/.*(\(.*\))/\1/')
      echo "✓ ${gem_name} (${version})"
    else
      echo "✗ ${gem_name} (not installed)"
    fi
  done

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Reinstall all global gems (useful after Ruby version upgrade)
function reinstall_ruby_gems() {
  echo "🔄 Reinstalling all essential Ruby development gems..."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  for gem_name in "${GLOBAL_RUBY_GEMS[@]}"; do
    echo "📦 Installing ${gem_name}..."
    gem install "${gem_name}" --no-document
  done

  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "✨ Done! All gems reinstalled."
}

# Shorter aliases
alias geminstall='install_ruby_gems'
alias gemupdate='update_ruby_gems'
alias gemlist='list_ruby_gems'
alias gemreinstall='reinstall_ruby_gems'
