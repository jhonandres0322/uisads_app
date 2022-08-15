
import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';
import 'package:uisads_app/src/constants/import_widgets.dart';

class ListAd extends StatefulWidget {
  final List<Ad> ads;
  final Function onNextPage;
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
      if( _scrollController.position.pixels >= _scrollController.position.maxScrollExtent ) {
        widget.provider.isLoading = true;
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.mainThirdContrast,
      onRefresh: () async {
        widget.provider.isLoading = true;
        widget.provider.isRefresh = true;
        widget.onNextPage();
      },
      child: Stack(
        children: [
          GridView.builder(
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
              bottom: 40,
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