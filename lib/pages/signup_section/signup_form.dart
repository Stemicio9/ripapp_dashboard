
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/UserEntity.dart';
import 'package:ripapp_dashboard/models/UserStatusEnum.dart';
import 'package:ripapp_dashboard/models/user_entity.dart';
import 'package:ripapp_dashboard/pages/signup_section/text_form_extension.dart';
import 'package:ripapp_dashboard/pages/signup_section/RoundedButton.dart';

class RegisterForm extends StatelessWidget {
  final Function(UserEntity, String) onRegister;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<CityEntity> selectedCities = [];

  RegisterForm({Key? key, required this.onRegister}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    }),
              ),
              Center(
                  child: Image.asset("assets/logo_rect_transparent.png",
                      width: width * 0.8,
                      fit: BoxFit.cover)
              ),
              SizedBox(height: height * 0.02),
              /*
              Text(
                AppPage.register.toTitle.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),*/
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: width / 2.5,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                      decoration:  InputDecoration(
                        //border: OutlineInputBorder(),
                        border: InputBorder.none,
                        hintText: getCurrentLanguageValue(FIRSTNAME) ?? '',
                        hintStyle: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: width / 2.5,
                    child: TextFormField(
                      controller: lastnameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                      decoration:  InputDecoration(
                        //border: OutlineInputBorder(),
                        border: InputBorder.none,
                        hintText:getCurrentLanguageValue(LASTNAME) ?? '',
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width / 2.5,
                    height: 10,
                    child: const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: width / 2.5,
                    height: 10,
                    child: const Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                decoration:  InputDecoration(
                  //border: OutlineInputBorder(),
                  border: InputBorder.none,
                  hintText:getCurrentLanguageValue(EMAIL) ?? '',
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),

              CustomTextFormField(
                  passwordController: passwordController,
                  onEditingComplete: () => {}),
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: .0),
                        hintText:getCurrentLanguageValue(PHONE_NUMBER) ?? '',
                        hintStyle: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              InkWell(
                onTap: () {
                  showSelectCitiesPopup();
                },
                child: Container(
                  height: 50,
                  width: width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: StatefulBuilder(builder: (context, setStateCities) {
                      return Text(
                        //TODO CITY DROPDOWN
                        "Cities of interest${selectedCities.isNotEmpty ? ": ${selectedCities.length}selected" : ""}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: selectedCities
                          .map((city) => InkWell(
                        onTap: () {
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(40)),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                city.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.clear,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: selectedCities.isNotEmpty ? 20 : 0),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: RoundedButton(
                          buttonLabel: getCurrentLanguageValue(SIGNUP) ?? '',
                          buttonLabelColor: Colors.white,
                          buttonColor: Colors.green,
                          onTap: () {
                            UserEntity userEntity = UserEntity(
                              id: "",
                              firstName: nameController.text,
                              lastName: lastnameController.text,
                              city: "",
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              idtoken: "",
                              status: UserStatus.active

                            );
                            onRegister(userEntity, passwordController.text);
                          },
                          fontSize: 20,
                          verticalPadding: 15)),
                ],
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getCurrentLanguageValue(ALREDY_HAVE_ACCOUNT) ?? '',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      print("tappost");
                      Navigator.pushNamed(context, RouteConstants.dashboard);
                      //TODO sostituisco questo per semplicità con navigator, da decommentare
                      // context.go(AppPage.login.path);
                    },
                    child: Text(
                      getCurrentLanguageValue(SIGNIN) ?? '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  void showSelectCitiesPopup() async {
  }

  setStateCities() {}
}
