import 'package:flutter/material.dart';

import '../main_viewmodel.dart';

class Body extends StatelessWidget {
  final MainViewmodel _viewmodel;
  const Body(MainViewmodel viewmodel) : _viewmodel = viewmodel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pushed the button this many times:'),
          Text('${_viewmodel.counter.counter}',
              style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }
}
