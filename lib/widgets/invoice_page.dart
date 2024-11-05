import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:invoice_formatter/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePage extends StatelessWidget {
  final Invoice invoice;

  const InvoicePage({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice ${invoice.invoiceNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${invoice.customerName}',
                style: const TextStyle(fontSize: 18)),
            Text('Date: ${invoice.date.toLocal()}'.split(' ')[0],
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: invoice.items.length,
                itemBuilder: (context, index) {
                  final item = invoice.items[index];
                  return ListTile(
                    title: Text(item.description),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('\$${item.total.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Text('Tax: \$${invoice.tax.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18)),
            Text('Total: \$${invoice.total.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            if (invoice.notes != null)
              Text('Notes: ${invoice.notes}',
                  style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data:
                  'Invoice Number: ${invoice.invoiceNumber}\nCustomer: ${invoice.customerName}\nTotal: \$${invoice.total.toStringAsFixed(2)}',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _generatePdf(context),
              child: const Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => _buildTemplate(context),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget _buildTemplate(pw.Context context) {
    switch (invoice.template) {
      case 'detailed':
        return _buildDetailedTemplate(
          context,
        );
      case 'branded':
        return _buildBrandedTemplate(context);
      case 'simple':
      default:
        return _buildSimpleTemplate(context);
    }
  }

  pw.Widget _buildSimpleTemplate(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice ${invoice.invoiceNumber}',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text('Customer: ${invoice.customerName}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Date: ${invoice.date.toLocal()}'.split(' ')[0],
            style: const pw.TextStyle(fontSize: 18)),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          context: context,
          data: <List<String>>[
            <String>['Description', 'Quantity', 'Unit Price', 'Total'],
            ...invoice.items.map((item) => [
                  item.description,
                  item.quantity.toString(),
                  '\$${item.unitPrice.toStringAsFixed(2)}',
                  '\$${item.total.toStringAsFixed(2)}',
                ]),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Text('Tax: \$${invoice.tax.toStringAsFixed(2)}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Total: \$${invoice.total.toStringAsFixed(2)}',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        if (invoice.notes != null) pw.SizedBox(height: 20),
        if (invoice.notes != null)
          pw.Text('Notes: ${invoice.notes}',
              style: const pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 20),
        pw.BarcodeWidget(
          barcode: pw.Barcode.qrCode(),
          data:
              'Invoice Number: ${invoice.invoiceNumber}\nCustomer: ${invoice.customerName}\nTotal: \$${invoice.total.toStringAsFixed(2)}',
          width: 100,
          height: 100,
        ),
      ],
    );
  }

  pw.Widget _buildDetailedTemplate(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Invoice ${invoice.invoiceNumber}',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text('Customer: ${invoice.customerName}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Date: ${invoice.date.toLocal()}'.split(' ')[0],
            style: const pw.TextStyle(fontSize: 18)),
        pw.SizedBox(height: 20),
        pw.Text('Items:',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.TableHelper.fromTextArray(
          context: context,
          data: <List<String>>[
            <String>['Description', 'Quantity', 'Unit Price', 'Total'],
            ...invoice.items.map((item) => [
                  item.description,
                  item.quantity.toString(),
                  '\$${item.unitPrice.toStringAsFixed(2)}',
                  '\$${item.total.toStringAsFixed(2)}',
                ]),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Text('Tax: \$${invoice.tax.toStringAsFixed(2)}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Total: \$${invoice.total.toStringAsFixed(2)}',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        if (invoice.notes != null) pw.SizedBox(height: 20),
        if (invoice.notes != null)
          pw.Text('Notes: ${invoice.notes}',
              style: const pw.TextStyle(fontSize: 16)),
      ],
    );
  }

  pw.Widget _buildBrandedTemplate(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Company Logo',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
        pw.Text('Invoice ${invoice.invoiceNumber}',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.Text('Customer: ${invoice.customerName}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Date: ${invoice.date.toLocal()}'.split(' ')[0],
            style: const pw.TextStyle(fontSize: 18)),
        pw.SizedBox(height: 20),
        pw.TableHelper.fromTextArray(
          context: context,
          data: <List<String>>[
            <String>['Description', 'Quantity', 'Unit Price', 'Total'],
            ...invoice.items.map((item) => [
                  item.description,
                  item.quantity.toString(),
                  '\$${item.unitPrice.toStringAsFixed(2)}',
                  '\$${item.total.toStringAsFixed(2)}',
                ]),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Text('Tax: \$${invoice.tax.toStringAsFixed(2)}',
            style: const pw.TextStyle(fontSize: 18)),
        pw.Text('Total: \$${invoice.total.toStringAsFixed(2)}',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        if (invoice.notes != null) pw.SizedBox(height: 20),
        if (invoice.notes != null)
          pw.Text('Notes: ${invoice.notes}',
              style: const pw.TextStyle(fontSize: 16)),
        pw.SizedBox(height: 20),
        pw.BarcodeWidget(
          barcode: pw.Barcode.qrCode(),
          data:
              'Invoice Number: ${invoice.invoiceNumber}\nCustomer: ${invoice.customerName}\nTotal: \$${invoice.total.toStringAsFixed(2)}',
          width: 100,
          height: 100,
        ),
      ],
    );
  }
}
