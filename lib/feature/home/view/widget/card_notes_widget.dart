import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/app_top_snackbar.dart';
import 'package:notes_app/core/extensions/build_context_ext.dart';
import 'package:notes_app/core/repositories/notes_model.dart';
import 'package:notes_app/feature/notes/logic/delete_notes/delete_notes_cubit.dart';

import '../../../../main.dart';
import '../../logic/get_all_notes/get_all_notes_cubit.dart';

class CardNotesWidget extends StatelessWidget {
  const CardNotesWidget({super.key, required this.noteItem});

  final NotesModel noteItem;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xffefe9f7),
      Color(0xffffffff),
      Color(0xfff7f6d4),
      Color(0xfffdebab),
    ];

    final randomColor = Random().nextInt(colors.length);

    return Container(
      decoration: BoxDecoration(
        color: colors[randomColor],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noteItem.title,
                    style: appTextTheme(
                      context,
                    ).bodySmall!.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      noteItem.text,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: appTextTheme(context).labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocListener<DeleteNotesCubit, DeleteNotesState>(
            listener: (context, state) {
              if (state.status == DeleteNotesStatus.success) {
                context.read<GetAllNotesCubit>().getAllNotes();
                AppTopSnackBar(context).showSuccess(state.message);
              }

              if (state.status == DeleteNotesStatus.error) {
                AppTopSnackBar(context).showDanger(state.message);
              }
            },
            child: GestureDetector(
              onTap: () {
                context.read<DeleteNotesCubit>().deleteNotes(noteItem.id);
              },
              child: Container(
                padding: EdgeInsets.all(7),
                width: context.deviceWidth,
                decoration: BoxDecoration(
                  color: appColorScheme(context).error,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: appTextTheme(context).labelLarge!.copyWith(
                    color: appColorScheme(context).onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
