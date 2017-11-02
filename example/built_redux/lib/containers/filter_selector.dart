library filter_selector;

import 'package:built_redux_sample/containers/typedefs.dart';
import 'package:built_redux_sample/data_model/models.dart';
import 'package:built_redux_sample/redux/actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:built_value/built_value.dart';

part 'filter_selector.g.dart';

typedef OnFilterSelected = Function(VisibilityFilter filter);

abstract class FilterSelectorViewModel
    implements Built<FilterSelectorViewModel, FilterSelectorViewModelBuilder> {
  FilterSelectorViewModel._();

  OnFilterSelected get onFilterSelected;

  VisibilityFilter get activeFilter;

  factory FilterSelectorViewModel([updates(FilterSelectorViewModelBuilder b)]) =
      _$FilterSelectorViewModel;

  factory FilterSelectorViewModel.from(
    AppActions actions,
    VisibilityFilter activeFilter,
  ) {
    return new FilterSelectorViewModel((b) => b
      ..onFilterSelected = (filter) {
        actions.updateFilterAction(filter);
      }
      ..activeFilter = activeFilter);
  }
}

class FilterSelector extends StoreConnector<AppState, AppStateBuilder,
    AppActions, VisibilityFilter> {
  final ViewModelBuilder<FilterSelectorViewModel> builder;

  @override
  VisibilityFilter connect(AppState state) => state.activeFilter;

  FilterSelector({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    VisibilityFilter activeFilter,
    AppActions actions,
  ) {
    return builder(
      context,
      new FilterSelectorViewModel.from(
        actions,
        activeFilter,
      ),
    );
  }
}