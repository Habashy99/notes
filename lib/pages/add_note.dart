import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:notes/controllers/note.dart';
import 'package:notes/models/hive_user_model.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/widgets/custom_button.dart';
import 'package:notes/widgets/custom_text_input.dart';

class AddNote extends HookWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController _noteController = NoteController();
    final userBox = Hive.box<HiveUserModel>('userbox');
    final user = userBox.get('user');
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final titleController = useTextEditingController(text: "");
    final subTitleController = useTextEditingController(text: "");
    final descriptionController = useTextEditingController(text: "");
    final date = useState<DateTime?>(null);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    text: "TITLE",
                    controller: titleController,
                    validator:
                        (value) => value!.isEmpty ? "Missing title" : null,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    text: "Sub TITLE",
                    controller: subTitleController,
                    validator:
                        (value) => value!.isEmpty ? "Missing Sub TITLE" : null,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    text: "Date",
                    onPress: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        date.value = pickedDate;
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    minLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty ? "Missing Description" : null,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    text: "Save",
                    onPress: () async {
                      final createdNote = await _noteController.createNote(
                        titleController.text,
                        subTitleController.text,
                        date.value?.toIso8601String(),
                        descriptionController.text,
                        user?.id,
                      );
                      if (createdNote != null) {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => Home()));
                      }
                      ;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
