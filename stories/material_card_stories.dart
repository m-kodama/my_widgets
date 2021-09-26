import 'package:flutter/material.dart';

Widget cards() => Scaffold(
      appBar: AppBar(
        title: const Text('Material Cards'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [0, 1, 2, 3, 4, 6, 8, 12, 16, 24]
            .map((elevation) => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(child: Text('elevation: $elevation')),
                  elevation: elevation * 1.0,
                ))
            .toList(),
      ),
    );
