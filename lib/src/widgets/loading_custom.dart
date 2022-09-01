import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';

/// Widget Loading
class LoadingCircleCustom extends StatelessWidget {
  const LoadingCircleCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle
      ),
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
