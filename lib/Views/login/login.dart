import 'package:flutter/material.dart';

import '../../config/database.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: createForm(
              context)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Form createForm(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              'Mon ecurie',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
            ),
          ]),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir un email';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mot de passe',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un mot de passe';
                }
                return null;
              },
            ),
          ),
          Container(
            height: 80,
            width: 4000,
            padding: const EdgeInsets.all(20),
            //Bouton Connexion
            child: ElevatedButton(
              //Au clique ...
              onPressed: () async {
                //... Si le formulaire est rempli ...
                if (formKey.currentState!.validate()) {
                  //... on appel la fonction getUserLogin
                  var result = await MongoDatabase.getUserLogin(
                      emailController.text, passwordController.text);
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connecté')),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Email ou mot de passe incorrect')),
                    );
                  }
                }
              },
              child: const Text('Connexion'),
            ),
          ),
          //Button mot de passe oublié
          TextButton(
            onPressed: () {},
            child: const Text('Mot de passe oublié'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'registerPage');
            },
            child: const Text('S\'inscrire'),
          )
        ],
      ),
    );
  }
}
