import 'dart:io';
import 'package:check_point/core/models/user_model.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AttendancePdf {
  static Future<File> generate({required List<UserModel> users}) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Attendance History'),
              pw.SizedBox(height: 8),
              pw.Text(DateFormat('EEEE, MMMM d HH:mm').format(DateTime.now())),
              pw.SizedBox(height: 24),
              buildTable(users),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();

    final file = File("${dir.path}/attendance.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  static pw.Table buildTable(List<UserModel> users) {
    final headers = ['Name', 'Email'];

    final data =
        users.map((user) {
          return [user.userName, user.email];
        }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: data,
      border: pw.TableBorder.all(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellAlignment: pw.Alignment.centerLeft,
      cellHeight: 30,
    );
  }
}
