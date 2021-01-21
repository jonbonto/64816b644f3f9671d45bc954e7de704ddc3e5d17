part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double votingAverage;
  final double starSize;
  final double fontSize;
  final MainAxisAlignment alignment;

  RatingStars(
      {this.votingAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.alignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = votingAverage.round();

    List<Widget> widgets = [];

    widgets.add(
      Text(
        "${(votingAverage * 10).round() / 10}",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: fontSize),
      ),
    );

    widgets.add(SizedBox(
      width: 3,
    ));

    widgets.addAll(List.generate(
      5,
      (index) => Icon(index < n ? MdiIcons.star : MdiIcons.starOutline,
          color: Color(0xFFFBD460), size: starSize),
    ));
    return Row(
      mainAxisAlignment: alignment,
      children: widgets,
    );
  }
}
