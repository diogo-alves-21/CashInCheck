# Code

## Table of Contents
- [HYP Project](/README.md)
    - [Code](#code)
        - [Git Flow](#git-flow)
        - [File Structure](#file-structure)
        - [Model Structure](#model-structure)
        - [Linters](#linters)
        - [Debug](#debug)
        - [Tests](#tests)
        - [Branches](#branches)
        - [Commits](#commits)
        - [Merge Requests](#merge-requests)
        - [Documentation](#documentation)

## Git Flow

```
  o----------------------------------------o---------main
   \                                     /
    \                                   /
     -o-------------------------------o/-------------staging
      \                             /
       \                           /
        -o----o------------------o/------------------development
               \               /
                \             /
                 -o----o----o/ feature   (naming convention: <number_of_the_card>_<title_of_the_card_with_underscores>)
```

This is the git flow for this project. You have three fixed branches:
- **main:** this branch represents the production server state (this is what the final client sees)
- **staging:** this branch represents the staging server state. This means that this is a server just for tests (we have access to this server as well as the client)
- **development:** this branch represents the local state shared by the team. This branch should be bug-free and must have only completed features.
- **feature:** Every time that you start a **new feature** you should create a **new branch** for that feature. This new branch must follow the naming convention which consists of the number of the card and the title of the card (ex: 420_create_post). When the feature is finished you should open a merge request to the branch development.

Every commit message should be explicit and should contain a prefix like feat and fix (see how to use them [here](https://dev.to/i5han3/git-commit-message-convention-that-you-can-follow-1709) / ex: feat: create post)

## File Structure

this file structure is simply an example to explain how the code is structured.

```
.
├── app
│   ├── assets
│   │   ├── images
│   │   └── stylesheets
│   │       ├── general
│   │       │   ├── components
│   │       │   │   └── (all the scss files needed for views/layout_partials elements: a file per partial)
│   │       │   ├── core
│   │       │   │   └── (all the scss files needed for the core elements: colors, buttons, ...)
│   │       │   ├── mixins
│   │       │   │   └── (all the mixins)
│   │       │   ├── pages
│   │       │   │   └── (all the scss files needed for specific pages)
│   │       │   ├── utilities
│   │       │   │   └── (all the scss code/files that is NOT written by our team)
│   │       │   └── (all the scss files needed for the application layout)
│   │       ├── application.sass.scss
│   │       │   └── (imports all the files needed for the application layout)
│   │       ├── mazer.sass.scss
│   │       │   └── (imports all the files needed for the admin layout)
│   │       └── styleguide.scss
│   │           └── (imports all the files needed for the styleguide)
│   ├── controllers
│   │   ├── concerns
│   │   │   └── (shared code between controllers)
│   │   └── (all the controllers divided by folders based on the namespaces)
│   ├── helpers
│   │   └── (all the helpers used to improve the views)
│   ├── javascript
│   │   ├── controllers
│   │   │   ├── application
│   │   │   │   └── (all the stimulus controllers needed only for application layout)
│   │   │   └── common
│   │   │       └── (all the stimulus controllers needed for every layout)
│   │   ├── general
│   │   │   └── (all the js files needed for the application layout)
│   │   ├── turbo_streams
│   │   │   └── (all the turbo_streams needed for the application)
│   │   ├── application.js
│   │   │   └── (imports all the files needed for the application layout)
│   │   ├── mazer.js
│   │   │   └── (imports all the files needed for the admin layout)
│   │   └── styleguide.js
│   │       └── (imports all the files needed for the styleguide)
│   ├── jobs
│   │   └── (all the async jobs)
│   ├── mailers
│   │   └── (all the emails being sent)
│   ├── models
│   │   ├── concerns
│   │   │   └── (shared code between models)
│   │   └── (all the models (check the 'Model Structure' section))
│   ├── policies
│   │   └── (all the policies used by pundit to manage authorizations)
│   ├── services
│   │   ├── base_service.rb
│   │   │   └── (all the other services should extend this service)
│   │   └── (services are used to share code, to abstract some methods, and to connect to external API's)
│   ├── validators
│   │   └── (custom validations that could be used by multiple models)
│   └── views
│   │   ├── layout_partials
│   │   │   └── (front-end partials/components)
│   │   └── (all the views)
├── config
│   ├── locales
│   │   └── (to store your translations (they should map the app folder structure))
│   ├── local_env.example.yml
│   │   └── (should be always up to date, so everybody can copy the content to the local_env file and have a working environment)
│   ├── local_env.yml
│   │   └── (to store your development secrets)
│   └── routes.rb
│       └── (to store all the routes)
├── db
│   ├── migrate
│   │   └── (all the migrations)
│   └── seeds.rb
│       └── (used to populate the database for development (update this when creating new migrations))
└── spec
    ├── factories
    │   └── (all specifications for creating instances of models, used by FactoryBot)
    ├── files
    │   └── (files to be used for testing upload features)
    ├── models
    │   └── (all tests for models)
    ├── support
    │   └── (to organize methods useful to write tests)
    └── system
        └── (all end-to-end tests using capybara, capable of opening a browser to test the user interface)
```

You should divide the files into folders when you think it's appropriate to maintain the code organized.

## Model Structure

Make sure the model have the following comments to improve code quality:

```ruby
# == Includes =============================================================

# == Constants ============================================================

# == Attributes ===========================================================

# == Extensions ===========================================================

# == Relationships ========================================================

# == Validations ==========================================================

# == Scopes ===============================================================

# == Callbacks ============================================================

# == Class Methods ========================================================

# == Instance Methods =====================================================
```

> Check this [example](https://gist.github.com/ziemekwolski/3cc167d87bee32546542a2882fbc6cb4) to guide you and if you want to know more check this [blog post](https://www.zmwolski.com/Organizing-Ruby-on-Rails-Models)

## Linters

We use linters to ensure the quality and readability of the code. (you should run these before making a push just to make sure everything is ok)

* Ruby: [Rubocop](https://github.com/rubocop-hq/rubocop)
* Views: [ERB Lint](https://github.com/Shopify/erb_lint)
* Javascript: [ESLint](https://eslint.org/)
* Sass: [Stylelint](https://stylelint.io/)

### Rubocop

Run `bundle exec rubocop`

You can also solve some warnings by running this: `bundle exec rubocop -A`

You should install this linter on your editor to help you while coding:
- [vscode](https://marketplace.visualstudio.com/items?itemName=rebornix.Ruby)

### ERB Lint

Run `bundle exec erblint --lint-all`

You can also solve some warnings by running this: `bundle exec erblint --lint-all -a`

### ESLint

Run `yarn eslint`

You can also solve some warnings by running this: `yarn eslint --fix`

You should install this linter on your editor to help you while coding:
- [vscode](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

### Stylelint

Run `yarn stylelint`

You can also solve some warnings by running this: `yarn stylelint --fix`

You should install this linter on your editor to help you while coding:
- [vscode](https://marketplace.visualstudio.com/items?itemName=stylelint.vscode-stylelint)

You can [ignore code within files](https://stylelint.io/user-guide/ignore-code/) but try to avoid this.


## Debug

### Xray

When you are in a page and you don't know which partials or files are being rendered you can use cmd+shift+x or ctrl+shift+x and an overlay will appear with all partials mapped on the page.

You can check the documentation [here](https://github.com/brentd/xray-rails).

## Tests

We are using three important gems to implement the tests:
- [rspec](https://relishapp.com/rspec)
- [capybara](https://github.com/teamcapybara/capybara)
- [factory_bot](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)

Run `bundle exec rspec`

If you want to know more about how the tests are organized you should check the [spec folder](#file-structure).


## Branches

When you're about to make any changes to the project code, you should firstly create a new branch, from **development**, by running:

`git checkout -b <branch-name>`

The new branch name should follow the template `<trello/wekan-card-number>_<task-title>`, eg: `165_user_login`.


## Commits

Clear and concise commit messages are very important to quickly understand the main changes of a commit. For that, you should use the following template:

```
<type>: <subject>
```

### Type

- **build**: Build related changes (eg: yarn/ gemfile/ adding external dependencies)
- **chore**: A code change that external user won't see (eg: change to .gitignore/ linters)
- **docs**: Documentation related changes
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code that improves performance
- **refactor**: A code that neither fixes a bug nor adds a feature. (eg: semantic changes like renaming a variable, function or class)
- **style**: A code related to styling
- **test**: Adding new tests or making changes to existing tests

### Subject

- use imperative, present tense (eg: use "add" instead of "added" or "adds")
- don't use dot (.) at end
- don't capitalize first letter
- be concise


## Merge Requests

When you finish a feature, you should open a merge request for your teammates to review the code. Your **source branch** is the branch that you have been working on and the **target** should be the branch that will receive your code (development by default).

When creating a new merge request, the title should be explicit enough for the reviewers, and the description should follow the next template:

```
## Description (or card link)

## Approved by

- [ ] @userhandle
```

You should add the card link (Wekan, Trello, Sentry, etc) below the `## Description (or card link)`. If you don't have a link, you should add a description of the task you've been doing.

You should also tag all the reviewers, so they can review and mark as done when they think that there is nothing more to change.

Please select yourself as an assignee and check the "delete branch" option. You can also add the option draft if you think that this branch isn't ready to be merged.

After creating the merge you should notify your teammates on slack on the proper channel. Then your team will review the merge request.


### Review merge request

> **NOTE**:
Remember that you should always keep track of all discussions here even if they happened elsewhere. This is important to keep the team in sync.

#### As assignee

As you see the comments made by your peers, remember to answer them always, with following up questions, reasons, or to say that the comment is solved (you can use emojis to keep things simple).

Remember communication is key, so if you are stuck or if your teammates are taking a long time to respond, just ask them directly to remember them about the merge request.

`Don't assume that the person who is reviewing the merge knows what is best, so debate with them if you need to come to the best solution. But always keep a log of the discussion on the merge request, if you are discussing in person.`

#### As reviewer

When reviewing comments you should mark the comment as closed when it is solved.

When all of your comments are closed you should approve the merge request by checking your box in the description. If you are the last reviewer to approve you should ask the team if you can merge.


## Documentation

The project uses [Yard](https://yardoc.org/) to document the code.

To see the documentation run:

`yard server -r`

and go to http://localhost:8808 in a browser.

Remember to document your code to keep this updated, specially if your code is complex or too specific.

