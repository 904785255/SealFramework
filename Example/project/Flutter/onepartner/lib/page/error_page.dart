import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final FlutterErrorDetails details;

  const ErrorPage(this.details, {super.key}) ;

  @override
  _ErrorPageState createState() => _ErrorPageState();
}
class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("错误页面: ${widget.details.exception}"),
    );
  }
}