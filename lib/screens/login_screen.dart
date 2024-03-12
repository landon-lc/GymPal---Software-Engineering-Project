class LoginScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Login'),
            ),
            body: Center(
                child: Padding(
                    padding: EdgeInserts.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            TextField(
                                decoration: InputDecoration(labelText: 'Login'),
                            ),
                            TextField(
                                decoration: InputDecoration(labelText: 'Password'),
                                obscureText: true,
                            )
                            SizedBox(height: 20),
                            ElevatedButton(
                                onPressed: () {

                                },
                                child: Text('Login'),
                            ),
                        ]
                    )
                )
            )
        )
    }
}