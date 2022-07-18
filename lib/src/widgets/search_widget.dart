import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/constants/custom_uis_icons_icons.dart';
import 'package:uisads_app/src/utils/input_decoration.dart';
import 'package:uisads_app/src/widgets/bottom_sheet.dart';



class SearchWidget extends StatelessWidget {
   const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Widget inputEmail = TextField(
      onChanged: (value) {},
      controller: TextEditingController(),
      // autofocus: false,
      keyboardType: TextInputType.text,
      decoration: decorationInputCustom(CustomUisIcons.search_right,
          '¿Qué estas buscando?', AppColors.titles, true),
    );

    return Container(
      height: size.height * 0.06,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(left: size.width * 0.05),
              width: size.width * 0.75,
              child: inputEmail),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(CustomUisIcons.filter),
            color: AppColors.subtitles,
            onPressed: () => showModalBottomSheet(
              context: context,
              // isScrollControlled: true ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => const BottomSheetFilter(),
            ),
            // iconSize: size.height * 0.06,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

