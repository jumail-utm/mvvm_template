import 'package:flutter/material.dart';

import '../counter_viewmodel.dart';

class Float extends StatelessWidget {
  final CounterViewmodel _counterViewmodel;
  const Float(counterViewmodel) : _counterViewmodel = counterViewmodel;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Increase counter',
      child: Icon(Icons.add),
      heroTag: null,
      onPressed: () => _onPressPlusButton(context),
    );
  }

  void _onPressPlusButton(BuildContext context) async {
    _counterViewmodel.increaseCounter();
  }
}
