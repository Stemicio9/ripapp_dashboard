import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ripapp_dashboard/blocs/CurrentPageCubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/app_pages.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/demise_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/scaffold.dart';

import '../../../blocs/search_demises_cubit.dart';
import '../../../constants/colors.dart';



class DemiseMenage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemiseManageState();
  }

}


class DemiseManageState extends State<DemiseMenage>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo decesso verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';

  DemiseCubit get _searchDemiseCubit => context.read<DemiseCubit>();
  SelectedDemiseCubit get _selectedDemiseCubit => context.read<SelectedDemiseCubit>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController churchNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController churchAddressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 60, bottom: 60, left: 5, right: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              deleteProfileOnTap: (){},
              onTap: (){
                context.push(AppPage.addDemise.path);
              },
              pageTitle: getCurrentLanguageValue(DEATHS_INSERT)!,
              buttonText: getCurrentLanguageValue(ADD_DEMISE)!,
            ),

              DemiseTable(
                delete: (dynamic p){
                  showDialog(
                      context: context,
                      builder: (ctx) => DeleteMessageDialog(
                          onConfirm: () async {
                            _searchDemiseCubit.delete(p.id);


                            final User user = FirebaseAuth.instance.currentUser!;
                            final uid = user.uid;
                            var path = 'profile_images/deceased_images/UID:$uid/demiseId:${p.firebaseid}/';
                            var obituaryPath = 'obituaries/UID:$uid/demiseId:${p.firebaseid}/';

                            var obituaryList = await FirebaseStorage.instance.ref(obituaryPath).listAll();
                            if (obituaryList.items.isNotEmpty) {
                              var fileesistente = obituaryList.items[0];
                              fileesistente.delete();
                            }

                            var fileList = await FirebaseStorage.instance.ref(path).listAll();
                            if (fileList.items.isNotEmpty) {
                              var fileesistente = fileList.items[0];
                              fileesistente.delete();
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: green,
                                content: const Text('Defunto eliminato con successo!'),
                                duration: const Duration(milliseconds: 3000),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          onCancel: (){
                            Navigator.pop(context);
                          },
                          message: message
                      )
                  );
                },
                edit: (dynamic p){
                  print("demise attuale " +  p.toString());
                context.push(AppPage.editDemise.path);
                  _selectedDemiseCubit.selectDemise(p);
                },

                showDetail: (dynamic p){
                  _selectedDemiseCubit.selectDemise(p);
                  context.push(AppPage.demiseDetail.path);

                },

                detailMessage: detailMessage,
                editMessage: editMessage,
                deleteMessage: deleteMessage,
              )

          ],
        ),
      ),
    );
  }

}