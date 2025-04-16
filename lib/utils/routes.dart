import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../ui/ui_tables/export.dart';
import '../ui/side_menu/components/components.dart';
import '../ui/side_menu/pages/pages.dart';

final router = GoRouter(
  initialLocation: '/manutencao',
  routes: [
    ShellRoute(
      builder: (context, state, child) => SideMenuIde(child: child),
      routes: [
        GoRoute(
          path: '/manutencao',
          builder: (context, state) => InitTableAr(
            controller: makeGetxCreateArPresenter(),
          ),
        ),
        GoRoute(
          path: '/crm',
          builder: (context, state) => const DashboardView(),
        ),
        GoRoute(
          path: '/tableItens',
          builder: (context, state) =>
              InitTableItem(controller: makeGetxCreateSimucPresenter()),
        ),
      ],
    ),
  ],
);

onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      GoRouter.of(context).go('/producao');
      break;
    case 1:
      GoRouter.of(context).go('/manutencao');
      break;
    case 2:
      GoRouter.of(context).go('/simcards');
      break;
    case 3:
      GoRouter.of(context).go('/crm');
      break;
    case 4:
      GoRouter.of(context).go('/tableItens');
      break;
  }
}

int calculateSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.toString();
  if (location.startsWith('/producao')) {
    return 0;
  }
  if (location.startsWith('/manutencao')) {
    return 1;
  }
  if (location.startsWith('/simcards')) {
    return 2;
  }
  if (location.startsWith('/crm')) {
    return 3;
  }
  if (location.startsWith('/tableItens')) {
    return 4;
  }
  return 0;
}
