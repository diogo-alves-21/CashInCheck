# Tunneling

## Table of Contents
- [HYP Project](/README.md)
    - [Tunneling](#tunneling)
        - [Run](#run)

## Run

When you want to test the website on your phone, with a service, with https, or just want to share the development website with another person you need to setup tunneling to do that.

You should run this on your terminal to get the generated link.
```bash
ssh -R 80:localhost:3000 localhost.run
```

If you want to read more about this check this [url](https://localhost.run/docs/).
