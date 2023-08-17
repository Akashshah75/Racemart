import 'package:flutter/material.dart';

import '../../../../Utils/app_size.dart';

class DataAndDescription extends StatelessWidget {
  const DataAndDescription({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // spacingHeightMedium,
        // RegistrationContainer(data: data),
        spacingHeightMedium,
      ],
    );
  }
}
