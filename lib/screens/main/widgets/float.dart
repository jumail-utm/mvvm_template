import 'package:flutter/material.dart';

import '../main_viewmodel.dart';

class Float extends StatelessWidget {
  final MainViewmodel _viewmodel;
  const Float(viewmodel) : _viewmodel = viewmodel;

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
    _viewmodel.increaseCounter();
  }
}
