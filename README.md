
# Project Linting Guidelines

This repository provides a standardized setup for linting and formatting React Native projects using **ESLint**, **Prettier**, **Husky**, and **Lint-Staged**.

---

## **Setup Instructions**

### **1. Run the Setup Script**

Copy prettierrc.js and eslintrc.json to root directory. Execute the provided setup script to install dependencies and configure the project. By default, the script uses Yarn. You can choose to switch to npm if needed.

```bash
chmod +x setup-linting-guidelines.sh
./setup-linting-guidelines.sh
```

During the script execution, you can select either Yarn or npm for dependency management.

---

### **2. Add Scripts to package.json**

The setup script automatically configures scripts in your `package.json`. If not, you can manually add the following:

```json
"scripts": {
  "lint": "eslint .",
  "format": "prettier --write ."
}
```

---

### **3. Verify Setup**

- Run `yarn lint` (or `npm run lint`) to check for linting issues.
- Run `yarn format` (or `npm run format`) to format your code.
- Commit changes to test the pre-commit hooks.

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

The repository should already contain `.eslintrc.js` in the root directory. Ensure it has the desired configuration for your project.

---

### **Prettier**

The repository should already contain `.prettierrc.js` in the root directory. Update it as needed to suit your formatting requirements.

---

### **Lint-Staged**

The `.lintstagedrc.json` will be generated by the script and contains the following default configuration:

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

## **License**

This repository is licensed under the [MIT License](LICENSE).
