import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisads_app/src/constants/colors.dart';
import 'package:uisads_app/src/providers/edit_profile_provider.dart';
import 'package:uisads_app/src/providers/profile_provider.dart';
import 'package:uisads_app/src/shared_preferences/preferences.dart';


class ProfileAvatar extends StatelessWidget {
    const ProfileAvatar({
    Key? key,
    required this.radius,
  }) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final EditProfileProvider _editProfileProvider = Provider.of<EditProfileProvider>(context);
    final String pathImage = _editProfileProvider.imageProfile.isNotEmpty ? _editProfileProvider.imageProfile : Preferences.image;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.mainThirdContrast,
          width: 2.0
        )
      ),
      child: CircleAvatar(
        radius: _size.height * radius,
        backgroundImage: showImage( pathImage )
      ),
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