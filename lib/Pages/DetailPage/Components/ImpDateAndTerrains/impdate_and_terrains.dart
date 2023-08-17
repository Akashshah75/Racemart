import 'package:flutter/material.dart';

import '../important_dates_list.dart';
import '../terains_container_list.dart';

class ImpDateAndTerrains extends StatelessWidget {
  const ImpDateAndTerrains({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImporantDatesList(data: data),
        const SizedBox(height: 10),
        TerrainsContainerList(data: data),
      ],
      // )
    );
  }
}