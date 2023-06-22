import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ripapp_dashboard/authentication/firebase_authentication_listener.dart';
import 'package:ripapp_dashboard/blocs/SearchProductCubit.dart';
import 'package:ripapp_dashboard/blocs/SearchProductsOfferedCubit.dart';
import 'package:ripapp_dashboard/blocs/current_user_cubit.dart';
import 'package:ripapp_dashboard/blocs/searchAgenciesCubit.dart';
import 'package:ripapp_dashboard/blocs/searchKinshipCubit.dart';
import 'package:ripapp_dashboard/blocs/search_demises_cubit.dart';
import 'package:ripapp_dashboard/blocs/search_users_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_agency_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_demise_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_product_cubit.dart';
import 'package:ripapp_dashboard/blocs/selected_user_cubit.dart';
import 'package:ripapp_dashboard/blocs/users_list_cubit.dart';
import 'package:ripapp_dashboard/constants/route_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ripapp_dashboard/utils/AppUtils.dart';
import 'firebase_options.dart';


void main() async {
  String initialRoute = "/";
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(initialRoute: initialRoute));
  AppUtils.firebaseApplication = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*
  var credential = Credentials.applicationDefault();
  credential ??= await Credentials.login();
  var app = FirebaseAdmin.instance.initializeApp(AppOptions(
    credential: ServiceAccountCredential ('service-account.json'),
  ));*/
}

class MyApp extends StatelessWidget {


  final String initialRoute;
  static const int primaryColor = 0xFF412268;

  final MaterialColor primary = const MaterialColor(primaryColor,
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(primaryColor),
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF311B92),
  });

  const MyApp({super.key,required this.initialRoute});

  @override
  /*
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('it'),
        Locale('en')
      ],
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: primary
      ),
      routes: RouteConstants.route(context) ,
      initialRoute: initialRoute,
    );
  }
*/
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider<CustomFirebaseAuthenticationListener>(create: (_) => CustomFirebaseAuthenticationListener()),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<SearchProductsOfferedCubit>(create: (_) => SearchProductsOfferedCubit()),
            BlocProvider<SearchProductCubit>(create: (_) => SearchProductCubit()),
            BlocProvider<DemiseCubit>(create: (_) => DemiseCubit()),
            BlocProvider<SearchUsersCubit>(create: (_) => SearchUsersCubit()),
            BlocProvider<SearchAgencyCubit>(create: (_) => SearchAgencyCubit()),
            BlocProvider<UsersListCubit>(create: (_) => UsersListCubit()),
            BlocProvider<SearchKinshipCubit>(create: (_) => SearchKinshipCubit()),
            BlocProvider<CurrentUserCubit>(create: (_) => CurrentUserCubit()),
            BlocProvider<SelectedDemiseCubit>(create: (_) => SelectedDemiseCubit()),
            BlocProvider<SelectedUserCubit>(create: (_) => SelectedUserCubit()),
            BlocProvider<SelectedAgencyCubit>(create: (_) => SelectedAgencyCubit()),
            BlocProvider<SelectedProductCubit>(create: (_) => SelectedProductCubit()),
          ],
          child: Builder(
            builder: (context) {
              return MaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: const [
                  Locale('it'),
                  Locale('en')
                ],
                title: 'Flutter Demo',
                theme: ThemeData(

                  primarySwatch: primary
                ),
                routes: RouteConstants.route(context) ,
                initialRoute: initialRoute,
              );
            },
          ),
        )
    );
  }
}