import 'dart:convert';
import 'dart:typed_data';

import 'package:_shared/_shared.dart';
import 'package:_shared_addons/_shared_addons.dart';
import 'package:file_saver/file_saver.dart';

import 'package:flutter/material.dart';
import 'package:html/dom.dart' as html;
import 'package:reporter_html/reporter_html.dart';

class HtmlReportGenerator extends StatefulWidget {
  const HtmlReportGenerator({super.key});

  @override
  State<HtmlReportGenerator> createState() => _HtmlReportGeneratorState();
}

class _HtmlReportGeneratorState extends State<HtmlReportGenerator> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('html'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final htmlElement =
                      TabularReporterHtml.generateFullTableFromRowsAndColumns(
                    columns: myColumns,
                    rows: mapDataToRows(sampleData),
                    // config: const ReporterHtmlConfig(),
                  );
                  final finalHtmlElement = html.Element.tag('html')
                    ..append(
                      html.Element.tag('head')
                        ..append(
                          html.Element.html(
                            r'''<style>table, tr, th, td { border: 1px solid black; }</style>''',
                          ),
                        ),
                    )
                    ..append(
                      html.Element.tag('body')..append(htmlElement),
                    );
                  textController.text = finalHtmlElement.outerHtml;
                },
                child: const Text('generate html'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: textController,
                maxLines: null,
                readOnly: false,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final location = await FileSaver.instance.saveFile(
                    name: 'tabular_report',
                    ext: 'html',
                    mimeType: MimeType.custom,
                    customMimeType: 'text/html',
                    bytes: Uint8List.fromList(utf8.encode(textController.text)),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('saved! $location'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
