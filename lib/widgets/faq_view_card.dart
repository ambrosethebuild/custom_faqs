import 'package:custom_faqs/models/custom_faq_theme.dart';
import 'package:custom_faqs/models/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// Card style: each FAQ sits in its own elevated, rounded surface.
///
/// A modern, SaaS-style presentation with breathing room between entries
/// and a soft shadow to lift the active card.
class FaqViewCard extends StatefulWidget {
  const FaqViewCard({
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
  State<FaqViewCard> createState() => _FaqViewCardState();
}

class _FaqViewCardState extends State<FaqViewCard> {
  int? _openIndex;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = widget.theme.textColor ?? Theme.of(context).primaryColor;
    final textColor = widget.theme.textColor ?? scheme.onSurface;
    final mutedColor = textColor.withValues(alpha: 0.62);
    final surfaceColor = ElevationOverlay.applySurfaceTint(
      widget.theme.backgroundColor ?? scheme.surface,
      accent,
      1,
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        if (widget.subtitle != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
            child: Text(
              widget.subtitle!,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: mutedColor,
              ),
            ),
          ),
        for (var index = 0; index < widget.faqs.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _CardFaqTile(
              faq: widget.faqs[index],
              isOpen: _openIndex == index,
              accentColor: accent,
              textColor: textColor,
              mutedColor: mutedColor,
              surfaceColor: surfaceColor,
              onLaunchLink: widget.onLaunchLink,
              onTap: () {
                setState(() {
                  _openIndex = _openIndex == index ? null : index;
                });
              },
            ),
          ),
      ],
    );
  }
}

class _CardFaqTile extends StatelessWidget {
  const _CardFaqTile({
    required this.faq,
    required this.isOpen,
    required this.accentColor,
    required this.textColor,
    required this.mutedColor,
    required this.surfaceColor,
    required this.onLaunchLink,
    required this.onTap,
  });

  final Faq faq;
  final bool isOpen;
  final Color accentColor;
  final Color textColor;
  final Color mutedColor;
  final Color surfaceColor;
  final void Function(String link) onLaunchLink;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isOpen
              ? accentColor.withValues(alpha: 0.35)
              : textColor.withValues(alpha: 0.08),
          width: isOpen ? 1.5 : 1,
        ),
        boxShadow: isOpen
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1.35,
                          color: textColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isOpen
                            ? accentColor
                            : accentColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedRotation(
                        turns: isOpen ? 0.125 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.add_rounded,
                          size: 18,
                          color: isOpen ? Colors.white : accentColor,
                        ),
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
                        Divider(
                          height: 1,
                          color: textColor.withValues(alpha: 0.08),
                        ),
                        const SizedBox(height: 12),
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
                            padding: const EdgeInsets.only(top: 12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => onLaunchLink(faq.link!),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
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
                                      Icons.north_east_rounded,
                                      size: 14,
                                      color: accentColor,
                                    ),
                                  ],
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
                  duration: const Duration(milliseconds: 200),
                  sizeCurve: Curves.easeOut,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
