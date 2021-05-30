import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodel.dart';

//----------------------------------------------------------------------------
// Default View is with Selector and ChangeNotifierProvier
//----------------------------------------------------------------------------

class View extends StatelessWidget {
  final Widget Function(BuildContext context, Viewmodel viewmodel, Widget child)
      _builder;

  final Widget Function(BuildContext context, Viewmodel viewmodel)
      _progressBuilder;
  final Viewmodel _viewmodel;

  const View({@required builder, @required viewmodel, progressBuilder})
      : _builder = builder,
        _viewmodel = viewmodel,
        _progressBuilder = progressBuilder;

  Widget _baseBuilder(BuildContext context, Viewmodel viewmodel, Widget child) {
    if (viewmodel.busy) {
      if (_progressBuilder != null) return _progressBuilder(context, viewmodel);
      return Center(
        child: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return _builder(context, viewmodel, child);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _viewmodel,
        child: Consumer<Viewmodel>(builder: _baseBuilder),
      );
}

//----------------------------------------------------------------------------
// The ConsumerView class is an alias of View. Only for consistency
//----------------------------------------------------------------------------
class ConsumerView extends View {
  ConsumerView({@required builder, @required viewmodel})
      : super(builder: builder, viewmodel: viewmodel);
}

//----------------------------------------------------------------------------
// View with Selector
//----------------------------------------------------------------------------
class SelectorView<R> extends View {
  final R Function(BuildContext context, Viewmodel viewmodel) _selector;

  SelectorView({@required selector, @required builder, @required viewmodel})
      : _selector = selector,
        super(builder: builder, viewmodel: viewmodel);

  Widget _selectorBuilder(
          BuildContext context, R selectorResult, Widget child) =>
      _baseBuilder(context, _viewmodel, child);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _viewmodel,
        child: Selector<Viewmodel, R>(
            selector: _selector, builder: _selectorBuilder),
      );
}

//----------------------------------------------------------------------------
// WidgetView: View without Consumer.
//----------------------------------------------------------------------------
class WidgetView extends View {
  WidgetView({@required builder, @required viewmodel})
      : super(builder: builder, viewmodel: viewmodel);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _viewmodel, child: _baseBuilder(context, _viewmodel, null));
}
