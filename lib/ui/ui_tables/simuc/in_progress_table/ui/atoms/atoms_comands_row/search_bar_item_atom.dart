import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../../../../../../presentation/presenters.dart';

class SearchBarItemAtom extends StatefulWidget {
  final String id;
  const SearchBarItemAtom({super.key, required this.id});

  @override
  State<SearchBarItemAtom> createState() => _SearchBarItemAtomState();
}

class _SearchBarItemAtomState extends State<SearchBarItemAtom> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxTableSimucPresenter>(context);
    return isSearch == true
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 300,
            height: 40,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 1, bottom: 1, left: 10, right: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.orange, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black26, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText:
                    'Pesquisar ${controller.verifyNameOfSearchBarSimuc(controller.searchKey!.replaceAll(RegExp('[\\W_]+'), ' '))}',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                    controller.isSearch = false;
                    controller.clearFilter();
                  },
                ),
              ),
              onChanged: (value) {
                controller.filterData(value);
              },
            ),
          )
        : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearch = true;
              });
            },
          );
  }
}
