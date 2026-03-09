# Styleguide

## Table of Contents
- [HYP Project](/README.md)
    - [Styleguide](#styleguide)
        - [Run Styleguide](#run-styleguide)
        - [Braces](#braces)
        - [Compound Selectors](#compound-selectors)
        - [Class Naming](#class-naming)
        - [Nesting](#nesting)
        - [Variable Naming](#variable-naming)
        - [Mixin Naming](#mixin-naming)

## Run Styleguide

To see the styleguide open http://0.0.0.0:3000/styleguide or http://localhost:3000/styleguide in a browser.

You can check all the main components, rules, etc used on the project but here are some important basic info:

## Braces

Do this

```scss
.class {
 ...
}
```

Avoid this

```scss
.class { ... }
```

Don't do this

```scss
.class
{
 ...
}
```

## Compound Selectors

Avoid long compound selectors, we only allow 4.

The following pattern will be considered a problem:
```scss
.container .element table tr .table-header
```

The following pattern will **_not_** be considered a problem:
```scss
.container .element table .table-header
```

## Class Naming

We are following [BEM](http://getbem.com/naming/) rules.

The following patterns will be considered a problem:
```scss
.dont_use_snake_case, .dontUseCamelCase, .Dont-Use-UPPERCASE
```
The following patterns will **_not_** be considered a problem:
```scss
.use-dash-case, .select, .select2, .form-select, .form-select2
.bem-rules, .dog, .dog__paw, .dog--blue
```

## Nesting

Avoid nested selector that starts with: &_ or &-

Avoid too much nesting, we only allow 2 levels of it.

The following patterns will be considered a problem:
```scss
.class {
  &__element {
    ...
  }

  &--modifier {
    ...
  }
}

.class {
  .child {
    ...

    &:hover {
      ...
    }
  }
}
```

The following patterns will **_not_** be considered a problem:
```scss
.class { ... }
.class__element { ... }
.class--modifier { ... }

.class {
  .child {
    ...
  }

  .child:hover {
    ...
  }
}

.class .child {
  ...

  &:hover {
    ...
  }
}
```

## Variable Naming

We you can use a prefix:
```
 b_  –— border
 c_  –— color
 d_  –— duration
 f_  –— font
 fw_ –— font-weight
 fs_ –— font-size
 h_  –— height
 w_  –— width
 s_  –— size

aux_ –— auxiliary : try to avoid this one
```

Try to use short names, when you only have one word, we allow a maximum of 10 characters.

When you're abbreviating ask this questions:

- Will it reduce the size significantly?
```
background => bg  // DO
text => txt       // DON'T
```
- Is it a clear abbreviation?
```
background => bg       // DO
background => bckgrnd  // DON'T
```

As a last resource, put a comment in the file where you are defining
the variable explaining the meaning of the abbreviation.

When in doubt, choose a prefix that makes sense and for the rest of the name follow the BEM rules.

The following patterns will be considered a problem:
```scss
$aux_var_name;          // var name separated by underscore
$verylongvariablename;
$variable_name;         // separated by underscore
$select2_border;        // separated by underscore
$h3;                    // no prefix
$h5-form;               // no prefix
$gray200;               // no separator
```

The following patterns will **_not_** be considered a problem:
```scss
$c_blue;
$fs_p;
$aux_var-name;
$c_block--modifier;
$c_block__element;

$vn;
$shortvname;
$variable-name;
$block--modifier;
$block__element;

// The only digits you could use next to a word are:
// the number '2' as a suffix of 'select'. On this case you don't need to have a prefix
$c_select2;
$c_form-select2;
$select2-border;

// and the numbers from '1' to '6' as suffixes of 'h'. On this case you **must** have a prefix
$fs_h3;
$fs_form-h5;

// but you can use digits separated by '-', '--' or '__'
$gray-200;
```


## Mixin Naming

The following patterns will be considered a problem:
```scss
@mixin always_separated_by_hyphen() {}
@mixin n0-digits() {}
@mixin m() {}
```
The following patterns will **_not_** be considered a problem:
```scss
@mixin always-separated-by-hyphen() {}
@mixin no-digits() {}
@mixin at-least-two-characters() {}
@mixin mx() {}
```

