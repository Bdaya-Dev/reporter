import 'dart:typed_data';

import 'package:_shared/_shared.dart';
import 'package:_shared_addons/_shared_addons.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:reporter_syncfusion_flutter_xlsio/reporter_syncfusion_flutter_xlsio.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

class SfXlsioReportGenerator extends StatefulWidget {
  const SfXlsioReportGenerator({super.key});

  @override
  State<SfXlsioReportGenerator> createState() => _SfXlsioReportGeneratorState();
}

class _SfXlsioReportGeneratorState extends State<SfXlsioReportGenerator> {
  bool mergeCells = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('syncfusion_flutter_xlsio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CheckboxListTile.adaptive(
                value: mergeCells,
                title: const Text("Merge ranges"),
                tristate: false,
                onChanged: (value) {
                  setState(() {
                    mergeCells = value ?? false;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final wb = excel.Workbook();
                  final ws = wb.worksheets[0];
                  final info =
                      TabularReporterSfExcel.assignFullTableFromRowsAndColumns(
                    sheet: ws,
                    columns: myColumns,
                    rows: mapDataToRows(sampleData),
                    sharedConfig: AssignCellsConfig(
                      postAssignValue: mergeCells
                          ? (calculatedRange, range) => range.merge()
                          : null,
                    ),
                    offsetRows: 2,
                    offsetColumns: 3,
                  );
                  if (!mergeCells) {
                    //generate a table
                    final table = ws.tableCollection.create(
                      'data',
                      ws.getRangeByIndex(
                        info.dataRange.row - 1,
                        info.dataRange.column,
                        info.dataRange.lastRow,
                        info.dataRange.lastColumn,
                      ),
                    );
                    table.showHeaderRow = true;
                  }

                  List<int> bytes = wb.saveAsStream();
                  final location = await FileSaver.instance.saveFile(
                    name: 'tabular_report',
                    ext: 'xlsx',
                    mimeType: MimeType.microsoftExcel,
                    bytes: Uint8List.fromList(bytes),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('saved! $location'),
                      ),
                    );
                  }
                },
                child: const Text('generate excel and save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
