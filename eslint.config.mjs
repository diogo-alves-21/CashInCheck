import globals from "globals";
import pluginJs from "@eslint/js";


/** @type {import('eslint').Linter.Config[]} */
export default [
  {
    ignores: ["**/*.min.js", "app/assets/builds/*", "app/javascript/vendor/*"],
  },
  {
    languageOptions: {
      globals: globals.browser
    },
    rules: {
      "no-console": "off",
      "no-debugger": "off",
      "no-extra-semi": "error",
      semi: ["error", "always"],
      quotes: ["error", "single"],
      "comma-dangle": "error",
      "space-before-function-paren": "off",
  },
  },
  pluginJs.configs.recommended,
];
