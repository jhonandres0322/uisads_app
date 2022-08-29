import 'package:flutter/material.dart';

import 'package:uisads_app/src/constants/import_constants.dart';

class LoadingProgressCustom extends StatelessWidget {
  const LoadingProgressCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}
