import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';

@immutable
class SelectedCityState {
  final CityFromAPI selectedCity;


  const SelectedCityState({required this.selectedCity});
}


class SelectedCityCubit extends Cubit<SelectedCityState> {
  SelectedCityCubit() : super(SelectedCityState(selectedCity: CityFromAPI.emptyCity()));

  selectCity(CityFromAPI selectedCity)async{
    print("CUBIT SELECTEDCITY");
    print("cambio la città selezionata, che è $selectedCity");
    emit(SelectedCityState(selectedCity: selectedCity));
    print("SELEZIONATA");
    print(selectedCity);
  }

}