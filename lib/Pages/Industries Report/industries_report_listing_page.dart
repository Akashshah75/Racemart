import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/report/industries_provider.dart';

import '../../Utils/app_color.dart';
import '../Home/Drawer/zoom_drawer.dart';
import 'industries_report_page.dart';

class IndustriesReportListingPage extends StatefulWidget {
  const IndustriesReportListingPage({super.key});

  @override
  State<IndustriesReportListingPage> createState() =>
      _IndustriesReportListingPageState();
}

class _IndustriesReportListingPageState
    extends State<IndustriesReportListingPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider =
          Provider.of<IndustriesReportProvider>(context, listen: false);
      provider.fetchIndustriesReportList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<IndustriesReportProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: const MenuWidget(),
        title: const Text(
          'Industry Report',
          style: TextStyle(color: blackColor),
        ),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: provider.industriesReportList.length,
              itemBuilder: (context, index) {
                final dataOfIndustriesReport =
                    provider.industriesReportList[index];
                return IndustryReportContainer(data: dataOfIndustriesReport);
              }),
    );
  }
}

class IndustryReportContainer extends StatelessWidget {
  const IndustryReportContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: IndustriesReportDetailPage(id: data['id']),
              inheritTheme: true,
              ctx: context),
        );
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const IndustriesReportDetailPage()));
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: greyColor.withOpacity(0.2),
          ),
        ),
        child: Text(
          data['title'].toString(),
          style: TextStyle(
            fontSize: 16,
            color: blueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
