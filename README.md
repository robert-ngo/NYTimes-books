# New York Times books

![alt text](https://raw.githubusercontent.com/robert-ngo/NYTimes-books/master/screenshots/NYT-flutter.jpg "New York Times books - Flutter app")

A sample Flutter project, to demontrate fetching data from New York Times Books API. 
The sample application is used to experimenting: 

- the use of fetching, parsing in background isolate using the compute(). 
- accessing New York Times Books API. 
- basic Flutter layout
- StateLessWidget vs StateFulWidget 
- launch URL using `url_launcher`

## Register your developer account to access the NYTimes Books API

In this tutorial, we use the Books API https://developer.nytimes.com/docs/books-product/1/overview

- Register your developer account, create a new app for testing, and get generate an API Key
- Copy file `.env.project` into `.env`.
- Replace `[your-api-key]` in `.env` with the API key above.

## To run project 

Assuming you already have flutter installed, if not, please install it by following instructions at https://flutter.dev/docs/get-started/install. 

To run the project: 

- run `flutter run` to spin up the app on simulator

![alt text](https://raw.githubusercontent.com/robert-ngo/NYTimes-books/master/screenshots/NYT-flutter.gif "New York Times books - Flutter app")
