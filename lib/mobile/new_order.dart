import 'package:PharmacyApp/shared/shared.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {

  static const String route = '/route_ProductForm_New_Order';

  const ProductForm({super.key});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
  bool _isLoading = false;
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
    _isLoading = false;
    // Widget x = Scaffold(body:
    //   ,)



    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: commercialNameController,
            decoration: const InputDecoration(
              labelText: 'Commercial Name',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: companyController,
            decoration: InputDecoration(
              labelText: 'Company',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(
              labelText: 'Category',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: isLoading ? null : _submitOrder,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
            child: isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitOrder() {
    // Perform your submission logic here
    // For example, you can navigate to the order cart widget
    setState(() {
      isLoading = true;
    });

    // Simulate a delay for demonstration purposes
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderCartWidget()),
      );
      setState(() {
        isLoading = false;
      });
    });
  }
}

class OrderCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Cart'),
      ),
      body: Center(
        child: Text('Order Cart Content Goes Here'),
      ),
    );
  }
}
