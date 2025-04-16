import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

abstract class ComponentsPresenter implements Listenable {
  List<ComponentsEntityInclude> get leftTableData;
  List<ComponentsEntityInclude> get rightTableData;
  Set<ComponentsEntityInclude> get selectedLeftItems;
  Set<ComponentsEntityInclude> get selectedRightItems;
  TextEditingController get searchController;
  List<ComponentsEntityInclude> get sourceFiltered;
  List<ComponentsEntityInclude> get sourceOriginal;
  int get total;
  int? get currentPerPage;
  int get currentPage;
  bool get hasText;
  bool get isLoading;
  Stream<bool> get isLoadingStream;

  saveComponents(BuildContext context);
  initializeData();
  mockPullData();
  resetData({start = 0});
  void filterSearchResults(String query);
  void clearSearch();
  void onSelectChangedLeftTable(bool? selected, ComponentsEntityInclude item);
  void backPage();
  void nextPage();
}
