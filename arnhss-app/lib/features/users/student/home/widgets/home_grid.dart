
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    Key? key,
    required this.elements,
  }) : super(key: key);
  final List<StaggeredGridTile> elements;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 21, right: 21),
      child: StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        children: elements,
      ),
    );
  }
}
