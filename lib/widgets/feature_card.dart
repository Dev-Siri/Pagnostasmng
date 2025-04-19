import "package:flutter/material.dart";
import "package:neubrutalism_ui/neubrutalism_ui.dart";

class FeatureCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final Color? textColor;

  const FeatureCard({
    super.key,
    required this.label,
    required this.icon,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NeuContainer(
        color: color ?? neuDefault1,
        width: 350,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Column(
              children: <Widget>[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                  size: 55,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
