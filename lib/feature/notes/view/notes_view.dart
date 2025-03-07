import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/app_button.dart';
import 'package:notes_app/core/components/app_top_snackbar.dart';
import 'package:notes_app/feature/notes/logic/add_notes/add_notes_cubit.dart';
import 'package:notes_app/feature/home/logic/get_all_notes/get_all_notes_cubit.dart';
import 'package:notes_app/feature/notes/logic/delete_notes/delete_notes_cubit.dart';

import '../../../main.dart';

class NotesView extends StatefulWidget {
  const NotesView({
    super.key,
    this.noteId,
    this.initialTitle,
    this.initialText,
  });

  final String? noteId;
  final String? initialTitle;
  final String? initialText;

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _textController;
  late ValueNotifier<bool> _isChanged;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _textController = TextEditingController(text: widget.initialText ?? '');
    _isChanged = ValueNotifier(false);

    _titleController.addListener(_onTextChanged);
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_titleController.text != widget.initialTitle ||
        _textController.text != widget.initialText) {
      _isChanged.value = true;
    } else {
      _isChanged.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _textController.dispose();
    _isChanged.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar() {
      return AppBar(
        title: Text('Back to Home', style: appTextTheme(context).titleMedium),
        actions: [
          widget.noteId != null
              ? BlocListener<DeleteNotesCubit, DeleteNotesState>(
                listener: (context, state) {
                  if (state.status == DeleteNotesStatus.success) {
                    AppTopSnackBar(context).showSuccess(state.message);
                    context.read<GetAllNotesCubit>().getAllNotes();
                    Navigator.pop(context);
                  }

                  if (state.status == DeleteNotesStatus.error) {
                    AppTopSnackBar(context).showDanger(state.message);
                  }
                },
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: appColorScheme(context).error,
                  ),
                  onPressed: () {
                    context.read<DeleteNotesCubit>().deleteNotes(
                      widget.noteId!,
                    );
                  },
                ),
              )
              : const SizedBox.shrink(),
        ],
      );
    }

    Widget titleForm() {
      return TextFormField(
        minLines: 1,
        maxLines: 2,
        controller: _titleController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Title cannot be empty';
          }
          return null;
        },
        style: appTextTheme(context).displayMedium,
        decoration: InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      );
    }

    Widget textForm() {
      return Expanded(
        child: TextFormField(
          style: appTextTheme(context).titleMedium,
          maxLines: null,
          expands: true,
          controller: _textController,
          decoration: InputDecoration(
            hintText: "Write your notes here...",
            border: InputBorder.none,
          ),
        ),
      );
    }

    Widget button() {
      return BlocConsumer<AddNotesCubit, AddNotesState>(
        listener: (context, state) {
          if (state.status == AddNotesStatus.success) {
            AppTopSnackBar(context).showSuccess(state.message);
            context.read<GetAllNotesCubit>().getAllNotes();
            Navigator.pop(context);
          }

          if (state.status == AddNotesStatus.error) {
            AppTopSnackBar(context).showDanger(state.message);
          }
        },
        builder: (context, state) {
          if (state.status == AddNotesStatus.loading) {
            return const CircularProgressIndicator();
          }
          return ValueListenableBuilder(
            valueListenable: _isChanged,
            builder: (context, value, child) {
              return DefaultButton(
                title: widget.noteId != null ? 'Update Notes' : 'Add Notes',
                onTap:
                    value
                        ? () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.noteId != null) {
                              context.read<AddNotesCubit>().updateNotes(
                                widget.noteId!,
                                _titleController.text,
                                _textController.text,
                              );
                            } else {
                              context.read<AddNotesCubit>().addNotes(
                                DateTime.now().microsecondsSinceEpoch
                                    .toString(),
                                _titleController.text,
                                _textController.text,
                              );
                            }
                          }
                        }
                        : () {
                          AppTopSnackBar(
                            context,
                          ).showDanger('You have not made any changes');
                        },
                backgroundColor: appColorScheme(context).primary,
                borderColor: appColorScheme(context).primary,
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [titleForm(), textForm(), button()],
          ),
        ),
      ),
    );
  }
}
