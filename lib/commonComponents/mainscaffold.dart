import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';


class MainScaffold extends StatelessWidget {
  const MainScaffold({Key? key,
    required this.route,
    required this.body,

    required this.value,

  }) : super(key: key);

  final Widget body;
  final String route;

  final String value;

  final List<AdminMenuItem> _adminMenuItems = const [
    AdminMenuItem(
      title: 'User Profile',
      icon: Icons.account_circle,
      route: '/',
    ),
    AdminMenuItem(
      title: 'Settings',
      icon: Icons.settings,
      route: '/',
    ),
    AdminMenuItem(
      title: 'Logout',
      icon: Icons.logout,
      route: '/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
      return AdminScaffold(
        appBar: AppBar(
          title: const Text('Inquiry Tool'),
          actions: [
            PopupMenuButton<AdminMenuItem>(
              child: const Icon(Icons.account_circle),
              itemBuilder: (context) {
                return _adminMenuItems.map((AdminMenuItem item) {
                  return PopupMenuItem<AdminMenuItem>(
                    value: item,
                    child: Row(
                      children: [
                        Icon(item.icon),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              onSelected: (item) {
                print(
                    'actions: onSelected(): title = ${item
                        .title}, route = ${item.route}');
                Navigator.of(context).pushNamed(item.route!);
              },
            ),
          ],
        ),
        sideBar: SideBar(
          items:  [
            AdminMenuItem(
              title: 'Menu',
              route: '/',
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
                title: 'Inquiry',
                icon: Icons.file_copy,
                children: [
                  AdminMenuItem(
                      title: 'Inquiry List',
                      route: '/list'
                  ),
                  AdminMenuItem(
                    title: value == "User" ? 'Add Inquiry':"User",
                    route: '/add',
                  )

                ]
            ),
          ],
          selectedRoute: route,
          onSelected: (item) {
            print(
                'sideBar: onTap(): title = ${item.title}, route = ${item
                    .route}');
            if (item.route != null && item.route != route) {
              Navigator.of(context).pushNamed(item.route!);
            }
          },

        ),
        body: SingleChildScrollView(
          child: body,
        ),
      );
    }

}


