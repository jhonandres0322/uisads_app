import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';
import 'package:uisads_app/src/providers/delete_ad_provider.dart';

class AdCard extends StatelessWidget {
  final Upload mainPage;
  final String title;
  final String id;
  final bool isManage;
  
  const AdCard({
    Key? key,
    required this.mainPage,
    required this.title,
    required this.id,
    required this.isManage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    double widthCard = (_size.width - 30) / 2;
    return Container(
      height: widthCard,
      width: widthCard,
      margin: EdgeInsets.all( _size.height * 0.005 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 5 ),
        // color: Colors.red,
        border: Border.all(
          color: Colors.black54,
          width: 2
        )
      ),
      child: Column(
        children: [
          SizedBox(
            height: widthCard * 0.8,
            width: widthCard,
            child: FutureBuilder(
              future: HandlerImage.getImageBase64( mainPage ),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if( snapshot.hasData ) {
                  return Image.file(
                    File( snapshot.data! ),
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.asset(
                    'assets/images/anuncio.jpg',
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          _BottomCard(widthCard: widthCard, title: title, idAd: id, isManage: isManage)
        ],
      ),
    );
  }
}

class _BottomCard extends StatelessWidget {
  const _BottomCard({
    Key? key, 
    required this.widthCard,
    required this.title,
    required this.idAd,
    required this.isManage
  }) : super(key: key);

  final double widthCard;
  final String title;
  final String idAd;
  final bool isManage;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if( isManage ) {
      return Flexible(
        child: Container(
          margin: EdgeInsets.all( _size.width * 0.02),
          width: widthCard,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon:  Icon( CustomUisIcons.delete, size: _size.height * 0.015 ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.mainThirdContrast,
                  onPrimary: AppColors.reject,
                ),
                label: const Text(
                  'Eliminar',
                  style: TextStyle( fontSize: 8 ),
                ),
                onPressed: () => confirmDeleteAd(context, idAd )
              ),
              SizedBox( width: _size.width * 0.05),
              ElevatedButton.icon(
                icon:  Icon( CustomUisIcons.pencil_simple, size: _size.height * 0.015 ),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primary,
                  onPrimary: AppColors.mainThirdContrast,
                ),
                label: const Text(
                  'Editar',
                  style: TextStyle( fontSize: 8 ),
                ),
                onPressed: () async {
                  final adProvider = Provider.of<AdPageProvider>( context, listen: false );
                  final categoryProvider = Provider.of<CategoryProvider>( context, listen: false );
                  await adProvider.getAd(idAd);
                  categoryProvider.categorySelect = adProvider.ad.category;
                  Navigator.pushNamed(context, 'edit-ad');
                },
              ),
            ],
          ),
        )
      );
    } else {
      return Flexible(
        child: SizedBox(
          height: widthCard * 0.2,
          width: widthCard,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only( left: widthCard * 0.04),
                width: widthCard * 0.55,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight:  FontWeight.w500,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
              Container(
              margin: EdgeInsets.only(top: _size.height * 0.004 ),
              width: widthCard * 0.35,
              height: widthCard * 0.12,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary),
                    elevation: MaterialStateProperty.all(0),
                    textStyle: MaterialStateProperty.all(const TextStyle(
                        fontSize: 8, color: AppColors.mainThirdContrast))),
                child: const Text(
                  'Ver más',
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'ad', arguments: {
                    'id' : idAd
                  });
                },
              ),
            ),
            ],
          ),
        )
      );
    }

  }
  
  Future<void> confirmDeleteAd(BuildContext context, String idAd) async {
    final Size _size = MediaQuery.of(context).size;
    final deleteAdProvider = Provider.of<DeleteAdProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return showDialog(
      context: context, 
      builder: ( context ) {
        return AlertDialog(
          scrollable: true,
          elevation: 1.0,
          title: const Text('Eliminar anuncio'),
          content: const Text('¿Esta seguro de eliminar este anuncio?'),
          contentPadding: EdgeInsets.all(_size.height * 0.04),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  ElevatedButton(
                    onPressed: () async {
                      final Response resp = await deleteAdProvider.deleteAd(idAd);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        showAlertCustom(resp.message, resp.error)
                      );
                      profileProvider.currentPage = 0;
                    },
                    style: ElevatedButton.styleFrom(
                      onPrimary: AppColors.reject,
                      primary: AppColors.mainThirdContrast,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: AppColors.reject)),
                    ),
                    child: const Text('Eliminar'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: AppColors.mainThirdContrast,
                        primary: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(color: AppColors.primary)),
                      ),
                      child: const Text('Cerrar')),
                  const SizedBox()
                ],
              )
            ],
        );
      }
    );
  }
}