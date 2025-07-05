import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes/controllers/note.dart';
import 'package:notes/models/hive_user_model.dart';
import 'package:notes/models/note.dart';
import 'package:notes/pages/add_note.dart';
import 'package:notes/pages/note_details.dart';
import 'package:notes/widgets/custom_card.dart';
import 'package:notes/widgets/custom_top_section.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController _noteontroller = NoteController();
    final userBox = Hive.box<HiveUserModel>('userbox');
    final user = userBox.get('user');
    final notes = useState([]);
    final isLoading = useState(true);
    final searchText = useState<String>('');
    useEffect(() {
      Future.microtask(() async {
        final docs = await _noteontroller.getAllNotesByUserId(user!.id);
        if (docs != null) {
          notes.value = docs.reversed.toList();
          isLoading.value = false;
        }
      });
      return null;
    }, []);
    final query = searchText.value.toLowerCase();
    final filteredNotes =
        notes.value.where((note) {
          return note.title.toLowerCase().contains(query);
        }).toList();
    final notesToShow =
        (query.isEmpty || filteredNotes.isEmpty) ? notes.value : filteredNotes;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('ADD NOTE', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddNote()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTopSection(
            name: user!.name,
            onSubmitted: (value) {
              searchText.value = value;
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                        itemCount: notesToShow.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => NoteDetails(
                                          noteId: notesToShow[index].id,
                                        ),
                                  ),
                                );
                              },
                              child: CustomCard(
                                title: "${notesToShow[index].title}",
                                subTitle: "${notesToShow[index].subTitle}",
                                date: notesToShow[index].date,
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
