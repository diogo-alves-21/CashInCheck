module.exports = {
  extends: 'stylelint-config-standard-scss',
  plugins: [
    'stylelint-scss'
  ],
  ignoreFiles: [
    'node_modules/**/*',
    'public/**/*',
    '**/vendor/**/*',
    'app/assets/stylesheets/general/utilities/**/*'
  ],
  customSyntax: 'postcss-scss',
  rules: {
    /* This rules were removed in newer versions */
    // 'block-closing-brace-newline-after': ['always', { ignoreAtRules: ['if', 'else'] }],
    // 'block-closing-brace-newline-before': 'always-multi-line',
    // 'block-closing-brace-space-before': 'always-single-line',
    // 'block-opening-brace-newline-after': 'always-multi-line',
    // 'block-opening-brace-space-after': 'always-single-line',
    // 'block-opening-brace-space-before': 'always',
    // 'color-hex-case': 'upper',
    // 'function-parentheses-newline-inside': 'always-multi-line',
    // 'function-parentheses-space-inside': 'never-single-line',
    /* -- end -- */
    'color-named': 'always-where-possible',
    'max-nesting-depth': 2,
    'selector-class-pattern': '^[a-z0-9]+((-{1,2}|__)[a-z0-9]*)*$',
    //   We are following BEM rules.
    //   -- DONT
    //   .dont_use_snake_case, .dontUseCamelCase, .Dont-Use-UPPERCASE
    //
    //   -- DO
    //   .use-dash-case, .select, .select2, .form-select, .form-select2
    //   .bem-rules, .dog, .dog__paw, .dog--blue
    'selector-max-compound-selectors': 4,
    'selector-max-id': 1,
    'selector-nested-pattern': '^(?:(?!(&_|&-))(.|.\n))*$',
    //   Avoid nested selector that starts with: &_ or &-
    //   -- DONT
    //   .class {
    //     &__element {
    //      ...
    //     }
    //
    //     &--modifier {
    //      ...
    //     }
    //   }
    //
    //   -- DO
    //   .class { ... }
    //   .class__element { ... }
    //   .class--modifier { ... }
    'selector-no-qualifying-type': [
      true,
      {
        'ignore': [
          'attribute',
          'class',
          'id'
        ]
      }
    ],
    'selector-pseudo-element-colon-notation': 'single',
    // 'string-quotes': 'double',  /* This rule is also removed in v15 — consider using Prettier instead */
    'value-no-vendor-prefix': [true, { ignoreValues: ['box'] }],
    // SCSS-specific rules
    'scss/at-extend-no-missing-placeholder': null,
    'scss/dollar-variable-colon-space-after': 'at-least-one-space',
    'scss/dollar-variable-pattern': [
      '^([a-z]{1,2}|aux)_([a-z]+|select2|h[1-6])((-{1,2}|_{2})([a-z]+|select2|h[1-6]))*$|^([a-z]+|select2)+((-{1,2}|_{2})([a-z0-9])+|select2)+$|^[a-z]{1,10}$'
      //   Try to use short names, when you only have one word, we allow a maximum of 10 characters.
      //   When in doubt, choose a prefix that makes sense and for the rest of the name follow the BEM rules.
      //   -- DONT
      //   $aux_var_name,          // var name separated by underscore
      //   $verylongvariablename
      //   $variable_name,         // separated by underscore
      //   $select2_border,        // separated by underscore
      //   $h3,                    // no prefix
      //   $h5-form,               // no prefix
      //   $gray200                // no separator
      //
      //   -- DO
      //   $c_blue, $fs_p, $aux_var-name, $c_block--modifier, $c_block__element,
      //   $vn, $shortvname, $variable-name, $block--modifier, $block__element,
      //
      //   The only digits you could use next to a word are:
      //   the number '2' as a suffix of 'select'. On this case you don't need to have a prefix
      //   $c_select2, $c_form-select2, $select2-border,
      //
      //   and the numbers from '1' to '6' as suffixes of 'h'. On this case you **must** have a prefix
      //   $fs_h3, $fs_form-h5,
      //
      //   but you can use digits separated by '-', '--' or '__'
      //   $gray-200
    ],
    'scss/at-mixin-pattern': [
      '^[a-z]{2,}(-{1,2}[a-z]+)*$'
      //   -- DONT
      //   @mixin always_separated_by_hyphen(), @mixin n0-digits(), @mixin m()
      //
      //   -- DO
      //   @mixin always-separated-by-hyphen(), @mixin no-digits(), @mixin at-least-two-characters(), @mixin mx()
    ]
  }
};
