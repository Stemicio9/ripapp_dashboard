import 'package:flutter/cupertino.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';

class Texth1V2 extends StatelessWidget {
  final String testo;
  final Color color;
  final bool? underline;
  final FontWeight? weight;
  final TextAlign? textalign;
  final double? fontsize;

  Texth1V2(
      {required this.testo,
        required this.color,
        this.underline,
        this.weight,
        this.textalign,
        this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text(
      testo,
      textAlign: textalign,
      style: SafeGoogleFont(
        'Montserrat',
        fontWeight: weight,
        color: color,
        fontSize: fontsize ?? 24,
        decoration:
        (underline != null && underline!) ? TextDecoration.underline : null,
      ),
    );
  }
}

class Texth2V2 extends StatelessWidget {
  final String testo;
  final Color color;
  final bool? underline;
  final FontWeight? weight;
  final TextAlign? textalign;

  Texth2V2(
      {required this.testo,
        required this.color,
        this.underline,
        this.weight,
        this.textalign});

  @override
  Widget build(BuildContext context) {
    return Text(
      testo,
      textAlign: textalign,
      style: SafeGoogleFont(
        'Montserrat',
        fontWeight: weight,
        color: color,
        fontSize: 18,
        decoration:
        (underline != null && underline!) ? TextDecoration.underline : null,
      ),
    );
  }
}

class Texth3V2 extends StatelessWidget {
  final String testo;
  final Color color;
  final bool? underline;
  final FontWeight? weight;
  final TextAlign? textalign;
  final double? fontsize;

  Texth3V2(
      {required this.testo,
        required this.color,
        this.underline,
        this.weight,
        this.textalign,
        this.fontsize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      testo,
      textAlign: textalign,
      style:SafeGoogleFont(
        'Montserrat',
        color: color,
        fontWeight: weight,
        fontSize: 18,
        decoration:
        (underline != null && underline!) ? TextDecoration.underline : null,
      ),
    );
  }
}

class Texth4V2 extends StatelessWidget {
  final String testo;
  final Color color;
  final bool? underline;
  final FontWeight? weight;
  final TextAlign? textalign;

  Texth4V2(
      {required this.testo,
        required this.color,
        this.underline,
        this.weight,
        this.textalign});

  @override
  Widget build(BuildContext context) {
    return Text(
      testo,
      textAlign: textalign,
      style: SafeGoogleFont(
        'Montserrat',
        fontWeight: weight,
        color: color,
        fontSize: 14,
        decoration:
        (underline != null && underline!) ? TextDecoration.underline : null,
      ),
    );
  }
}
