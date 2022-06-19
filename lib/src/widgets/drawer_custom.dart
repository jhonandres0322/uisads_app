import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/items_drawer.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = listDrawer;
    final Size size = MediaQuery.of(context).size;
    return Drawer(
        elevation: 1.0,
        child: SafeArea(
          child: Column(
            children: [
              const CardInfoProfile(),
              SizedBox(height: size.height * 0.05),
              Expanded(
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemDrawer(data: items[index]);
                    }),
              ),
              ItemDrawer(data: logoutDrawerInfo),
              SizedBox(
                height: size.height * 0.05,
              )
            ],
          ),
        ));
  }
}

class CardInfoProfile extends StatelessWidget {
  const CardInfoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'profile');
      },
      child: Container(
        child: Row(
          children: [
            SizedBox(width: size.width * 0.05),
            const PerfilCirculoUsuario(radio: 30.0),
            SizedBox(width: size.width * 0.03),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Jorge Andres Gonzalez',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainThirdContrast,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'jorgegonzalez123@gmail.com',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: AppColors.mainThirdContrast,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
        height: size.height * 0.18,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF67B93E),
          Color(0xFF3EB96B),
          Color(0xFFA9B93E)
        ])),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final Map<String, dynamic> data;
  const ItemDrawer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // return Text('${data['label']}');
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return InkWell(
      onTap: () => getNavigationRoute(context, data['route']),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.015),
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: getColorContainer(currentRoute, data['route'])),
              bottom: BorderSide(
                  color: getColorContainer(currentRoute, data['route'])),
            ),
            color: getColorContainer(currentRoute, data['route'])
                .withOpacity(0.2)),
        child: Row(
          children: [
            Icon(data['icon'],
                size: size.height * 0.03,
                color: getColorItem(currentRoute, data['route'])),
            SizedBox(width: size.width * 0.04),
            Text(
              data['label'],
              style:
                  TextStyle(
                    color: getColorItem(currentRoute, data['route']),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500
                  ),
            )
          ],
        ),
      ),
    );
  }

  Color getColorContainer(final currentRoute, String route) =>
      currentRoute == route ? AppColors.primary : AppColors.mainThirdContrast;

  Color getColorItem(final currentRoute, String route) =>
      currentRoute == route ? AppColors.primary : AppColors.logoSchoolPrimary;

  void getNavigationRoute(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
        context, routeName, (Route<dynamic> route) => false);
  }
}
