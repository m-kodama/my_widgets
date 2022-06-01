import 'package:flutter/material.dart';

Widget cards() => Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 256,
              color: Color(0xFFFAFAFA),
              child: Stack(
                children: [
                  Positioned(
                    top: -375,
                    left: -450,
                    child: Container(
                      width: 256 * 5,
                      height: 256 * 2,
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(2000, 800),
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
              color: Color(0xFFFAFAFA),
            ),
          ],
        ),
      ),
    );
