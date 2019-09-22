import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EMIForm extends StatefulWidget{

  final title;
  const EMIForm({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EMIFormState();

}

class _EMIFormState extends State<EMIForm>{

  String result = "";
  final _totalAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _numOfMonthsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getImage(),
              SizedBox(height: 10.0,),
              getTotalAmtField(),
              SizedBox(height: 10.0,),
              getInterestRateField(),
              SizedBox(height: 10.0,),
              getNumOfMonthsField(),
              SizedBox(height: 10.0,),
              getCalculateButton(),
              SizedBox(height: 10.0,),
              getResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getResult(){
    return Text(
      "$result",
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14.0,
      ),
    );
  }

  Widget getImage() {
    return Image.asset(
      "images/logo.png",
      height: 180.0,
      width: 180.0,
    );
  }

  Widget getTotalAmtField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _totalAmountController,
      decoration: InputDecoration(
        hintText: "e.g. 100000",
        labelText: "Total Loan Amount",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            )
        ),
      ),
      validator: (value) {
        if(value.isEmpty){
          return 'Please enter a valid value';
        }
        return null;
      },
    );
  }

  Widget getInterestRateField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _interestRateController,
      decoration: InputDecoration(
        hintText: "e.g. 10.5",
        labelText: "Interest rate",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            )
        ),
      ),
      validator: (value) {
        if(value.isEmpty){
          return 'Please enter a valid value';
        }
        return null;
      },
    );
  }

  Widget getNumOfMonthsField(){
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _numOfMonthsController,
      decoration: InputDecoration(
        hintText: "e.g. 60",
        labelText: "Total Number of Months",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            )
        ),
      ),
      validator: (value) {
        if(value.isEmpty){
          return 'Please enter a valid value';
        }
        return null;
      },
    );
  }

  Widget getCalculateButton(){
    return RaisedButton(
      child: Text(
        'Calculate',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),

      ),
      color: Colors.blue,
      elevation: 10.0,
      onPressed: _calculateEMI,
    );
  }

  void _calculateEMI(){
    if(_formKey.currentState.validate()){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
              Text(
                "      Processing data...",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 1,),
        )
      );

      double totalAmount = double.parse(_totalAmountController.text);
      double interestRate = double.parse(_interestRateController.text);
      int numOfMonths = int.parse(_numOfMonthsController.text);

      double convertedRateOfInterest = interestRate / (12 * 100);
      double exponent = pow((1 + convertedRateOfInterest), numOfMonths);
      double emi = totalAmount * convertedRateOfInterest * exponent / (exponent -1);
      final res = emi.toStringAsFixed(2);

      setState(() {
        result = "For BDT $totalAmount  and total $numOfMonths installments at an interest rate of $interestRate%, EMI will be BDT $res per month.";
      });

      print(result);
    }
  }
}