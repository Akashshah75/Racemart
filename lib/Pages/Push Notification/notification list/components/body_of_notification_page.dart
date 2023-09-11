import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Network/base_clent.dart';
import '../../../../Provider/Home providers/home_page_provider.dart';
import '../../../../Provider/authentication_provider.dart';
import '../../../../Provider/notifications/notifications_provider.dart';

import '../../../DetailPage/detail_of_home_page.dart';
import '../../../Home/Components/customeEventContainer/custome_event_container.dart';
import '../../../Home/Components/customeEventContainer/grid_view_container.dart';

class BodyOfNotificationPage extends StatefulWidget {
  const BodyOfNotificationPage({
    super.key,
    required this.notificationProvider,
  });
  final NotificationProvider notificationProvider;

  @override
  State<BodyOfNotificationPage> createState() => _BodyOfNotificationPageState();
}

class _BodyOfNotificationPageState extends State<BodyOfNotificationPage> {
  final controllers = ScrollController();
  bool hasMore = false;
  int page = 2;
  bool isLoading = false;
  @override
  void initState() {
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
    //   https: //racemart.youtoocanrun.com/api/wishlist?page=2
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    var provider = Provider.of<AuthenticationProvider>(context, listen: false);
    final url =
        "https://racemart.youtoocanrun.com/api/notifications?page=$page";

    var res = await BaseClient()
        .getMethodWithToken(url, provider.appLoginToken.toString());
    // print(res);

    var result = jsonDecode(res);
    //
    if (result['data'] == null) {
      setState(() {
        hasMore = false;
      });
      return;
    }
    final List newEvent = result['data']['list'];
    // print(newEvent);

    //
    setState(() {
      page++;

      isLoading = false;
      if (newEvent.length < limit) {
        hasMore = false;
      }
      widget.notificationProvider.notificationData.addAll(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    return widget.notificationProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : widget.notificationProvider.notificationData.isEmpty
            ? const Center(child: Text("Don't have any event"))
            : provider.isList
                ? ListViewOfNotifications(
                    controllers: controllers, hasMore: hasMore)
                : GridOfNotificationPage(
                    controllers: controllers, hasMore: hasMore);
  }
}

class GridOfNotificationPage extends StatelessWidget {
  const GridOfNotificationPage({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, value, child) {
        final notificationData = value.notificationData;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GridView.builder(
            controller: controllers,
            itemCount: notificationData.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.1,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              if (index < notificationData.length) {
                dynamic data = notificationData[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailPageOfHome(index: index, data: data)));
                  },
                  child: GridViewEventContainer(data: data),
                );
              } else {
                return hasMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}

class ListViewOfNotifications extends StatelessWidget {
  const ListViewOfNotifications({
    super.key,
    required this.controllers,
    required this.hasMore,
  });

  final ScrollController controllers;
  final bool hasMore;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(builder: (context, value, child) {
      final notificationData = value.notificationData;
      return ListView.builder(
        controller: controllers,
        itemCount: notificationData.length + 1,
        itemBuilder: (context, index) {
          if (index < notificationData.length) {
            final dataOfNotification = notificationData[index];

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPageOfHome(
                        index: index, data: dataOfNotification)));
              },
              child: CustomEventContainer(
                index: index,
                data: dataOfNotification,
                fav: const [],
              ),
            );
          } else {}
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: hasMore
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ),
          );
        },
      );
    });
  }
}
