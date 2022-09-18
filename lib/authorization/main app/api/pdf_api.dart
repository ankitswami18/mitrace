import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../business layer/shop bloc/collect payment details/payment_details_input_bloc_model.dart';

class PdfApi {
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future<File> convertAndSavePdf(
    List billRawData,
  ) {
    LaptopApiModel laptopApiModel = billRawData[0];
    PaymentDetailsInputBlocModel? customerDetailsMdl = billRawData[1];

    Document doc = convertWidgetToPdf(laptopApiModel, customerDetailsMdl);
    String fileName = getFileName();
    return saveDocumentToLocalDevice(fileName: fileName, pdfDoc: doc);
  }

  static Document convertWidgetToPdf(
    LaptopApiModel laptopApiModel,
    PaymentDetailsInputBlocModel? customerDetailsMdl,
  ) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Center(
          // USE THE RAW DATA TO CREATE A PDF.
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  // color: PdfColor.fromHex('#011328'),
                  child: pw.Text(
                    'MI-BILL',
                    style: const pw.TextStyle(
                      // color: PdfColor.fromRYB(242, 242, 242),
                      fontSize: 50,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(18),
                  child: pw.Container(
                    // color: PdfColor.fromHex('#011328'),
                    child: pw.Text(
                      laptopApiModel.id,
                      // style: pw.TextStyle(
                      //   color: PdfColor.fromRYB(0, 0, 0),
                      //   fontSize: 50,
                      // ),
                    ),
                  ),
                ),
                pw.Container(
                  // color: PdfColor.fromHex('#011328'),
                  child: pw.Text(
                    'Description: ${laptopApiModel.description}',
                    // style: pw.TextStyle(
                    //   color: PdfColor.fromRYB(0, 0, 0),
                    //   fontSize: 50,
                    // ),
                  ),
                ),
                pw.Container(
                  // color: PdfColor.fromHex('#011328'),
                  child: pw.Text(
                    'More Details: ${laptopApiModel.more}',
                    // style: pw.TextStyle(
                    //   color: PdfColor.fromRYB(0, 0, 0),
                    //   fontSize: 50,
                    // ),
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(30),
                  child: pw.Center(
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'Customer Name: ${customerDetailsMdl!.name}',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'Customer Email: ${customerDetailsMdl.email}',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'Mobile Number: ${customerDetailsMdl.number}',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'Mode of Payment: ${customerDetailsMdl.modeofpayment}',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'M.R.P. ${laptopApiModel.mrp}/-',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                          pw.Container(
                            // color: PdfColor.fromHex('#011328'),
                            child: pw.Text(
                              'Amount Paid: ${laptopApiModel.price}',
                              // style: pw.TextStyle(
                              //   color: PdfColor.fromRYB(0, 0, 0),
                              //   fontSize: 50,
                              // ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ]),
        ),
      ),
    );
    return pdf;
  }

  static Future<File> saveDocumentToLocalDevice({
    required String fileName,
    required pw.Document pdfDoc,
  }) async {
    final bytes = await pdfDoc.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$fileName.pdf");
    await file.writeAsBytes(bytes);
    return file;
  }

  static String getFileName() {
    return DateTime.now().toString();
  }

  displayNetworkImage() async {
    final pdf = pw.Document();
    final netImage = await networkImage('https://www.nfet.net/nfet.jpg');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(netImage),
          );
        },
      ),
    );
  }

  displayImage() async {
    final pdf = pw.Document();
    final imageSvg = await rootBundle.loadString('location');
    final imageJpg = (await rootBundle.load('location')).buffer.asUint8List();
    final pageTheme = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        if (context.pageNumber == 1) {
          return FullPage(
            ignoreMargins: true,
            child: pw.Image(
              pw.MemoryImage(imageJpg),
              fit: pw.BoxFit.cover,
            ),
          );
        } else {
          return pw.Container();
        }
      },
    );
    pdf.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Container(
              height: pageTheme.pageFormat.availableHeight - 1,
              child: pw.Center(
                child: pw.Text(
                  'Foreground widgets',
                  style: const pw.TextStyle(
                    color: PdfColors.white,
                    fontSize: 4,
                  ),
                ),
              ),
            ),
            pw.SvgImage(svg: imageSvg),
            pw.Image(
              pw.MemoryImage(imageJpg),
              width: pageTheme.pageFormat.availableWidth / 2,
            ),
          ];
        },
      ),
    );

    // saveDocumentToLocalDevice(
    //   fileName: '',
    //   pdfDoc: pdf,
    // );
  }
}

// static Future<File> pdfFile(List rawData) async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) => pw.Center(
//         // USE THE RAW DATA TO CREATE A PDF.
//         child: pw.Text('hello world'),
//       ),
//     ),
//   );

//   return saveDocument(fileName: '', pdfDoc: pdf);

//   // TO SAVE THE PDF.
//   // final file = File('example.pdf');
//   // return await file.writeAsBytes(await pdf.save());
// }

// static Future<File> saveDocument({
//   required String fileName,
//   required pw.Document pdfDoc,
// }) async {
//   final bytes = await pdfDoc.save();
//   final dir = await getApplicationDocumentsDirectory();
//   final file = File("${dir.path}/$fileName.pdf");
//   await file.writeAsBytes(bytes);
//   return file;
//   // final output = await getTemporaryDirectory();
//   // final file = File("${output.path}/example.pdf");
//   // final file = File('example.pdf');
//   // return await file.writeAsBytes(await pdfDoc.save());
// }

//  SENT BY ME UI:

// ? HEADER I.E. CONTAINS THE CLOUD MESSAGE WHICH I HAVE TYPED.
// ? DATE AND TIME I.E. WHEN I SENT AND WHEN HE ACCEPTED.
// ? PROFILE IMAGE OF THE RECIVER. I.E. THE PERSON TO WHOM I SENT
// ? MY REVEALED ID.
// ? REPLY/CHATS.

// RECIVED BY ME UI:

// ? HEADER I.E. CONTAINS THE CLOUD MESSAGE WHICH I HAVE RECIEVED.
// ? DATE AND TIME I.E. WHEN HE SENT AND WHEN I ACCEPTED.
// ? ANNONIMUS IMAGE.
// ? ID REVELED BY THE SENDER.
// ? REACTIONS/CHATS.
