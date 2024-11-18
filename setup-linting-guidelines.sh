#!/bin/bash

# Bash script to set up linting guidelines for a React Native project.
# This script uses existing .eslintrc.js and .prettierrc.js files from the root directory.

# Ensure the script stops on any error
set -e

echo "Initializing linting guidelines setup..."

# Check if necessary configuration files exist
if [ ! -f ".eslintrc.js" ]; then
  echo "Error: .eslintrc.js file is missing in the root directory. Please add it and rerun the script."
  exit 1
fi

if [ ! -f ".prettierrc.js" ]; then
  echo "Error: .prettierrc.js file is missing in the root directory. Please add it and rerun the script."
  exit 1
fi

# Create the necessary directories and files
mkdir -p .husky
touch .husky/pre-commit
chmod +x .husky/pre-commit

# Write .lintstagedrc.json
cat > .lintstagedrc.json <<EOL
{
  "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
  "*.json": ["prettier --write"],
  "*.md": ["prettier --write"]
}
EOL
echo ".lintstagedrc.json created."

# Write Husky pre-commit hook
cat > .husky/pre-commit <<EOL
#!/bin/sh
. "\$(dirname "\$0")/_/husky.sh"

npx lint-staged
EOL
echo "Husky pre-commit hook created."

# Write README.md
cat > README.md <<EOL
# Project Linting Guidelines

This repository contains linting and formatting guidelines for React Native projects.

## Setup Instructions

1. Ensure that the \`.eslintrc.js\` and \`.prettierrc.js\` files exist in the root directory.

2. Install the dependencies:

   \`\`\`bash
   npm install
   \`\`\`

3. Add the following to your \`package.json\` scripts:

   \`\`\`json
   {
     "scripts": {
       "lint": "eslint .",
       "format": "prettier --write ."
     }
   }
   \`\`\`

4. Husky hooks are already configured. Commit changes to check the linting process.

## Contributing

Feel free to submit issues or improvements.
EOL
echo "README.md created."

# Initialize npm if not already done
if [ ! -f "package.json" ]; then
  echo "Initializing npm..."
  npm init -y
fi

# Install necessary dependencies
echo "Installing dependencies..."
npm install --save-dev eslint prettier lint-staged husky @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-plugin-react eslint-plugin-import eslint-plugin-prettier

# Install Husky
npx husky install

echo "Linting guidelines setup completed successfully! The repository now uses the .eslintrc.js and .prettierrc.js files from the root directory."
