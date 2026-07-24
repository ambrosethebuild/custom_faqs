import 'package:custom_faqs/models/custom_faq_theme.dart';
import 'package:custom_faqs/models/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// Classic style: a familiar, information-dense accordion list.
///
/// Each row carries a numbered badge, a rotating chevron, and a hairline
/// divider between entries — the traditional "help center" layout.
class FaqViewClassic extends StatefulWidget {
  const FaqViewClassic({
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
  State<FaqViewClassic> createState() => _FaqViewClassicState();
}

class _FaqViewClassicState extends State<FaqViewClassic> {
  int? _openIndex;

  @override
  Widget build(BuildContext context) {
    final accent = widget.theme.textColor ?? Theme.of(context).primaryColor;
    final textColor =
        widget.theme.textColor ?? Theme.of(context).colorScheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.62);
    final dividerColor = textColor.withValues(alpha: 0.12);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (widget.subtitle != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: mutedColor,
              ),
            ),
          ),
        for (var index = 0; index < widget.faqs.length; index++) ...[
          if (index > 0) Divider(height: 1, thickness: 1, color: dividerColor),
          _ClassicFaqTile(
            index: index,
            faq: widget.faqs[index],
            isOpen: _openIndex == index,
            accentColor: accent,
            textColor: textColor,
            mutedColor: mutedColor,
            onLaunchLink: widget.onLaunchLink,
            onTap: () {
              setState(() {
                _openIndex = _openIndex == index ? null : index;
              });
            },
          ),
        ],
      ],
    );
  }
}

class _ClassicFaqTile extends StatelessWidget {
  const _ClassicFaqTile({
    required this.index,
    required this.faq,
    required this.isOpen,
    required this.accentColor,
    required this.textColor,
    required this.mutedColor,
    required this.onLaunchLink,
    required this.onTap,
  });

  final int index;
  final Faq faq;
  final bool isOpen;
  final Color accentColor;
  final Color textColor;
  final Color mutedColor;
  final void Function(String link) onLaunchLink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      faq.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: SizedBox(
                      width: 44,
                      height: 28,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: mutedColor,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: 42, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.55,
                          color: mutedColor,
                        ),
                        child: HtmlWidget(faq.body),
                      ),
                      if (faq.link != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () => onLaunchLink(faq.link!),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "See more",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: accentColor,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14,
                                  color: accentColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                crossFadeState: isOpen
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
                sizeCurve: Curves.easeOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
