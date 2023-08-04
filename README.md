# Reporter
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

A standard for generating reports in pure dart.

* Check the [example project](packages/example)

## packages

* [reporter](packages/reporter/)
* [reporter_html](packages/reporter_html/)
* [reporter_syncfusion_flutter_xlsio](packages/reporter_syncfusion_flutter_xlsio/)

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