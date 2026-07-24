## 0.3.0

* Add optional `link` to `Faq`; when set, the expanded FAQ shows a "See more" action that launches it via `url_launcher`.
* Add `subtitle` param to `CustomFaqPage`.
* Add `CustomFaqStyle` enum (`classic`, `card`, `minimal`) and a `style` param to select the view. Each style is a distinct widget under `lib/widgets/`:
  * `FaqViewClassic` — numbered accordion rows with a rotating chevron and hairline dividers.
  * `FaqViewCard` — elevated, rounded cards with a soft shadow and pill-shaped "See more" action.
  * `FaqViewMinimal` — flat, typographic layout with a plain +/− indicator and generous whitespace.
* Add optional `appBarColor`, `appBarTitleColor`, `backgroundColor`, and `textColor` params to `CustomFaqPage`, applied throughout all three styles.
* Add `url_launcher` dependency.
* Raise minimum Flutter version to `>=3.27.0` (required by `Color.withValues`, used for opacity in the new styles).

## 0.2.0

* Raise minimum SDK to Dart `>=3.4.0 <4.0.0` / Flutter `>=3.22.0` for compatibility with current Flutter releases.
* Upgrade `flutter_widget_from_html` to `^0.17.2`, `line_icons` to `^2.0.3`, and `flutter_lints` to `^6.0.0`.
* Fix lints surfaced by the newer lint set (`unnecessary_library_name`, `use_super_parameters`).
* Regenerate the example app's Android and iOS platform scaffolding for the current Flutter toolchain.
* Rewrite README with real usage instructions.
* Trim `Faq` model to the fields actually used (`title`, `body`); drop unused `id`, `type`, `createdAt`, `updatedAt`, `formattedDate`, `formattedUpdatedDate`.

## 0.0.1

* TODO: Describe initial release.
