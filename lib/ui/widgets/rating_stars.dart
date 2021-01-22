part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double votingAverage;
  final double starSize;
  final double fontSize;
  final MainAxisAlignment alignment;

  RatingStars(
      {this.votingAverage = 0,
      this.starSize = 16,
      this.fontSize = 16,
      this.alignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = votingAverage.round();

    List<Widget> widgets = [];

    widgets.add(
      Text(
        "${(votingAverage * 10).round() / 10}",
        style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
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
