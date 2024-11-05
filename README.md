# Invoice Formatter

Invoice Formatter is a Flutter library for generating professional invoices with customizable templates, PDF generation, and QR Code support. It is ideal for developers working on e-commerce or inventory management apps needing a flexible and reusable invoice solution.

## Features

- **PDF Invoice Generation**: Create invoices in PDF format with customizable colors, logos, and layouts.
- **Multiple Templates**: Multiple ready-made templates for different business types, including simple, detailed, and branded invoices.
- **Language Support**: Generate invoices in multiple languages using JSON for easy translations.
- **Invoice Customization**: Add item details, quantities, prices, taxes, and notes, with the ability to customize the layout easily.
- **QR Code Integration**: Add barcodes or QR codes to invoices to simplify scanning and integration with other systems.
- **Widgets for UI**: Ready-to-use widgets for displaying invoices in your Flutter app before generating PDFs.
- **Print and Share**: Print invoices directly from the app or share them via email or messaging apps.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  invoice_formatter:
    git:
      url: https://github.com/username/invoice_formatter.git
```

Or, if published on pub.dev:

```yaml
dependencies:
  invoice_formatter: ^1.0.0
```

Then, run:

```sh
flutter pub get
```

## Usage

Import the package in your Dart file:

```dart
import 'package:invoice_formatter/invoice_formatter.dart';
```

### Example

Here's an example of how to use the library to create an invoice:

```dart
void main() {
  runApp(MaterialApp(
    home: InvoicePage(
      invoice: Invoice(
        customerName: 'John Doe',
        invoiceNumber: 'INV-1001',
        date: DateTime.now(),
        items: [
          InvoiceItem(description: 'Item 1', quantity: 2, unitPrice: 50.0),
          InvoiceItem(description: 'Item 2', quantity: 1, unitPrice: 100.0),
        ],
        tax: 15.0,
        total: 215.0,
        notes: 'Thank you for your business!',
        template: 'branded',
      ),
    ),
  ));
}
```

### Templates

The library provides three ready-made templates:

- **Simple**: A minimalist template with essential details.
- **Detailed**: Includes more information such as payment terms, shipping details, etc.
- **Branded**: Allows adding a company logo and brand colors for a personalized touch.

You can choose the template that fits your needs by specifying the `template` parameter when creating an `Invoice` object.

## Customization

You can easily customize the invoice templates to match your brand:

- **Change colors** and **fonts**.
- **Add or remove fields** such as payment terms or notes.
- **Modify the template layout** to better fit your business requirements.

## QR Code and Barcode Support

The library supports generating QR codes for easy invoice scanning and linking with other systems. You can add a QR code containing invoice details, such as the invoice number and total amount, directly to your PDF.

## Printing and Sharing

The library allows you to print invoices directly from the app using the `Printing` package. Additionally, you can share the generated invoices via email or other messaging apps.

## Dependencies

- `pdf`: For generating PDF documents.
- `printing`: For printing and sharing PDF documents.
- `barcode_widget`: For generating QR codes and barcodes.

## Contributions

Contributions are welcome! Feel free to fork the repository and submit pull requests. Make sure your code is well-tested and documented.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

