module.exports = {
  env: {
    browser: true,
  },
  extends: 'airbnb',
  parser: 'babel-eslint',
  rules: {
    'global-require': 'off',
    'new-cap': ['warn', { newIsCap: true, capIsNew: false }],
    'no-unused-vars': ['error', { argsIgnorePattern: '^_' }],

    'import/no-extraneous-dependencies': ['error', {
      'devDependencies': true,
    }],
    'import/order': ['warn', {
      groups: [['builtin', 'external'], ['index', 'internal', 'parent', 'sibling']],
      'newlines-between': 'always',
    }],

    'react/prefer-stateless-function': 'warn',
  },
}
