import 'package:flutter/material.dart';
import 'package:uisads_app/src/constants/colors.dart';


class AdCard extends StatelessWidget {
  const AdCard({
    Key? key, 
    this.title = 'Titulo Anuncio',
  }) : super(key: key);

  final String title;
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
            child: Image.asset(
              'assets/images/anuncio.jpg',
              fit: BoxFit.cover,
            )
          ),
          Flexible(
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
                      style: TextStyle(
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
                      Navigator.pushNamed(context, 'ad');
                    },
                  ),
                ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}