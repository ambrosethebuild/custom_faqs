import 'package:custom_faqs/models/custom_faq_theme.dart';
import 'package:custom_faqs/models/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// Minimal style: quiet, typographic, low-chrome FAQ list.
///
/// No badges, no elevation — just generous whitespace, a hairline rule
/// between entries, and a plain "+ / −" indicator.
class FaqViewMinimal extends StatefulWidget {
  const FaqViewMinimal({
    required this.faqs,
    required this.onLaunchLink,
    this.subtitle,
    this.theme = const CustomFaqTheme(),
    super.key,
  });

  final List<Faq> faqs;
  final void Function(String link) onLaunchLink;
  final String? subtitle;
  final CustomFaqTheme theme;

  @override
  State<FaqViewMinimal> createState() => _FaqViewMinimalState();
}

class _FaqViewMinimalState extends State<FaqViewMinimal> {
  int? _openIndex;

  @override
  Widget build(BuildContext context) {
    final textColor =
        widget.theme.textColor ?? Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.55);
    final ruleColor = textColor.withValues(alpha: 0.14);

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      children: [
        if (widget.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                letterSpacing: 0.1,
                color: mutedColor,
              ),
            ),
          ),
        Divider(height: 1, thickness: 1, color: ruleColor),
        for (var index = 0; index < widget.faqs.length; index++)
          _MinimalFaqTile(
            faq: widget.faqs[index],
            isOpen: _openIndex == index,
            textColor: textColor,
            mutedColor: mutedColor,
            ruleColor: ruleColor,
            onLaunchLink: widget.onLaunchLink,
            onTap: () {
              setState(() {
                _openIndex = _openIndex == index ? null : index;
              });
            },
          ),
      ],
    );
  }
}

class _MinimalFaqTile extends StatelessWidget {
  const _MinimalFaqTile({
    required this.faq,
    required this.isOpen,
    required this.textColor,
    required this.mutedColor,
    required this.ruleColor,
    required this.onLaunchLink,
    required this.onTap,
  });

  final Faq faq;
  final bool isOpen;
  final Color textColor;
  final Color mutedColor;
  final Color ruleColor;
  final void Function(String link) onLaunchLink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          faq.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                isOpen ? FontWeight.w600 : FontWeight.w500,
                            height: 1.4,
                            letterSpacing: 0.1,
                            color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 12,
                              height: 1.4,
                              color: mutedColor,
                            ),
                            AnimatedRotation(
                              turns: isOpen ? 0.25 : 0,
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              child: AnimatedOpacity(
                                opacity: isOpen ? 0 : 1,
                                duration: const Duration(milliseconds: 120),
                                child: Container(
                                  width: 1.4,
                                  height: 12,
                                  color: mutedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle.merge(
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.65,
                              letterSpacing: 0.1,
                              color: mutedColor,
                            ),
                            child: HtmlWidget(faq.body),
                          ),
                          if (faq.link != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: InkWell(
                                onTap: () => onLaunchLink(faq.link!),
                                child: Text(
                                  "See more",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.1,
                                    color: textColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: mutedColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    crossFadeState: isOpen
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 180),
                    sizeCurve: Curves.easeOut,
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: ruleColor),
      ],
    );
  }
}
