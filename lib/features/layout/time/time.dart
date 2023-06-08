import 'package:flutter/material.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Time',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
