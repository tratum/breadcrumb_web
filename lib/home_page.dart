import 'package:breadcrumbs_web/breadcrumbs_web.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> crumbs = ['Home', 'Category', 'Item'];
  final List<Future<dynamic> Function()> callbacks = [
    () async => print('Home clicked'),
    () async => print('Category clicked'),
    () async => print('Item clicked'),
  ];
  final List<BreadcrumbState> breadcrumbStates = [
    BreadcrumbState.completed,
    BreadcrumbState.active,
    BreadcrumbState.disabled,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BreadcrumbTrail.getCrumbsForWeb(
            crumbs: crumbs,
            callbacks: callbacks,
            breadcrumbStates: breadcrumbStates,
            crumbSpacing: 16,
          ),
        ],
      ),
    );
  }
}
