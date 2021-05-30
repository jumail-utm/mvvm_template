import 'package:flutter/material.dart';

import 'widgets/bar/signed_in_bar.dart';
import 'widgets/bar/unsigned_in_bar.dart';
import 'widgets/body.dart';
import 'widgets/float.dart';
import '../view.dart';
import 'main_viewmodel.dart';

class MainScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => MainScreen());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: View(
          viewmodel: MainViewmodel(),
          builder: (_, viewmodel, __) {
            if (viewmodel.isUserSignedIn) {
              return Scaffold(
                appBar: SignedInBar(viewmodel),
                body: Body(viewmodel),
                floatingActionButton: Float(viewmodel),
              );
            }

            return Scaffold(appBar: UnsignedInBar(viewmodel));
          },
        ),
      ),
    );
  }
}
