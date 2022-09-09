import 'dart:io';
import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';
import 'package:uisads_app/src/constants/import_models.dart';
import 'package:uisads_app/src/constants/import_utils.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    Key? key,
    required this.image,
    required this.radius,
  }) : super(key: key);

  final Upload image;
  final double radius;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: HandlerImage.getImageBase64( widget.image ),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if( snapshot.hasData ) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.mainThirdContrast,
                width: 2.0
              )
            ),
            child: CircleAvatar(
              radius: _size.height * widget.radius,
              backgroundImage: showImage( snapshot.data! )
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }

  ImageProvider showImage( String path ) {
    if( path.isNotEmpty ) {
      return FileImage( File( path ) );
    } else {
      return const AssetImage('assets/images/invitado.png');
    }
  }
}