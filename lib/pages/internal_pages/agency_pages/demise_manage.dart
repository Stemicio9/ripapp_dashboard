import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/constants/language.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:ripapp_dashboard/models/DemisesSearchEntity.dart';
import 'package:ripapp_dashboard/models/demise_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/demise_table.dart';
import 'package:ripapp_dashboard/pages/internal_pages/header.dart';
import 'package:ripapp_dashboard/pages/internal_pages/admin_pages/widgets/delete_message_dialog.dart';
import 'package:ripapp_dashboard/repositories/demise_repository.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

import '../../../blocs/search_demises_cubit.dart';
import '../../../constants/colors.dart';
import '../admin_pages/users_manage.dart';


class DemiseMenage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SelectedDemiseCubit(),
        ),

      ],
      child: DemiseManageWidget(),
    );
  }
}

class DemiseManageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemiseManageWidgetState();
  }
}


class DemiseManageWidgetState extends State<DemiseManageWidget>{
  final String detailMessage = 'Dettagli';
  final String editMessage = 'Modifica';
  final String deleteMessage = 'Elimina';
  final String message = 'Le informazioni riguardanti questo decesso verranno definitivamente eliminate. Sei sicuro di volerle eliminare?';

  DemiseCubit get _searchDemiseCubit => context.read<DemiseCubit>();
  SelectedDemiseCubit get _selectedDemise => context.read<SelectedDemiseCubit>();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            deleteProfileOnTap: (){},
            onTap: (){
              Navigator.pushNamed(context, RouteConstants.addDemise);
            },
            pageTitle: getCurrentLanguageValue(DEATHS_INSERT)!,
            buttonText: getCurrentLanguageValue(ADD_DEMISE)!,
          ),

          DemiseTable(
            delete: (dynamic p){
              showDialog(
                  context: context,
                  builder: (ctx) => DeleteMessageDialog(
                      onConfirm: (){
                        _searchDemiseCubit.delete(p.id);
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
              print("Defunto");
              print(p);
              Navigator.pushNamed(context, RouteConstants.editDemise,
                      arguments:_selectedDemise.selectedDemise(p)

              );

            },
            showDetail: (){
              Navigator.pushNamed(context, RouteConstants.demiseDetail,
              );

            },
            detailMessage: detailMessage,
            editMessage: editMessage,
            deleteMessage: deleteMessage,
          )

        ],
      ),
    );
  }

}