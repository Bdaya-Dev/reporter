# Reporter
[![Pub Version](https://img.shields.io/pub/v/reporter)](https://pub.dev/packages/reporter)
[![GitHub last commit on main](https://img.shields.io/github/last-commit/Bdaya-Dev/reporter/main)](https://github.com/Bdaya-Dev/reporter/tree/main/packages/reporter)

A standard for generating reports in pure dart.
> Note: Currently only supports tabular reports.

## Features

* Build tabular reports with ease.
* Handles column nesting (colspan).
* Handles row nesting (rowspan).
* Full customizable.
* Language independent, can be adapted for Excel, Html, Pdf, Markdown, txt, etc ...
* Surprisingly easy to use.

## Getting started

1. Depend on the `reporter` package `dart pub add reporter`
2. Optionally depend on other specific generators like `reporter_html`, `reporter_syncfusion_flutter_xlsio`, etc...
3. Use `TabularReporter.calculateCells` to calculate the body cells from rows and columns.
4. Use `TabularReporter.calculateHeaderCells` to calculate the header cells from columns.