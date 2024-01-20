# breadcrumb_web

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)
![Pub Version](https://img.shields.io/pub/v/breadcrumbs_web.svg)

A Flutter package for creating responsive and customizable breadcrumb widgets, ideal for web applications. `breadcrumb_web` offers an easy way to display a navigation trail for users and enhance their browsing experience in Flutter web projects.

## Features

- **Customizable Breadcrumbs**: Easily customize font, color, size, and spacing of breadcrumbs.

- **Responsive Design**: Adapts to different screen sizes for optimal display.

- **Hover Effects**: Optional scale effect on hover for better UI interaction.

- **Icon Support**: Include icons in your breadcrumbs for a more intuitive design.

- **Callback Functions**: Execute specific functions when a breadcrumb is clicked.

- **Accessibility Support**: Designed with accessibility in mind, ensuring a wider user reach.

## Getting Started

To use this package, add `breadcrumb_web` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
breadcrumb_web: ^1.0.0
```

## Usage

Here is a quick example to get you started:

```dart

import 'package:flutter/material.dart';

import 'package:breadcrumb_web/breadcrumb_web.dart';

void main() {

    runApp(MyApp());

}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Breadcrumb Web Example',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Breadcrumb Web Example'),
          ),
          body: Center(
            child: BreadcrumbTrail.getCrumbsForWeb(
              crumbs: ['Home', 'Category', 'Item'],
              callbacks: [
                () async => print('Home clicked'),
                () async => print('Category clicked'),
                () async => print('Item clicked'),
              ],
              crumbFontFamily: 'Roboto',
              crumbFontWeight: FontWeight.w600,
              crumbFontColor: Colors.blue,
              crumbSpacing: 8.0,
              scaleOnHover: 1.2,
              crumbFontSize: 16.0,
              crumbIcon: Icons.arrow_forward_ios,
              crumbIconSize: 14.0,
              crumbIconColor: Colors.grey,
            ),
          ),
        ),
      );
    }
}
```

## Customization

`BreadcrumbTrail` class allows you to customize the following properties:

- `crumbs`: A list of strings representing the breadcrumb titles.

- `callbacks`: A list of functions to be called when a breadcrumb is tapped.

- `crumbFontFamily`: Font family of breadcrumb text.

- `crumbFontWeight`: Weight of the font for breadcrumb text.

- `crumbFontColor`: Color of the breadcrumb text.

- `crumbSpacing`: Space between each breadcrumb item.

- `scaleOnHover`: Scale factor when hovering over the breadcrumb (for web).

- `crumbFontSize`: Font size of breadcrumb text.

- `crumbIcon`: The icon to display between breadcrumbs.

- `crumbIconSize`: Size of the icon between breadcrumbs.

- `crumbIconColor`: Color of the icon between breadcrumbs.

## Contributing

Contributions are welcome! If you have a feature request or bug report, please open an issue on our GitHub repository.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

