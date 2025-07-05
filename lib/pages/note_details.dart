import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/controllers/note.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/edit_note.dart';
import 'package:notes/pages/home.dart';
import 'package:intl/intl.dart';

class NoteDetails extends HookWidget {
  final String noteId;
  const NoteDetails({required this.noteId, super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController _noteController = NoteController();
    final note = useState<NoteModel?>(null);
    final isLoading = useState(true);
    useEffect(() {
      Future.microtask(() async {
        final doc = await _noteController.getNoteById(noteId);
        if (doc != null) {
          note.value = doc;
          isLoading.value = false;
        }
      });
      return null;
    }, []);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditNote(noteId: noteId),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final deletedNote = await _noteController.deleteNoteById(noteId);
              if (deletedNote != null) {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Home()));
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.value?.title ?? "",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.value?.date != null
                          ? DateFormat('yyyy-MM-dd').format(note.value!.date)
                          : '',
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.value?.subTitle ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(note.value?.description ?? ""),
                    ),
                  ],
                ),
      ),
    );
  }
}
