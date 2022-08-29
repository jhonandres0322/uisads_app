
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_providers.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class ListAd extends StatefulWidget {
  final List<Ad> ads;
  final Function onNextPage;
  // Revisar si pasarle el provider es un problema
  final ListAdProvider provider;

  const ListAd({
    Key? key,
    required this.ads,
    required this.onNextPage,
    required this.provider
  }) : super(key: key);

  @override
  State<ListAd> createState() => _ListAdState();
}

class _ListAdState extends State<ListAd> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() { 
      // log('entrando al controlador');
      // log('Actual posicion: ${_scrollController.position.pixels}');
      // log('Max posicion: ${_scrollController.position.maxScrollExtent}');
      if( _scrollController.position.pixels >= _scrollController.position.maxScrollExtent ) {
        // log('entrando al scroll');
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    widget.provider.isLoading = false;
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.mainThirdContrast,
      onRefresh: () async {
        log('onRefresh method');
        widget.provider.isRefresh = true;
        widget.onNextPage();
      },
      child: Stack(
        children: [
          GridView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: widget.ads.length,
            itemBuilder: (context, index) {
              return AdCard(
                title: widget.ads[index].title,
                mainPage: widget.ads[index].mainPage,
                id: widget.ads[index].id,
                isManage: widget.provider.validateManage(context),
              );
            }
          ),
          if( widget.provider.isLoading ) 
            Positioned(
              bottom: 15,
              left: size.width * 0.5 - 30,
              child: const _LoadingIcon()
            )
        ]
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all( 10 ),
      height: 50,
      width: 50 ,
      decoration: const BoxDecoration(
        shape: BoxShape.circle
      ),
      child: const CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}