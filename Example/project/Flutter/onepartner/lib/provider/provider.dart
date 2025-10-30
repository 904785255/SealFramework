import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store {
  static final Store _instance = Store._internal();
  factory Store() => _instance;
  Store._internal();
  static init(Widget child){
    return MultiProvider(
      providers: [

      ],
      child: child,
    );
  }
  static void dispose(){

  }
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  static T of<T>(BuildContext context, {bool listen = true}) {
    return Provider.of<T>(context, listen: listen);
  }

  static Consumer connect<T>({required builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }

  
}

