import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavCurvePainter extends CustomPainter {
  Color backgroundColor;

  double insertRadius;

  BottomNavCurvePainter({
    this.backgroundColor = Colors.black,
    this.insertRadius = 38,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 12);

    double insertCurveBeginningX = size.width / 2 - insertRadius;
    double insetCurveEndX = size.width / 2 + insertRadius;
    double transitionToInsertCurveWidth = size.width * 0.05;
    path.quadraticBezierTo(
      size.width * 0.20,
      0,
      insertCurveBeginningX - transitionToInsertCurveWidth,
      0,
    );
    path.quadraticBezierTo(
      insertCurveBeginningX,
      0,
      insertCurveBeginningX,
      insertRadius / 2,
    );

    path.arcToPoint(
      Offset(insetCurveEndX, insertRadius / 2),
      radius: const Radius.circular(10.0),
      clockwise: false,
    );

    path.quadraticBezierTo(
      insetCurveEndX,
      0,
      insetCurveEndX + transitionToInsertCurveWidth,
      0,
    );
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 12);
    path.lineTo(size.width, size.height + 56);
    path.lineTo(0, size.height + 56);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double height = 56;

    // Use theme colors
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final backgroundColor = Theme.of(context).colorScheme.surface;

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height + 56),
            painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
          ),

          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: () {},
              elevation: 0.1,
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(CupertinoIcons.wind, color: Colors.black),
            ),
          ),

          SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Home",
                  icon: CupertinoIcons.home,
                  selected: _selectedIndex == 0,
                  onPressed: () => _onNavBarItemTapped(0),
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: "Search",
                  icon: CupertinoIcons.search,
                  selected: _selectedIndex == 1,
                  onPressed: () => _onNavBarItemTapped(1),
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
