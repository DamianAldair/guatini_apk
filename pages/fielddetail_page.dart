import 'package:flutter/material.dart';
import 'package:guatini/global/main_container.dart';

class FieldDetailPage extends StatelessWidget {
  const FieldDetailPage({
    Key? key,
    required this.field,
    required this.instance,
  }) : super(key: key);

  final String field;
  final List<String> instance;

  @override
  Widget build(BuildContext context) {
    return AdsContainer(
      child: DefaultTabController(
        length: instance.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(field),
            bottom: TabBar(
              tabs: [
                Text(instance[0]),
                Text(instance[1]),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: _DescriptionButton(onPressed: () {}),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(5.0),
                        height: 50.0,
                        width: double.infinity,
                      ),
                    ]),
                  ),
                ],
              ),
              const CustomScrollView(
                slivers: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DescriptionButton extends SliverPersistentHeaderDelegate {
  final VoidCallback onPressed;

  _DescriptionButton({required this.onPressed});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 60.0,
      ),
      child: FloatingActionButton.extended(
        elevation: 1.0,
        label: const Text('Ver descripción'),
        onPressed: onPressed,
      ),
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 65;

  @override
  bool shouldRebuild(covariant _DescriptionButton oldDelegate) {
    return true;
  }
}
