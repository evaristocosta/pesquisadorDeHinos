import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'não definida',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  _acessarPlayStore() async {
    final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.trabalhosgerais.pesquisadorhinos');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível acessar a loja';
    }
  }

  _acessarPagina() async {
    final Uri url =
        Uri.parse('https://evaristocosta.github.io/pesquisadorDeHinos/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o site';
    }
  }

  _acessarRepositorio() async {
    final Uri url =
        Uri.parse('https://github.com/evaristocosta/pesquisadorDeHinos');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir o repositório';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text('Sobre',
              style: TextStyle(color: Colors.white, fontFamily: 'Raleway')),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                        width: 180,
                        child: Image(
                          image: AssetImage('assets/images/logo.png'),
                        )),
                  ),
                  Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: 160,
                        child: Image(
                          image: AssetImage('assets/images/marca.png'),
                        )),
                  ),
                  Center(
                    child: Text(
                      'Versão ' + _packageInfo.version,
                      style: TextStyle(
                          fontFamily: 'Oxanium', fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Descricao',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Raleway',
                            )),
                        Html(data: """
                        <p>
                          O aplicativo Pesquisador de Hinos ou "Qual é o hino?" vêm como proposta para a
                          solução de um problema recorrente que é a dificuldade de encontrar determinados hinos
                          cantados nos cultos e eventos da Igreja Cristã Maranata a partir do número atualizado 
                          nos hinários, nome ou partes da letra.
                          <br />
                          Esse aplicativo é distribuido como sendo de código livre e aberto, e licenciado sob 
                          a GNU General Public License v3.0.
                        </p>
                        """)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Links',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _acessarPlayStore,
                            child: Text(
                              'Avalie na Play Store',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _acessarPagina,
                            child: Text(
                              'Página explicativa',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: _acessarRepositorio,
                            child: Text(
                              'Repositório do código-fonte',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Direitos de Imagem',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        Html(data: """
                        <ul>
                          <li>Smashicons</li>
                          <li>Those Icons</li>
                        </ul>
                        """)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
