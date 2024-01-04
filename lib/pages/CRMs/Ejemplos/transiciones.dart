import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../baks/second_screen.dart';

void main() => runApp(MyApp());

///Example App
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/second':
            return PageTransition(
              child: SecondScreen(),
              type: PageTransitionType.fade,
              settings: settings,
              reverseDuration: Duration(seconds: 3),
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}

/// Example page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Page Transition'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              child: Text('Fade Second Page - Default'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SecondScreen(),
                    isIos: true,
                    duration: Duration(milliseconds: 400),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Left To Right Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right To Left Transition Second Page Ios SwipeBack'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    isIos: true,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Left To Right with Fade Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    alignment: Alignment.topCenter,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right To Left Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right To Left with Fade Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Top to Bottom Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.linear,
                    type: PageTransitionType.topToBottom,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Bottom to Top Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.linear,
                    type: PageTransitionType.bottomToTop,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Scale Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.topCenter,
                    duration: Duration(milliseconds: 400),
                    isIos: true,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Rotate Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.bounceOut,
                    type: PageTransitionType.rotate,
                    alignment: Alignment.topCenter,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Size Transition Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    curve: Curves.bounceOut,
                    type: PageTransitionType.size,
                    child: SecondScreen(),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right to Left Joined'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(milliseconds: 600),
                        type: PageTransitionType.rightToLeftJoined,
                        child: SecondScreen(),
                        childCurrent: this));
              },
            ),
            ElevatedButton(
              child: Text('Left to Right Joined'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.leftToRightJoined,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('Top to Bottom Joined'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.topToBottomJoined,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('Bottom to Top Joined'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.bottomToTopJoined,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('Right to Left Pop'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(milliseconds: 600),
                        type: PageTransitionType.rightToLeftPop,
                        child: SecondScreen(),
                        childCurrent: this));
              },
            ),
            ElevatedButton(
              child: Text('Left to Right Pop'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.leftToRightPop,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('Top to Bottom Pop'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.topToBottomPop,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('Bottom to Top Pop'),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.bottomToTopPop,
                      child: SecondScreen(),
                      childCurrent: this),
                );
              },
            ),
            ElevatedButton(
              child: Text('PushNamed With arguments'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/second",
                  arguments: "with Arguments",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
