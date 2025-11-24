import 'package:flutter/material.dart';
import 'package:onepartner/init/application.dart';
import 'package:onepartner/provider/app_providers.dart';
import 'package:provider/provider.dart';

class Store {
  static final Store _instance = Store._internal();
  factory Store() => _instance;
  Store._internal();

  Widget buildApp(){
    return MultiProvider(
      providers: Dependencies.providersLocal,
      child: Application(),
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

