import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';

import '../../Network/base_clent.dart';
import '../../Provider/authentication_provider.dart';
import '../../Utils/app_asset.dart';
import 'grid view/userinterest_grid_view.dart';
import 'list view/userinterest_list_view.dart';

class UserInterestPage extends StatefulWidget {
  const UserInterestPage({super.key, required this.provider});
  final HomeProvider provider;

  @override
  State<UserInterestPage> createState() => _UserInterestPageState();
}

class _UserInterestPageState extends State<UserInterestPage> {
  final controllers = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.userInterest(context);
    });
    controllers.addListener(() {
      if (controllers.position.maxScrollExtent == controllers.offset) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future fetch() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url = "https://racemart.youtoocanrun.com/api/interest?page=$page";
    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());

    var result = jsonDecode(res);
    // print(result);
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    final List newEvent = result['data']['list'];
    //
    setState(() {
      page++;
      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.provider.listOfUserInterest.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size * 0.75,
      child: widget.provider.isLoadingForUserInterest
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.provider.listOfUserInterest.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Image.asset(noDataFound),
                      TextButton(
                          onPressed: () {},
                          child: const Text("No data interest found!!"))
                    ],
                  ),
                )
              : widget.provider.isList
                  ? UserInterestListView(
                      controllers: controllers, hasMore: hasMore)
                  : UserInterestGridView(
                      controllers: controllers, hasMore: hasMore),
    );
  }
}
