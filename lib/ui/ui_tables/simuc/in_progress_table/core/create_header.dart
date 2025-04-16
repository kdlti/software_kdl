import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../foundations/foundations.dart';
import '../../../../../presentation/presenters.dart';
import '../../../../../utils/tables/tables.dart';

class HeaderItem extends StatefulWidget {
  const HeaderItem({
    super.key,
  });

  @override
  State<HeaderItem> createState() => _HeaderItemState();
}

class _HeaderItemState extends State<HeaderItem> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<GetxTableSimucPresenter>(context);
    const headerDecoration = Decorations.headerDecoration;

    double width = MediaQuery.of(context).size.width;

    bool isLargeScreen = width > 1361;

    double sizeFont = isLargeScreen ? 12 : 10;

    return Container(
      decoration: headerDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 30),
          ...headerItem.where((header) => header.show == true).map(
                (header) => Expanded(
                  flex: header.flex,
                  child: InkWell(
                    onTap: () => presenter.onSort(header.value),
                    child: header.headerBuilder != null
                        ? header.headerBuilder!(header.value)
                        : Container(
                            padding: const EdgeInsets.all(11),
                            alignment:
                                HeaderAlign.headerAlignSwitch(header.textAlign),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  overflow: isLargeScreen
                                      ? null
                                      : TextOverflow.ellipsis,
                                  header.text,
                                  textAlign: header.textAlign,
                                  style: TextStyle(
                                    color: ColorFoundations.greyMedium,
                                    fontSize: sizeFont,
                                  ),
                                ),
                                if (presenter.sortColumn != null &&
                                    presenter.sortColumn == header.value)
                                  presenter.sortAscending
                                      ? const Icon(Icons.arrow_downward,
                                          size: 15)
                                      : const Icon(Icons.arrow_upward, size: 15)
                              ],
                            ),
                          ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
