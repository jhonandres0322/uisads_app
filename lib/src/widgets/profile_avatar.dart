import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/models/upload.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';
import 'package:uisads_app/src/utils/handler_image.dart';


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
      future: getImageBase64( widget.image ),
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
      return const AssetImage('assets/images/avatar.png');
    }
  }
}