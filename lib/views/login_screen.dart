import 'package:flutter_calcimc_prova2/database/database.dart';
import 'package:flutter_calcimc_prova2/views/calc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcimc_prova2/views/register_screen.dart';
import 'package:flutter_calcimc_prova2/styles/app_styles.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}
class LoginScreenState extends State<LoginScreen>
{
  final keyForm = GlobalKey<FormState>();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final databaseHelper = DatabaseHelper();

  void login() async
  {
    if(keyForm.currentState!.validate())
    {
      final user = await databaseHelper.getUser(emailControl.text);
      if(user != null && user['password'] == passwordControl.text)
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalcIMCScreen(name: user['name']),
          ), 
        );
      }
      else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email e/ou senha incorreto(s)!')),
        );
      }
    }
  }

  void clearFields()
  {
    emailControl.clear();
    passwordControl.clear();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cobra Kai IMC',
          style: AppTextStyles.titleCobraKai,
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: clearFields,
          ),
        ],
      ),
      body:
      Column(
        children: [
          const SizedBox(height: 11),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(AppSpacing.logoLeftPadding, AppSpacing.logoTopPadding, AppSpacing.logoRightPadding, AppSpacing.logoBottomPadding),
              child: Image.asset(
                "assets/images/logo.png",
                width: 250,
                height: 250,
              ),
            ),
          ),
          Expanded(child: 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: emailControl,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value == null || value.isEmpty) 
                        {
                          return 'Digite seu email!';
                        } else if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$')
                            .hasMatch(value)) {
                          return 'Email inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordControl,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if(value == null || value.isEmpty) 
                        {
                          return 'Digite sua senha';
                        } 
                        else if(value.length < 8) 
                        {
                          return 'A senha deve conter pelo menos 8 caracteres, com pelo menos um número e uma letra!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: login,
                      style: AppTextStyles.roundedButton(AppColors.red),
                      child: const Text('Login', style: TextStyle(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()), 
                        );
                      },
                      child: const Text(
                        'Ainda não tem cadastro? Cadastre-se agora!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: AppColors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}