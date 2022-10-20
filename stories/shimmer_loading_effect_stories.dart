import 'package:flutter/material.dart';
import 'package:my_widgets/widgets/shimmer_loading_effect.dart';

Widget cards() => Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Loading Effect'),
      ),
      body: const ShimmerLoadingEffectSample(),
    );
