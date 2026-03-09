# EasyPay

## Table of Contents

- [HYP Project](/README.md)
  - [EasyPay](#easypay)
    - [Setup](#setup)
    - [Staging and Local testing](#staging-and-local-testing)
    - [Flow](#flow)
    - [Docs](#docs)

## Setup

For you to get this working you will need an account ([create one here for production](https://backoffice.easypay.pt/register) or [here for development](https://backoffice.test.easypay.pt/register))

> Regarding the development environment, for the email field I recommend using your email plus the name of the project. Example: **daniel+project_name@hyp.pt**

After login into your account you will need the api credentials. To get that go to **'Web Services'** -> **'Configuração API 2.0'**.

Click on **'Chaves'** to get the credentials and add them to your secrets.

```yml
easy_pay:
  :url: 'https://api.test.easypay.pt/2.0' # OR 'https://api.easypay.pt/2.0'
  :id: id...
  :key: key...
```

Then go back and click on **Notificações** and paste your urls to receive notifications on your app about the purchases.

If you don't know which urls to put just run the project and open ()[localhost:3000/show_me_my_routes] and then search for these keywords and get the full url:

- easy_pay_generic (for the generic url)
- easy_pay_payments (for the payment url)
- easy_pay_authorisation (for the authorisation url)
- easy_pay_show (for the card redirect url)

> Remember that you need the full url (example: https://domain.com/.../easy_pay_generic). Also, you can't use localhost:3000, so if you don't have a domain please check the [tunneling documentation](tunneling.md)

## Staging and Local testing

When you are purchasing something you will need to provide a credit card, a phone number, etc. depending on the chosen method, and to provide those you will need to check the [documentation](https://api.prod.easypay.pt/docs#tag/Single-Payment) or you can see the following examples.

> Here are some examples of MBway numbers:
>
> 911234567 - Authorized for all operations
>
> 917654321 - Failed for all operations
>
> 913456789 - Declined for all operations
>
> 919876543 - Pending for all operations

> Here are some examples of Credit card numbers:
>
> 0000000000000000 - Authorized for all operations
>
> 2222222222222222 - Proceed with 3DS authentication
>
> 1111111111111111 - Failed for all operations
>
> 1234123412341234 - Declined for all operations911234567 - Authorized for all operations

Reagarding the Multibanco reference, if you want to simulate a successful purchase you will need to go to your easypay backoffice and click on '**Developers**' -> **'Pagamentos'**. Then you need to find the purchase that you made and click on **'Testar Pagamento'**, and that should send a notification to your app with the necessary information to accept the purchase.

## Flow

You have 3 payment methods: **multibanco reference**, **mbway** and **credit card**.

The **multibanco reference** and the **mbway** have pretty similar flows since they are async (because we don't need to wait for the user to actually pay). The **credit card** method has some setup similarities but is diferent when the user is redirected to easypay website. Check the following steps to check the purchase flow:

1. the user fills out the checkout form
2. the controller receives the information and stores it in the correspondent Model
3. after the model object is saved, the controller will call the request_payment! method of that object
4. the request_payment! will check the payment method and do some validations and then will call the easypay service (EasyPay::SinglePayment::Create) to create a purchase on the easypay side.
5. the service will return the required information for the next steps
   * (**multibanco reference**) the controller sends to the user the entity and reference to pay
   * (**mbway**) the user will receive a notification to pay on their phone.
   * (**credit card**)
     1. the user is redirected to the easypay website
     2. the user needs to fill the form
6. the user pays
   * (**multibanco reference** and **mbway**) the controller receives a notification and calls a job (EasyPay::NotificationJob) to validate the payment
   * (**credit card**) the user is redirected to our website with all the parameters needed to validate the payment
7. the validate_payment! of the correspondent model is called
8. the method will do some validations, find the object in the database, and will call the easypay service (EasyPay::SinglePayment::Show)
9. the service requests the information about the payment to easypay
10. validate_payment! receives the easypay response and will save the correspondent status of that object

## Docs

You can check the EasyPay documentation [here](https://api.prod.easypay.pt/docs).
