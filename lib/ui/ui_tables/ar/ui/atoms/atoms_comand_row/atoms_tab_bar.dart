import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AtomsTabBar extends StatefulWidget {
  final TabController tabController;

  const AtomsTabBar({super.key, required this.tabController});

  @override
  AtomsTabBarState createState() => AtomsTabBarState();
}

class AtomsTabBarState extends State<AtomsTabBar> {
  int badgeCount = 1;
  bool _showBadge = true;

  Color indicatorColor = const Color.fromARGB(255, 255, 132, 50);

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      setState(() {
        if (widget.tabController.index == 1) {
          _showBadge = false;
          indicatorColor = Colors.red;
        } else if (widget.tabController.index == 2) {
          indicatorColor = Colors.black;
        } else {
          indicatorColor = const Color.fromARGB(255, 255, 132, 50);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      indicatorColor: indicatorColor,
      indicatorWeight: 3,
      dividerHeight: 0,
      labelColor: Colors.black,
      unselectedLabelColor: const Color.fromARGB(255, 133, 133, 133),
      labelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      tabs: [
        const Tab(text: 'Em Andamento'),
        badges.Badge(
          showBadge: _showBadge,
          badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.all(4),
          ),
          badgeContent: Text(
            '$badgeCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: const Tab(text: 'Atrasadas'),
        ),
        badges.Badge(
          badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.all(4),
          ),
          badgeContent: Text(
            '$badgeCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          child: const Tab(text: 'Finalizadas'),
        ),
      ],
    );
  }
}
