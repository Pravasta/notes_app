import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/feature/notes/repository/notes_repository.dart';
import 'package:notes_app/feature/notes/view/notes_view.dart';

import '../logic/add_notes/add_notes_cubit.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key, this.noteId, this.title, this.text});

  final String? noteId;
  final String? title;
  final String? text;

  static const RouteSettings routeSettings = RouteSettings(name: '/add-notes');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AddNotesCubit(NotesRepositoryImpl.create()),
        ),
      ],
      child: NotesView(noteId: noteId, initialTitle: title, initialText: text),
    );
  }
}
