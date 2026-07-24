A Flutter package that fetches FAQs from a JSON API and displays them as an
expandable list, with HTML-formatted answers.

## Features

* Drop-in `CustomFaqPage` screen with a loading state and expandable FAQ tiles
* Renders HTML in the FAQ body (via `flutter_widget_from_html`)
* Point it at any API endpoint that returns FAQs in the expected JSON shape
* Optional per-FAQ link: when a FAQ has a `link`, a "See more" action launches it in the browser
* Optional page `subtitle`
* Three selectable view styles via `CustomFaqStyle` (`classic`, `card`, `minimal`)
* Optional color overrides: app bar color, app bar title color, background color, text color

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  custom_faqs: ^0.3.0
```

Then run:

```sh
flutter pub get
```

Requires Dart `>=3.4.0 <4.0.0` and Flutter `>=3.27.0`.

## Usage

Push `CustomFaqPage` onto the navigator, passing the endpoint that returns
your FAQs:

```dart
import 'package:custom_faqs/custom_faqs.dart';
import 'package:flutter/material.dart';

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const CustomFaqPage(
      title: 'FAQs',
      subtitle: 'Answers to common questions',
      link: 'https://example.com/api/app/faqs',
      style: CustomFaqStyle.classic,
      appBarColor: Colors.white,
      appBarTitleColor: Colors.black,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    ),
  ),
);
```

The endpoint is expected to return a JSON array of FAQ objects shaped like:

```json
[
  {
    "title": "How do I reset my password?",
    "body": "<p>Go to settings and tap <b>Reset password</b>.</p>",
    "link": "https://example.com/help/reset-password"
  }
]
```

`link` is optional. When present, the expanded FAQ shows a "See more" action
that opens it in an external browser. Any other extra fields in the response
(id, timestamps, etc.) are ignored.

### Styles

`style` selects one of three built-in layouts via the `CustomFaqStyle` enum:

* `CustomFaqStyle.classic` (default) — numbered accordion rows with a
  rotating chevron and hairline dividers between entries.
* `CustomFaqStyle.card` — each FAQ in its own elevated, rounded card with a
  soft shadow and a pill-shaped "See more" action.
* `CustomFaqStyle.minimal` — flat, typographic layout with a plain "+ / −"
  indicator and generous whitespace, no elevation or badges.

All three respect `appBarColor`, `appBarTitleColor`, `backgroundColor`, and
`textColor`, and render the optional per-FAQ "See more" link the same way.

See the [example](example) app for a complete, runnable integration.

## Additional information

Issues and contributions are welcome via the
[GitHub repository](https://github.com/ambrosethebuild/custom_faqs).
