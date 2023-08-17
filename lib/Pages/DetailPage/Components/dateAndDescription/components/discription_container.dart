import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../../../../Helper/Widget/heading_text.dart';
import '../../../../../Provider/detail_page_provider.dart';
import '../../../../../Utils/app_color.dart';

class DescriptionContainer extends StatefulWidget {
  const DescriptionContainer({
    super.key,
    this.data,
  });
  final dynamic data;

  @override
  State<DescriptionContainer> createState() => _DescriptionContainerState();
}

class _DescriptionContainerState extends State<DescriptionContainer> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final pro = Provider.of<DetailProvider>(context, listen: false);
      pro.changeLength(widget.data['description'] ?? '');
      pro.flag = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DetailProvider>(context, listen: true);
    return Container(
      height: 280,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadingText(
                    fontSize: 16,
                    text: 'Description',
                    color: blackColor.withAlpha(200),
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.changeText();
                      provider.changeLength(widget.data['description']);
                    },
                    child: provider.flag
                        ? const Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          )
                        : const Icon(
                            Icons.arrow_drop_up_outlined,
                            size: 25,
                          ),
                  )
                ],
              ),
              const Divider(),
              HtmlWidget(
                provider.flag
                    ? provider.intialHtmlText
                    : provider.expendedHtmlText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
