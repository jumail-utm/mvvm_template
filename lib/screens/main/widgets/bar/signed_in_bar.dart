import 'package:flutter/material.dart';

import './bar.dart';
import '../../main_viewmodel.dart';

class SignedInBar extends Bar {
  final MainViewmodel _viewmodel;
  const SignedInBar(MainViewmodel viewmodel) : _viewmodel = viewmodel;

  @override
  Widget build(BuildContext context) {
    return Bar(
      title: _viewmodel.user.name,
      image: NetworkImage(_viewmodel.user.photoUrl),
      button: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
          onPressed: () => _onPressLogoutButton()),
    );
  }

  void _onPressLogoutButton() => _viewmodel.user = null;
}
