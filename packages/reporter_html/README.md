# Reporter HTML plugin
![Pub Version](https://img.shields.io/pub/v/reporter_html)
![GitHub last commit on main](https://img.shields.io/github/last-commit/Bdaya-Dev/reporter/main)



An addon for the `reporter` package to support html.

## Usage

check the [full example](example/reporter_html_example.dart) to generate the following html table:

<table>
    <tr>
        <th rowspan="3">Client</th>
        <th colspan="4">Payments</th>
    </tr>
    <tr>
        <th rowspan='2'>Reason</th>
        <th rowspan='2'>Total To Pay</th>
        <th colspan='2'>Instances</th>
    </tr>
    <tr>
        <th>Date</th>
        <th>Amount</th>
    </tr>
    <tr>
        <td rowspan="6">Person1</td>
        <td rowspan="3">Project1</td>
        <td rowspan="3">5000</td>
        <td>01-08-2023</td>
        <td>2000</td>
    </tr>
    <tr>
        <td>15-08-2023</td>
        <td>1500</td>
    </tr>
    <tr>
        <td>30-08-2023</td>
        <td>1500</td>
    </tr>
    <tr>
        <td>Project2</td>
        <td>1000</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td rowspan="2">Project3</td>
        <td rowspan="2">4000</td>
        <td>01-08-2023</td>
        <td>1000</td>
    </tr>
    <tr>
        <td>15-08-2023</td>
        <td>2000</td>
    </tr>
    <tr>
        <td rowspan="1">Person2</td>
        <td rowspan="1">Project4</td>
        <td rowspan="1">0</td>
    </tr>
</table>
