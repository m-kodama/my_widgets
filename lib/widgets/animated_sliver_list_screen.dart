import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const _cardHeaderSize = 250.0;

class AnimatedSliverListScreen extends StatelessWidget {
  const AnimatedSliverListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}

class _MyHeader {
  const _MyHeader(this.title, this.visible);

  final String title;
  final bool visible;
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final headerNotifier = ValueNotifier<_MyHeader?>(null);
  final scrollNotifier = ValueNotifier(0.0);
  final scrollController = ScrollController();

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? false;

    if (scrollController.offset > 0 && headerTitle != title ||
        lastOne != null ||
        headerVisible != visible) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(lastOne, true);
        } else {
          headerNotifier.value = _MyHeader(title, visible);
        }
      });
    }
  }

  void _onListen() {
    scrollNotifier.value = scrollController.offset;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onListen);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                ValueListenableBuilder<double>(
                    valueListenable: scrollNotifier,
                    builder: (context, snapshot, _) {
                      const space = _cardHeaderSize - kToolbarHeight;
                      final percent = lerpDouble(
                          0.0, -pi / 2, (snapshot / space).clamp(0.0, 1.0))!;
                      final opacity = lerpDouble(
                          1.0, 0.0, (snapshot / space).clamp(0.0, 1.0))!;
                      return SliverAppBar(
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        // backgroundColor: Colors.transparent,
                        title: Text(
                          'タイトル',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        expandedHeight: _cardHeaderSize,
                        stretch: true,
                        flexibleSpace: FlexibleSpaceBar(
                          stretchModes: const [StretchMode.blurBackground],
                          background: Padding(
                            padding: const EdgeInsets.only(top: kToolbarHeight),
                            child: Center(
                              child: Opacity(
                                opacity: opacity,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.003)
                                    ..rotateX(percent),
                                  alignment: Alignment.center,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 16),
                                    children: [
                                      Container(
                                        color: Colors.red,
                                        width: 150,
                                      ),
                                      const SizedBox(width: 10),
                                      Container(
                                        color: Colors.yellow,
                                        width: 120,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle(
                      'Latest Transactions',
                      (visible) => _refreshHeader('April', visible),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text('Title: $index'),
                        );
                      },
                      childCount: 15,
                    ),
                  ),
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle(
                      'March 18',
                      (visible) => _refreshHeader(
                        'March 18',
                        visible,
                        lastOne: 'April',
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text('Title: $index'),
                        );
                      },
                      childCount: 15,
                    ),
                  ),
                ],
              ],
            ),
            ValueListenableBuilder<_MyHeader?>(
                valueListenable: headerNotifier,
                builder: (context, snapshot, _) {
                  final visible = snapshot?.visible ?? false;
                  final title = snapshot?.title ?? '';
                  return Positioned(
                    left: 16,
                    top: 0,
                    right: 0,
                    child: AnimatedSwitcher(
                      duration: const Duration(microseconds: 300),
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild
                          ],
                        );
                      },
                      transitionBuilder: (widget, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            child: widget,
                          ),
                        );
                      },
                      child: visible
                          ? DecoratedBox(
                              key: Key(title),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                              ),
                              child: Text(title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  )),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

const maxHeaderTitleHeight = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class _MyHeaderTitle extends SliverPersistentHeaderDelegate {
  const _MyHeaderTitle(this.title, this.onHeaderChanged);

  final OnHeaderChanged onHeaderChanged;
  final String title;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (shrinkOffset > 0) {
      onHeaderChanged(true);
    } else {
      onHeaderChanged(false);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderTitleHeight;

  @override
  double get minExtent => maxHeaderTitleHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
