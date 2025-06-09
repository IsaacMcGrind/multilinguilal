import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multilinguilal/blocs/language/language_event.dart';
import 'package:multilinguilal/blocs/language/language_state.dart';
import 'package:multilinguilal/blocs/language/languate_bloc.dart';
import 'package:multilinguilal/data/models/language.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    testWriteToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(s.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(s.greeting, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: context.select((LanguageBloc bloc) =>
                  bloc.state is LanguageLoaded
                      ? (bloc.state as LanguageLoaded).languageCode
                      : 'en'),
              items: supportedLanguages.map((Language language) {
                return DropdownMenuItem<String>(
                  value: language.code,
                  child: Text(language.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  context.read<LanguageBloc>().add(ChangeLanguage(newValue));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void testWriteToFirestore() async {
    await FirebaseFirestore.instance.collection('settings').doc('test').set({
      'status': 'working',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

