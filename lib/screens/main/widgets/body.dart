import 'package:exercise3/screens/main/counter_viewmodel.dart';
import 'package:exercise3/screens/view.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final CounterViewmodel _viewmodel;
  const Body(CounterViewmodel viewmodel) : _viewmodel = viewmodel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pushed the button this many times:'),
          SizedBox(
            height: 100.0,
            child: View(
                viewmodel: _viewmodel,
                builder: (_, viewmodel, __) => Text(
                    '${viewmodel.counter.counter}',
                    style: Theme.of(context).textTheme.headline4)),
          ),
        ],
      ),
    );
  }
}
