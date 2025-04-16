import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../components_presenter.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({super.key});

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<ComponentsPresenter>(context);
    return Obx(() {
      return SizedBox(
        width: 300,
        height: 40,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            presenter.filterSearchResults(value);
          },
          controller: presenter.searchController,
          decoration: InputDecoration(
            labelText: "Pesquisar",
            hintText: "Descrição, código ou valor",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: presenter.hasText == true
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: presenter.clearSearch,
                  )
                : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      );
    });
  }
}
