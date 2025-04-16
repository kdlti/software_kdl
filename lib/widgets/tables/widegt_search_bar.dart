import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../foundations/foundations.dart';
import '../../presentation/presenters.dart';

class SearchBarItem extends StatelessWidget {
  const SearchBarItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return Container(
      height: 40,
      width: 300,
      decoration: Decorations.searchBarDecoration,
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Pesquisar ${controller.searchKey!
                    .replaceAll(RegExp('[\\W_]+'), ' ')
                    .toUpperCase()}',
            prefixIcon: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  controller.isSearch = false;
                  // controller.initializeData();
                }),
            suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
        onSubmitted: (value) {
          controller.filterData(value);
        },
      ),
    );
  }
}

