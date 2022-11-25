import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Users/userModel.dart';

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
  TextEditingController pseudoController = TextEditingController();
  TextEditingController emailNewPwdController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var logged;

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

  //Formulaire de connexion
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
                  await MongoDatabase.getUserLogin(
                          emailController.text, passwordController.text)
                      .then((result) {
                    setState(() {
                      logged = result;
                    });
                  });

                  if (logged != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connect')),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, 'Navigator', arguments: logged)
                        .then((_) => setState(() {}));
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
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Changer de mot de passe'),
                  actions: <Widget>[changePassword(context)],
                ),
              );
            },
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

  //Formulaire pour changer de mot de passe
  Form changePassword(BuildContext context) {
    GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
    return Form(
      key: formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: pseudoController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Pseudo',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre pseudo';
              }
              return null;
            },
          ),
          TextFormField(
            controller: emailNewPwdController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: newPasswordController,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              labelText: 'Nouveau mot de passe',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre nouveaux mot de passe';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  if (formKey2.currentState!.validate()) {
                    var changed = await MongoDatabase.changePassword(
                            pseudoController.text,
                            emailNewPwdController.text,
                            newPasswordController.text)
                        .then((changed) {
                      setState(() {});
                      if (changed != null) {
                        if (changed == "Mot de passe déja utilisé") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Mot de passe déja utilisé')),
                          );
                        } else {
                          pseudoController.text = "";
                          emailNewPwdController.text = "";
                          newPasswordController.text = "";
                          Navigator.pop(context, 'Modifier');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Mot de passe modifié')),
                          );
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Email ou mot de passe incorrect')),
                        );
                      }
                    });
                  }
                },
                child: const Text('Modifier'),
                //),
              ),
              TextButton(
                onPressed: () {},
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'Annuler');
                  },
                  child: const Text('Annuler'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
