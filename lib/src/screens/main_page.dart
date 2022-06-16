import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/categoria_model.dart';
import 'package:uisads_app/src/widgets/avatar_perfil.dart';
import 'package:uisads_app/src/widgets/bottom_navigation_bar.dart';
import 'package:uisads_app/src/widgets/card_table.dart';
import 'package:uisads_app/src/widgets/categoria_widget.dart';
import 'package:uisads_app/src/widgets/drawer_custom.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // const String userName = 'Hola, Armandosasas';
    // double anchoNombre = userName.length.toDouble();
    // print(anchoNombre);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          // leading:  const CirclePerfilAvatar(width: 91, height: 44,),
          actions: [
            const SizedBox(
              width: 20,
            ),
            const CirclePerfilAvatar(
              width: 91,
              height: 44,
              userName: 'Usuario',
            ),
            // PerfilCirculoUsuario(radio: 22, radioInterno: 2),
            const Spacer(),
            IconButton(
              icon: const Icon(CustomUisIcons.search_right),
              onPressed: () {},
            ),
          ],
          // flexibleSpace: const FlexibleSpaceBar(
          //   title: CirclePerfilAvatar(width: 150, height: 35,),
          //   // centerTitle: true,
          // ),
        ),
        drawer: const DrawerCustom(),
        body: Column(
          children: [
            // Widget Horizontal con la lista de categorias
            Container(
                width: double.infinity,
                // color: Colors.yellow,
                height: 90,
                child: _ListaCategorias()),
            // CardTable para los anuncios mostrados
            Flexible(
                // flex: 1,
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CardTable(),
                );
              },
            )),
          ],
        ),
        bottomNavigationBar: const BottomNavigatonBarUisAds(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {},
          child: const Icon(
            CustomUisIcons.megaphone,
            color: AppColors.logoSchoolPrimary,
          ),
        ));
  }
}

/// Widget placeholder para el CardTable
class CardTablePlaceholder extends StatelessWidget {
  const CardTablePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.red,
                height: 190,
                width: 190,
              ),
            ],
          ),
        ]));
  }
}

/// Widget Horizontal con la lista de categorias
// TODO: Implementar el Widget Horizontal con la lista de categorias y mover de la main page a un archivo separado
class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Categoria> categorias = [
      Categoria(icono: CustomUisIcons.geometry_icon, nombre: 'Variados'),
      Categoria(icono: CustomUisIcons.food, nombre: 'Alimentos'),
      Categoria(icono: CustomUisIcons.key_hand, nombre: 'Alquiler'),
      Categoria(icono: CustomUisIcons.art, nombre: 'Arte'),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Deportes'),
      Categoria(icono: CustomUisIcons.facilitador, nombre: 'Educación'),
      Categoria(icono: CustomUisIcons.sports, nombre: 'Empleo'),
      Categoria(icono: CustomUisIcons.work_tool, nombre: 'Servicios'),
      Categoria(icono: CustomUisIcons.cloathing, nombre: 'Textil'),
      Categoria(icono: Icons.laptop, nombre: 'Tecnología'),
    ];
    // TODO: Agregar la lista de categorias
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoriaButton(
          icono: categorias[index].icono,
          nombre: categorias[index].nombre,
        );
      },
    );
  }
}

/// Widget con el perfil y circulo avatar para el perfil de la pagina
class CirclePerfilAvatar extends StatelessWidget {
  const CirclePerfilAvatar({
    Key? key,
    required this.width,
    required this.height,
    required this.userName,
  }) : super(key: key);

  final double width;
  final double height;
  final String userName;
  @override
  Widget build(BuildContext context) {
    // Obtenemos los valores de la pantalla
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        height: height,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Entre mas abajo del stack mas arriba en pantalla estará
            _BarraPerfilNombre(
              // width: width ,
              height: height,
              nombreUser: 'Hola, $userName',
            ),
            // Stack con el circulo de perfil
            PerfilCirculoUsuario(radio: height / 2, radioInterno: 2),
          ],
        ),
      ),
    );
  }
}

///Widget de la barra complemento del perfil
class _BarraPerfilNombre extends StatelessWidget {
  const _BarraPerfilNombre({
    Key? key,
    // required this.width,
    required this.height,
    required this.nombreUser,
  }) : super(key: key);
  // final double width;
  final double height;
  final String nombreUser;

  @override
  Widget build(BuildContext context) {
    double anchoNombre = nombreUser.length.toDouble();
    return Container(
      padding: const EdgeInsets.only(right: 5),
      alignment: Alignment.centerRight,
      // width: width*1.35,//(anchoNombre > 10) ? anchoNombre * 9 : anchoNombre * 10,
      height: height / 1.5,
      child: Row(
        children: [
          SizedBox(
            width: height + 5,
          ),
          // Texto de nombre del usuario conectado
          Text(nombreUser,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  color: AppColors.titles,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 10)),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromRGBO(103, 185, 62, 0.2),
      ),
    );
  }
}
