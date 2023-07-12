import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/selected_relative_cubit.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/size_utils.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/texts.dart';

class RelativeDetailRow extends StatelessWidget {

  late String? relativePhone;
  late String? relativeName;

   RelativeDetailRow({
    Key? key,
    this.relativeName = "",
    this.relativePhone = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedRelativeCubit, SelectedRelativeState>(
        builder: (context, stateRelative) {
      if (stateRelative is SelectedRelativeState) {
          relativeName = stateRelative.selectedRelative.relativeName ?? "";
          relativePhone = stateRelative.selectedRelative.relativePhone ?? "";
        return
      Padding(
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
                        'IL PARENTE È:',
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
      else return ErrorWidget("exception");

        });
  }
}
