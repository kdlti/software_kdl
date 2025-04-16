import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../../../presentation/presenters.dart';

class SearchBarArAtom extends StatefulWidget {
  const SearchBarArAtom({
    super.key,
  });

  @override
  State<SearchBarArAtom> createState() => _SearchBarArAtomState();
}

class _SearchBarArAtomState extends State<SearchBarArAtom> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GetxArPresenter>(context);

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
                    'Pesquisar ${controller.verifyNameOfSearchBar(controller.searchKey!.replaceAll(RegExp('[\\W_]+'), ' '))}',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                    controller.isSearch = false;
                    controller.initializeData();
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
