import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../ui/ui_include_components/components_presenter.dart';
import '../../../utils/dialogs_message.dart';
import '../../mixins/mixins.dart';

class GetxComponentesPresenter extends GetxController
    with LoadingManager
    implements ComponentsPresenter {
  final LoadComponentsInclude loadComponents;
  final ComponentsRecord recordComponents;
  final String id;
  final String arId;

  GetxComponentesPresenter(
    this.id,
    this.arId, {
    required this.loadComponents,
    required this.recordComponents,
  });

  final TextEditingController _searchController = TextEditingController();
  final RxList<ComponentsEntityInclude> _leftTableData =
      <ComponentsEntityInclude>[].obs;
  final RxList<ComponentsEntityInclude> _rightTableData =
      <ComponentsEntityInclude>[].obs;
  final RxSet<ComponentsEntityInclude> _selectedLeftItems =
      <ComponentsEntityInclude>{}.obs;
  final RxSet<ComponentsEntityInclude> _selectedRightItems =
      <ComponentsEntityInclude>{}.obs;
  final RxList<ComponentsEntityInclude> _sourceFiltered =
      <ComponentsEntityInclude>[].obs;
  final RxList<ComponentsEntityInclude> _sourceOriginal =
      <ComponentsEntityInclude>[].obs;
  final RxBool _text = RxBool(false);
  final RxInt _currentPage = RxInt(1);
  final RxInt _currentPerPage = RxInt(6);
  final RxInt _total = RxInt(100);
  List<ComponentsEntityInclude> source = [];
  final RxBool _isLoading = RxBool(false);
  // final WebSocketService _webSocketService = WebSocketService();

  @override
  int get total => _total.value;

  @override
  int? get currentPerPage => _currentPerPage.value;

  @override
  int get currentPage => _currentPage.value;

  @override
  bool get hasText => _text.value;

  @override
  TextEditingController get searchController => _searchController;

  @override
  List<ComponentsEntityInclude> get leftTableData => _leftTableData;

  @override
  List<ComponentsEntityInclude> get rightTableData => _rightTableData;

  @override
  Set<ComponentsEntityInclude> get selectedLeftItems => _selectedLeftItems;

  @override
  Set<ComponentsEntityInclude> get selectedRightItems => _selectedRightItems;

  @override
  List<ComponentsEntityInclude> get sourceFiltered => _sourceFiltered;

  @override
  List<ComponentsEntityInclude> get sourceOriginal => _sourceOriginal;

  @override
  bool get isLoading => _isLoading.value;

  @override
  initializeData() {
    mockPullData();
  }

  Future<List<ComponentsEntityInclude>> _fetch() async {
    source = await loadComponents.loadComponents();
    return source;
  }

  @override
  mockPullData() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      sourceOriginal.addAll(await _fetch());
      _sourceFiltered.value = sourceOriginal;
      _total.value = sourceFiltered.length;
      int endRange = total < currentPerPage! ? total : currentPerPage!;
      _leftTableData.value = sourceFiltered.getRange(0, endRange).toList();
      isLoading = false;
    });
  }

  @override
  resetData({start = 0}) {
    var expandedLen =
        total - start < currentPerPage! ? total - start : currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _leftTableData.clear();
      _leftTableData.value =
          sourceFiltered.getRange(start, start + expandedLen).toList();
    });
  }

  @override
  void filterSearchResults(String query) {
    List<ComponentsEntityInclude> dummySearchList = [];
    dummySearchList.addAll(source);
    if (query.isNotEmpty) {
      _text.value = true;
      List<ComponentsEntityInclude> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.description.toLowerCase().contains(query.toLowerCase()) ||
            item.code.contains(query) ||
            item.value.contains(query)) {
          dummyListData.add(item);
        }
      }
      _leftTableData.value = dummyListData;
    } else {
      var teste = _rightTableData.where((p0) => source.contains(p0)).toList();
      source.removeWhere((element) => teste.contains(element));
      _leftTableData.value = source;
    }
  }

  @override
  void clearSearch() async {
    _text.value = false;
    sourceOriginal.addAll(await _fetch());
    _searchController.clear();
    var teste = _rightTableData.where((p0) => source.contains(p0)).toList();
    source.removeWhere((element) => teste.contains(element));
    // _leftTableData.value = allData;
    // int endRange = total < currentPerPage! ? total : currentPerPage!;
    // _leftTableData.value = allData.getRange(0, endRange).toList();
  }

  @override
  void onSelectChangedLeftTable(selected, item) {
    if (selected!) {
      _selectedLeftItems.add(item);
    } else {
      _selectedLeftItems.remove(item);
    }
  }

  @override
  backPage() {
    if (currentPage == 1) {
      return;
    } else {
      var nextSet = currentPage - currentPerPage!;
      _currentPage.value = nextSet > 1 ? nextSet : 1;
      resetData(start: currentPage - 1);
    }
  }

  @override
  void nextPage() {
    if (currentPage + currentPerPage! - 1 <= total) {
      var nextSet = currentPage + currentPerPage!;
      _currentPage.value = nextSet < total ? nextSet : total - currentPerPage!;
      resetData(start: nextSet - 1);
    } else {
      return;
    }
  }

  @override
  saveComponents(BuildContext context) async {
    _isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      List<String?> ids = [];
      for (var takeIdsCompo in rightTableData) {
        ids.add(takeIdsCompo.id);
      }
      var packageData = ComponentsRecordEntity(
        arId: arId,
        itemId: id,
        componentsId: ids,
        quantity: '2',
      );
      print(packageData);
      await recordComponents.recordComponents(packageData);

      DialogsNotifier().showConfirmationMessage(context);
    } catch (e) {
      DialogsNotifier().showErrorMessage(context, e.toString());
    } finally {
      _isLoading.value = false;
    }
  }
}
