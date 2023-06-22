import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ripapp_dashboard/models/CityEntity.dart';
import 'package:ripapp_dashboard/models/city_from_API.dart';
import 'package:ripapp_dashboard/repositories/user_repository.dart';

@immutable
class CityListState {}

class CityListLoading extends CityListState {}

class CityListError extends CityListState {}

class CityListLoaded extends CityListState {
  final List<CityFromAPI> listCity;

  CityListLoaded(this.listCity);

  CityListLoaded copyWith({List<CityFromAPI>? city}) {
    print("SONO NEL LOADER DI CITY");
    return CityListLoaded(
      city ?? this.listCity,
    );
  }
}

class CityListCubit extends Cubit<CityListState> {
  CityListCubit() : super(CityListLoading());

  fetchCityList() async {
    print("FACCIO LA FETCH DELLE CITY");
    emit(CityListLoading());
    try {
      var result = await UserRepository().cityList();
      print("CI ARRIVOOOO");
      emit(CityListLoaded(result));
      print("RESULT");
    } catch (e) {
      print("ERRORE CITTà");
      print(e);
      emit(CityListError());
    }
  }
}
