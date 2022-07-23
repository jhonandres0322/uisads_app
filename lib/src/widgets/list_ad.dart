
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/widgets/ad_card.dart';
import 'package:uisads_app/src/widgets/card_table.dart';


class ListAd extends StatefulWidget {
  const ListAd({Key? key}) : super(key: key);

  @override
  State<ListAd> createState() => _ListAdState();
}

class _ListAdState extends State<ListAd> {
  List<int> ads = [1,2,3,4,5,6,7,8,9,10,11,12,13];
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() { 
      if ( _scrollController.position.pixels + 200  >= _scrollController.position.maxScrollExtent ) {
        log("llegando al final de la pagina");
        // addAds();
        fetchData();
      }
    });
  }


  void  addAds() {
    int indexLast = ads.last;
    ads.addAll(
      [1,2,3,4,5].map((e) => indexLast + e )
    );
    setState(() { });
  }

  Future fetchData() async {
    if ( _isLoading ) return;
    _isLoading = true;
    setState(() { });
    await Future.delayed( const Duration( seconds:  3 ) );
    addAds();
    _isLoading = false;
    setState(() { });
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
              itemCount: ads.length,
              itemBuilder: (context, index) {
                return const AdCard();
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

  Future _onrefresh() async {
    Future.delayed( const Duration( seconds: 2) );
    ads.add( 1 );
    setState(() {});
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