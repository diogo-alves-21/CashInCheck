# Paypal

## Table of Contents

- [HYP Project](/README.md)
  - [Paypal](#paypal)
    - [Setup](#setup)
    - [Staging and Local testing](#staging-and-local-testing)
    - [Flow](#flow)
    - [Docs](#docs)

## Setup

For you to get this working you will need a business account ([create one here](https://www.paypal.com))

> Regarding the development environment, for the email field I recommend using your email plus the name of the project. Example: **daniel+project_name@hyp.pt**

After login into your account you will need the api credentials.

### Production credentials

1. Click on your user on the nav bar
2. Definições de conta
3. Accesso à API -> Actualizar
4. Integração de API de NVP/SOAP (clássica) -> Gerir credenciais API
5. Solicitar assinatura de API
6. Concordar e enviar

### Staging and development credentials

1. [https://developer.paypal.com/dashboard/](https://developer.paypal.com/dashboard/)
2. Testing Tools -> Sandbox Accounts
3. click on the 3 dots of the business user
4. View/Edit account
5. API Credentials

### Secrets

Add the credentials to the secrets.

```yml
paypal:
  username: username...
  password: password...
  signature: signature...
```

## Staging and Local testing

When you are purchasing something you will need to have a personal paypal account. To get one you should login with your business paypal account created for this project and go to [https://developer.paypal.com/dashboard/accounts](https://developer.paypal.com/dashboard/accounts).

Here you can create new personal and business accounts. If you click on the 3 dots of one user, and select 'View/edit account' you will get all of their data and their login credentials.

## Flow

1. the user fills out the checkout form with paypal method chosen
2. the controller receives the information and stores it in the correspondent Model
3. after the model object is saved, the controller will call the request_payment! method of that object
4. the request_payment! will check the payment method and do some validations and then will call the paypal service (Paypal::SetupPurchase) to create a purchase on the paypal side.
5. the service will return the required information for the next steps
6. the user is redirected to the paypal website
7. the user needs to fill the form
8. the user pays
9. the user is redirected to our website with all the parameters needed to validate the payment
10. the validate_payment! of the correspondent model is called
11. the method will do some validations, find the object in the database, and will call the paypal service (Paypal::DetailsFor)
12. the service requests the information about the payment to paypal
13. validate_payment! receives the paypal response to check if everything is ok with the payment
14. validate_payment! calls the paypal service (Paypal::Purchase) to initiate the money transfer
15. validate_payment! receives the paypal response and will save the correspondent status of that object

## Docs

We are using a gem called [Active Merchant](https://github.com/activemerchant/active_merchant) to manage the paypal payments. You can check their paypal documentation [here](https://www.rubydoc.info/github/activemerchant/active_merchant/ActiveMerchant/Billing/PaypalExpressGateway).
You can check the Paypal documentation [here](https://developer.paypal.com/docs/online/).
