import 'package:dio/dio.dart';
import 'package:notes/models/note.dart';

abstract interface class INote {
  createNote(
    String title,
    String subTitle,
    String date,
    String description,
    String userId,
  );
  getAllNotesByUserId(String userId);
  getNoteById(String id);
  deleteNoteById(String id);
  editNoteById(
    String id,
    String title,
    String subTitle,
    String description,
    String? date,
  );
}

class NoteController implements INote {
  @override
  createNote(
    String title,
    String subTitle,
    String? date,
    String description,
    String? userId,
  ) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/notes/add',
      data: {
        "userId": userId,
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "date": date,
      },
    );
    final data = response.data["note"];
    if (data == null) throw Exception("notes not found in response");
    final note = NoteModel.fromJson(data);
    return note;
  }

  @override
  getAllNotesByUserId(String userId) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/notes/get',
      data: {"userId": userId},
    );
    final data = response.data["notes"];
    if (data == null) throw Exception("notes not found in response");
    final notes =
        (data as List).map((note) => NoteModel.fromJson(note)).toList();
    return notes;
  }

  @override
  getNoteById(String id) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/notes/getById',
      data: {"noteId": id},
    );
    final data = response.data["note"];
    if (data == null) throw Exception("notes not found in response");
    final note = NoteModel.fromJson(data);
    return note;
  }

  @override
  deleteNoteById(String id) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/notes/deleteById',
      data: {"noteId": id},
    );
    final data = response.data["note"];
    if (data == null) throw Exception("notes not found in response");
    final note = NoteModel.fromJson(data);
    return note;
  }

  @override
  editNoteById(
    String id,
    String title,
    String subTitle,
    String description,
    String? date,
  ) async {
    final dio = Dio();
    final response = await dio.post(
      'http://192.168.1.12:8050/notes/editById',
      data: {
        "noteId": id,
        "title": title,
        "subTitle": subTitle,
        "description": description,
        "date": date,
      },
    );
    final data = response.data["note"];
    if (data == null) throw Exception("notes not found in response");
    final note = NoteModel.fromJson(data);
    return note;
  }
}
