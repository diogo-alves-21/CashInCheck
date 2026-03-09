# Mazer scaffold

## Table of Contents
- [HYP Project](/README.md)
    - [Mazer scaffold](#mazer-scaffold)
        - [Generate](#generate)

## Generate

You should use this if you want to create a new scaffold with a specific namespace. You just need to run something like this:

```bash
rails generate scaffold_mazer Post title:string description:text author:references
```

or you can pass the preferred namespace using the flag '-n', if you don't want the 'admin' as default

```bash
rails generate scaffold_mazer Post title:string description:text author:references -n='user'
```
