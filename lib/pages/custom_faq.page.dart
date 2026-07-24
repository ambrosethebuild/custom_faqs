import 'package:custom_faqs/enums/custom_faq_style.dart';
import 'package:custom_faqs/models/custom_faq_theme.dart';
import 'package:custom_faqs/models/faq.dart';
import 'package:custom_faqs/view_models/custom_faq.service.dart';
import 'package:custom_faqs/widgets/faq_view_card.dart';
import 'package:custom_faqs/widgets/faq_view_classic.dart';
import 'package:custom_faqs/widgets/faq_view_minimal.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFaqPage extends StatefulWidget {
  const CustomFaqPage({
    this.title = "FAQs",
    this.subtitle,
    this.link,
    this.style = CustomFaqStyle.classic,
    this.appBarColor,
    this.appBarTitleColor,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? link;
  final CustomFaqStyle style;
  final Color? appBarColor;
  final Color? appBarTitleColor;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  State<CustomFaqPage> createState() => _CustomFaqPageState();
}

class _CustomFaqPageState extends State<CustomFaqPage> {
  //
  Future<void> _launchLink(String link) async {
    final uri = Uri.tryParse(link);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    final customFaqService = CustomFaqService(link: widget.link);
    final theme = CustomFaqTheme(
      appBarColor: widget.appBarColor,
      appBarTitleColor: widget.appBarTitleColor,
      backgroundColor: widget.backgroundColor,
      textColor: widget.textColor,
    );
    //
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        leading: InkWell(
          child: Icon(
            LineIcons.arrowLeft,
            color: widget.appBarTitleColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: widget.appBarTitleColor),
        ),
      ),
      body: FutureBuilder<List<Faq>>(
        future: customFaqService.fetchFaqs(),
        builder: (BuildContext context, AsyncSnapshot<List<Faq>> snapshot) {
          //loading
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final faqs = snapshot.data!;
            switch (widget.style) {
              case CustomFaqStyle.card:
                return FaqViewCard(
                  faqs: faqs,
                  subtitle: widget.subtitle,
                  theme: theme,
                  onLaunchLink: _launchLink,
                );
              case CustomFaqStyle.minimal:
                return FaqViewMinimal(
                  faqs: faqs,
                  subtitle: widget.subtitle,
                  theme: theme,
                  onLaunchLink: _launchLink,
                );
              case CustomFaqStyle.classic:
                return FaqViewClassic(
                  faqs: faqs,
                  subtitle: widget.subtitle,
                  theme: theme,
                  onLaunchLink: _launchLink,
                );
            }
          }
        },
      ),
    );
  }
}
