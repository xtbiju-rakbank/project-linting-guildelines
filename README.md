
# Project Linting Guidelines

This repository provides a standardized setup for linting and formatting React Native projects using **ESLint**, **Prettier**, **Husky**, and **Lint-Staged**. These guidelines ensure consistent code quality, enforce best practices, and help maintain clean commits.

---

## **Setup Instructions**

### **2. Add ESLint and Prettier Configurations**
Ensure the following files exist in the root of the repository:

- `.eslintrc.js` (ESLint configuration)  
- `.prettierrc.js` (Prettier configuration)

You can modify these files to suit your project's needs.

---

### **3. Run the Setup Script**
Execute the provided setup script to install dependencies and configure the project:

```bash
chmod +x setup-linting-guidelines.sh
./setup-linting-guidelines.sh
```

This script:  
- Installs all required dependencies.  
- Configures **Husky** pre-commit hooks.  
- Sets up **Lint-Staged** to lint and format staged files.

---

### **4. Add Scripts to `package.json`**
Add the following scripts to your `package.json`:

```json
"scripts": {
  "lint": "eslint .",
  "format": "prettier --write ."
}
```

---

### **5. Verify Setup**
To ensure everything is working correctly:  
- Run `npm run lint` to check for linting issues.  
- Run `npm run format` to format your code.  
- Try committing changes to test the pre-commit hooks.

---

## **How It Works**

### **Tools Used**
1. **ESLint**: For linting JavaScript and TypeScript files.  
2. **Prettier**: For consistent code formatting.  
3. **Husky**: To run Git hooks (pre-commit hooks in this case).  
4. **Lint-Staged**: To process only staged files, making pre-commit hooks faster.

---

### **Pre-Commit Workflow**
1. Staged files are linted and formatted using **Lint-Staged**.  
2. If any issues are detected, the commit is blocked until they are resolved.  
3. Clean, linted, and formatted code is committed.

---

## **Configuration**

### **ESLint**
The default `.eslintrc.js` includes rules for React Native, Prettier, and TypeScript:

```json
{
  "env": {
    "browser": true,
    "es6": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:react/recommended",
    "prettier",
    "plugin:@typescript-eslint/eslint-recommended",
    "plugin:@typescript-eslint/recommended"
  ],
  "rules": {
    // Custom rules here
  }
}
```

---

### **Prettier**
The default `.prettierrc.js` includes:

```javascript
module.exports = {
  arrowParens: 'avoid',
  bracketSameLine: true,
  bracketSpacing: true,
  singleQuote: true,
  trailingComma: 'es5',
  printWidth: 80,
  tabWidth: 2,
  semi: true,
  jsxSingleQuote: true,
  jsxBracketSameLine: false,
};
```

---

### **Lint-Staged**
The `.lintstagedrc.json` processes files as follows:

```json
{
  "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
  "*.json": ["prettier --write"],
  "*.md": ["prettier --write"]
}
```

---

## **Contributing**

Contributions to this repository are welcome! If you have suggestions or find issues:
1. Fork the repository.  
2. Create a feature branch.  
3. Submit a pull request with your changes.

---
