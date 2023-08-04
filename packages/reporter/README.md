# Reporter
[![Pub Version](https://img.shields.io/pub/v/reporter)](https://pub.dev/packages/reporter)
[![GitHub last commit on main](https://img.shields.io/github/last-commit/Bdaya-Dev/reporter/main)](https://github.com/Bdaya-Dev/reporter/tree/main/packages/reporter)

A standard for generating reports in pure dart.
> Note: Currently only supports tabular reports.

## Example

Check the dedicated [example project](../example)

## Features

* Build tabular reports with ease.
* Handles column nesting (colspan).
* Handles row nesting (rowspan).
* Full customizable.
* Language independent, can be adapted for Excel, Html, Pdf, Markdown, txt, etc ...
* Surprisingly easy to use.

## Getting started

1. Depend on the `reporter` package `dart pub add reporter`
2. Use `TabularReporter.calculateHeaderCells` to calculate the header cells from columns.
3. Use `TabularReporter.calculateCells` to calculate the body cells from rows and columns.
4. Optionally depend on other specific generators like `reporter_html`, `reporter_syncfusion_flutter_xlsio`, etc...

## Preview

<div>
    <style>
        table,
        tr,
        th,
        td {
            border: 1px solid black;
        }
    </style>
    <table>
        <thead>
            <tr>
                <th rowspan="3" colspan="1">Client</th>
                <th rowspan="1" colspan="4">payments</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="1">reason</th>
                <th rowspan="2" colspan="1">total to pay</th>
                <th rowspan="1" colspan="2">instances</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">date</th>
                <th rowspan="1" colspan="1">amount</th>
            </tr>
        </thead>
        <thead>
            <tr>
                <th rowspan="6" colspan="1">person1</th>
                <th rowspan="3" colspan="1">project1</th>
                <th rowspan="3" colspan="1">5000.0</th>
                <th rowspan="1" colspan="1">2023-08-01 00:00:00.000</th>
                <th rowspan="1" colspan="1">2000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-08-15 00:00:00.000</th>
                <th rowspan="1" colspan="1">1500.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-08-30 00:00:00.000</th>
                <th rowspan="1" colspan="1">1500.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">project2</th>
                <th rowspan="1" colspan="1">1000.0</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="1">project3</th>
                <th rowspan="2" colspan="1">4000.0</th>
                <th rowspan="1" colspan="1">2023-09-01 00:00:00.000</th>
                <th rowspan="1" colspan="1">1000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">2023-09-15 00:00:00.000</th>
                <th rowspan="1" colspan="1">2000.0</th>
            </tr>
            <tr>
                <th rowspan="1" colspan="1">person2</th>
                <th rowspan="1" colspan="1">project4</th>
                <th rowspan="1" colspan="1">0.0</th>
            </tr>
        </thead>
    </table>
</div>