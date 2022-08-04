
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/models/ad.dart';
import 'package:uisads_app/src/widgets/ad_card.dart';
import 'package:uisads_app/src/widgets/card_table.dart';


class ListAd extends StatefulWidget {
  final List<Ad> ads;
  final Function onNextPage;

  const ListAd({
    Key? key,
    required this.ads,
    required this.onNextPage
  }) : super(key: key);

  @override
  State<ListAd> createState() => _ListAdState();
}

class _ListAdState extends State<ListAd> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() { 
      if ( _scrollController.position.pixels + 200  >= _scrollController.position.maxScrollExtent ) {
        // addAds();
        widget.onNextPage;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MediaQuery.removePadding(
      context: context,
      child: Container(
        child: Stack(
          children: [
            GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              physics: const BouncingScrollPhysics(),
              itemCount: widget.ads.length,
              itemBuilder: (context, index) {
                return AdCard(
                  title: widget.ads[index].title,
                  mainPage: widget.ads[index].mainPage,
                );
              }
            ),
            if( _isLoading ) 
                Positioned(
                  bottom: 40,
                  left: size.width * 0.5 - 30,
                  child: const _LoadingIcon()
                )
            
            
          ]
        ),
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
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),
      child: const CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}