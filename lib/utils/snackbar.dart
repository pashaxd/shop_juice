import 'package:flutter/material.dart';

//Снэкбар 

class Snackbar {
  
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Product added to cart'),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}