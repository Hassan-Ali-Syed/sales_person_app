import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ContinuousScanner extends StatefulWidget {
  const ContinuousScanner({super.key});

  @override
  ContinuousScannerState createState() => ContinuousScannerState();
}

class ContinuousScannerState extends State<ContinuousScanner> {
  MobileScannerController controller = MobileScannerController();
  String lastScannedCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Continuous Scanner')),
      body: Column(
        children: [
          // Scanner View with controlled height and width
          SizedBox(
            height: 300, // Adjust the height as needed
            width: double.infinity, // Full width or adjust as needed
            child: MobileScanner(
                controller: controller, onDetect: (BarcodeCapture barcode) {}
                //  (BarcodeCapture barcode, _) { // Nullable argument type
                //   final String? code = barcode.rawValue;
                //   if (code != null && code != lastScannedCode) {
                //     setState(() {
                //       lastScannedCode = code;
                //     });
                //   }
                // },
                ),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Scanned Item Details will appear here"),
          ),
        ],
      ),
    );
  }
}
