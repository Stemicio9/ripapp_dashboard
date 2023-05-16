import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/utils/style_utils.dart';
import 'package:ripapp_dashboard/widgets/dialog_card.dart';

class ProductDetail extends StatelessWidget {
  final String cardTitle;
  final String id;
  final String name;
  final String price;
  final String description;

  const ProductDetail({
    super.key,
    required this.cardTitle,
    required this.name,
    required this.id,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: getPadding(left: 80, right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialogCard(
              paddingLeft: 10,
              paddingRight: 10,
              cancelIcon: true,
              cardTitle: cardTitle,
              child: Column(
                children: [
                  Padding(
                      padding: getPadding(bottom: 30),
                      child: Row(
                          children: [
                        Expanded(
                          flex: 1,
                          child: RichText(
                              text: TextSpan(
                                  text: 'ID: ',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: background,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: id,
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ))
                              ])),
                        ),
                        Expanded(
                          flex: 1,
                          child: RichText(
                              text: TextSpan(
                                  text: 'NOME: ',
                                  style: SafeGoogleFont(
                                    'Montserrat',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: background,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: name,
                                    style: SafeGoogleFont(
                                      'Montserrat',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ))
                              ])),
                        ),
                      ])),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: RichText(
                          text: TextSpan(
                              text: 'PREZZO: ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: background,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: '$price €',
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ))
                          ])),
                    ),
                    Expanded(
                      flex: 1,
                      child: RichText(
                          text: TextSpan(
                              text: 'DESCRIZIONE: ',
                              style: SafeGoogleFont(
                                'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: background,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: description,
                                style: SafeGoogleFont(
                                  'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ))
                          ])),
                    ),
                  ]),
                ],
              ))
        ],
      ),
    );
  }
}
