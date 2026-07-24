/// The visual style used to render the FAQ list.
///
/// Each style is backed by its own widget under `lib/widgets/`. The actual
/// UI/UX for each style is filled in separately; for now they share the
/// same placeholder layout.
enum CustomFaqStyle {
  classic,
  card,
  minimal,
}
