import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/extensions/build_context_ext.dart';
import 'package:notes_app/core/routes/navigation.dart';
import 'package:notes_app/core/utils/app_assets.dart';
import 'package:notes_app/feature/notes/view/notes_page.dart';
import 'package:notes_app/feature/home/logic/get_all_notes/get_all_notes_cubit.dart';
import 'package:notes_app/main.dart';

import '../../../core/repositories/notes_model.dart';
import 'widget/card_notes_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const RouteSettings routeSettings = RouteSettings(name: '/home');

  @override
  Widget build(BuildContext context) {
    Widget emptyContent() {
      return Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('${AppAssets.imagesPath}empty.png', scale: 3.5),
          Text('Empty notes', style: appTextTheme(context).displayMedium),
          Text(
            'Once you create notes, it will appear here\nSo, let\'s create one now!',
            style: appTextTheme(context).titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget header(int notesLength) {
      return Container(
        padding: EdgeInsets.all(20),
        width: context.deviceWidth,
        height: context.deviceHeight * 1 / 5,
        color: appColorScheme(context).primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amazing Journey!',
              style: appTextTheme(context).headlineMedium!.copyWith(
                color: appColorScheme(context).onPrimary,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'You have $notesLength notes in your journey\nLet\'s create again!',
              style: appTextTheme(
                context,
              ).titleSmall!.copyWith(color: appColorScheme(context).onPrimary),
            ),
          ],
        ),
      );
    }

    Widget content(List<NotesModel> data) {
      return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          physics: AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final noteItem = data[index];
            return GestureDetector(
              onTap: () {
                Navigation.push(
                  NotesPage(
                    noteId: noteItem.id,
                    title: noteItem.title,
                    text: noteItem.text,
                  ),
                  NotesPage.routeSettings,
                );
              },
              child: CardNotesWidget(noteItem: noteItem),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<GetAllNotesCubit, GetAllNotesState>(
        builder: (context, state) {
          if (state.status == GetAllNotesStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.status == GetAllNotesStatus.error) {
            return Center(child: Text(state.message));
          }

          if (state.status == GetAllNotesStatus.success) {
            final data = state.notes;

            if (state.notes.isNotEmpty) {
              return Column(children: [header(data.length), content(data)]);
            } else {
              return Center(child: emptyContent());
            }
          }

          return Center(child: emptyContent());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigation.push(NotesPage(), NotesPage.routeSettings);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
