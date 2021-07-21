import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wpandflutterconnect/services/ProgressHud.dart';
import 'package:wpandflutterconnect/services/api_service.dart';
import 'package:wpandflutterconnect/utils/form_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        body: ProgressHud(
            child: _loginUiSetup(context),
          isAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
      ),
    );
  }

  Widget _loginUiSetup(BuildContext context){
    return new SingleChildScrollView(
      child: new Container(
        child: new Form(
          key: globalFormKey,
          child: _loginUi(context),
        ),
      ),
    );
  }

  Widget _loginUi(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.redAccent,
                Colors.redAccent,
              ],
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/S_E_Group_logo.png',
                  fit: BoxFit.contain,
                  width: 140,
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 40),
            child: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20,top: 20),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(Icons.verified_user),
            'username',
            'Username',
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return 'Username can\'t be empty';
              }
              return null;
            },
            (onSavedValue){
              _userName = onSavedValue.toString().trim();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(Icons.lock),
            'password',
            'Password',
                (onValidateVal){
                  if(onValidateVal.isEmpty){
                    return 'Password can\'t be empty';
                  }
                  return null;
                },
                (onSavedValue){
              _password = onSavedValue.toString().trim();
                },
            initialValue: '',
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent,
              icon: Icon(
                hidePassword ? Icons.visibility_off: Icons.visibility
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        new Center(
          child: FormHelper.saveButton('Login', () {
              if(validateAndSave()){
                setState(() {
                  this.isApiCallProcess = true;
                });
                APIServices.loginCustomer(_userName, _password).then((response) {
                  setState(() {
                    this.isApiCallProcess = false;
                  });
                  if(response){
                    globalFormKey.currentState!.reset();
                    Navigator.of(context).pushReplacementNamed('/home');
                  }else{
                    FormHelper.showMessage(
                        context,
                        'Wordpess Login',
                        'Invalid Username or Password',
                        'Ok',
                          () => Navigator.of(context).pop(),
                    );
                  }
                });
              }
            }
          ),
        ),
      ],
    );
  }

  bool validateAndSave(){
    final form = globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }
}
