import 'package:flutter/material.dart';

Widget cards() => Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 256,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -256 / 2 + 10,
                    left: -(256 * 3 - 390) / 2,
                    child: Container(
                      width: 256 * 3,
                      height: 256,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(256 * 3, 256),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Card(
                      elevation: 8,
                      child: SizedBox(
                        width: double.infinity,
                        height: 400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1000,
            ),
          ],
        ),
      ),
    );
