import 'package:flutter/material.dart';

import 'components/distance_container_list.dart';

class DistancesAndPartenr extends StatelessWidget {
  const DistancesAndPartenr({super.key, this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        DistanceContainerList(data: data),
        // const SizedBox(height: 10),
        // PartenerContainerList(data: data),
      ],
    );
  }
}
