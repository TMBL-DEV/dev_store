import 'package:flutter/material.dart';

FutureBuilder networkImageWithPlaceHolder(
    {required Future<String> promisedUrl, String? placeholderPath}) {
  String placeholder = placeHolderImagePath;

  if (placeholderPath != null) {
    placeholder = placeholderPath;
  }

  return FutureBuilder(
    future: promisedUrl,
    builder: (BuildContext context, response) {
      if (response.hasError) {
        return Image.asset(placeholder);
      }

      if (response.connectionState == ConnectionState.waiting) {
        return Image.asset(placeholder);
      }

      return Image.network(response.data);
    },
  );
}

const String placeHolderImagePath = 'images/placeholders/spacex_cat.jpg';
