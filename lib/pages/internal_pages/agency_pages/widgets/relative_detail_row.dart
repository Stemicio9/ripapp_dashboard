import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class RelativeDetailRow extends StatelessWidget {

  final String? relativePhone;
  final String? relativeName;

  const RelativeDetailRow({
    Key? key,
    this.relativeName,
    this.relativePhone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(bottom: 5),
                      child: Text(
                        'IL DEFUNTO È:',
                        style: SafeGoogleFont(
                          'Montserrat',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: background,
                        ),
                      ),
                    ),

                    Texth3V2(
                        testo: relativeName!,
                        color: black
                    )

                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(bottom: 5),
                        child: Text(
                          'NUMERO PARENTE',
                          style: SafeGoogleFont(
                            'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: background,
                          ),
                        ),
                      ),
                      Texth3V2(
                          testo: relativePhone!,
                          color: black
                      )
                    ]
                )
            ),
            Expanded(
                flex:1,
                child: Container())

          ],

      ),
    );
  }
}
