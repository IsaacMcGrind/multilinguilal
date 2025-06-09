import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multilinguilal/l10n/blocs/language/language_event.dart';
import 'package:multilinguilal/l10n/blocs/language/language_state.dart';
import 'package:multilinguilal/l10n/data/repositories/language_repository.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository repository;

  LanguageBloc({required this.repository}) : super(LanguageInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  Future<void> _onLoadLanguage(LoadLanguage event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    try {
      final languageCode = await repository.getLanguagePreference();
      emit(LanguageLoaded(languageCode));
    } catch (e) {
      emit(LanguageError(e.toString()));
    }
  }

  Future<void> _onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    emit(LanguageLoading());
    try {
      await repository.saveLanguagePreference(event.languageCode);
      emit(LanguageLoaded(event.languageCode));
    } catch (e) {
      emit(LanguageError(e.toString()));
    }
  }
}