
#!/bin/bash

# Stop script on any error
set -e

echo "Initializing Linting Guidelines Setup..."

# Check if the script is executed in a git repository
if [ ! -d ".git" ]; then
  echo "Error: This script must be run in the root of a git repository."
  exit 1
fi

# Default to Yarn but allow user to choose npm
read -p "Use Yarn for package management? (y/n, default: y): " use_yarn
use_yarn=${use_yarn:-y}

if [[ "$use_yarn" == "y" || "$use_yarn" == "Y" ]]; then
  PACKAGE_MANAGER="yarn"
  RUN_COMMAND="yarn"
  INSTALL_COMMAND="yarn add --dev"
else
  PACKAGE_MANAGER="npm"
  RUN_COMMAND="npm run"
  INSTALL_COMMAND="npm install --save-dev"
fi

echo "Using $PACKAGE_MANAGER for package management."

# Ensure necessary files exist
if [ ! -f ".eslintrc.js" ]; then
  echo "Error: .eslintrc.js file is missing in the root directory. Please add it and rerun the script."
  exit 1
fi

if [ ! -f ".prettierrc.js" ]; then
  echo "Error: .prettierrc.js file is missing in the root directory. Please add it and rerun the script."
  exit 1
fi

# Add .lintstagedrc.json
cat > .lintstagedrc.json <<EOL
{
  "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
  "*.json": ["prettier --write"],
  "*.md": ["prettier --write"]
}
EOL
echo ".lintstagedrc.json created."

# Initialize project if not already done
if [ ! -f "package.json" ]; then
  echo "Initializing project..."
  if [ "$PACKAGE_MANAGER" == "yarn" ]; then
    yarn init -y
  else
    npm init -y
  fi
fi

# Install dependencies
echo "Installing dependencies..."
$INSTALL_COMMAND eslint prettier husky lint-staged @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-react eslint-plugin-prettier eslint-config-prettier

# Set up Husky
echo "Setting up Husky pre-commit hook..."
npx husky install
mkdir -p .husky
cat > .husky/pre-commit <<EOL
#!/bin/sh
. "\$(dirname "\$0")/_/husky.sh"

$RUN_COMMAND lint-staged
EOL
chmod +x .husky/pre-commit
echo "Husky pre-commit hook configured."

# Add lint-staged configuration to package.json
echo "Configuring lint-staged in package.json..."
npx json -I -f package.json -e 'this["lint-staged"]={"*.{js,jsx,ts,tsx}":["eslint --fix","prettier --write"],"*.json":["prettier --write"],"*.md":["prettier --write"]}'

echo "Integration completed successfully! Your project is now set up with $PACKAGE_MANAGER."
