import 'package:flutter/material.dart';
import 'package:myagenda/keys/string_key.dart';
import 'package:myagenda/keys/url.dart';
import 'package:myagenda/models/analytics.dart';
import 'package:myagenda/screens/appbar_screen.dart';
import 'package:myagenda/screens/base_state.dart';
import 'package:myagenda/utils/functions.dart';
import 'package:myagenda/widgets/ui/raised_button_colored.dart';

class SupportMeScreen extends StatefulWidget {
  _SupportMeScreenState createState() => _SupportMeScreenState();
}

class _SupportMeScreenState extends BaseState<SupportMeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _unidayTextController = TextEditingController(text: Url.unidays);

  void _openPayPal() {
    _openLink(
      Url.paypal,
      translation(StrKey.SUPPORTME_LINK_ERROR, {'link': "Paypal"}),
      AnalyticsValue.paypal,
    );
  }

  void _openUnidays() {
    _openLink(
      Url.unidays,
      translation(StrKey.SUPPORTME_LINK_ERROR, {'link': "Unidays"}),
      AnalyticsValue.unidays,
    );
  }

  void _openLink(String url, String errorKey, String analyticsEvent) async {
    try {
      await openLink(context, url, analyticsEvent);
    } catch (_) {
      _showSnackBar(translation(errorKey) + url);
    }
  }

  void _showSnackBar(String msg) {
    _scaffoldKey?.currentState?.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return AppbarPage(
      scaffoldKey: _scaffoldKey,
      title: translation(StrKey.SUPPORTME),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Text(
              translation(StrKey.SUPPORTME_TEXT),
              style: theme.textTheme.subhead,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24.0),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                RaisedButtonColored(
                  text: translation(StrKey.SUPPORTME_PAYPAL),
                  onPressed: _openPayPal,
                ),
                RaisedButtonColored(
                  text: translation(StrKey.SUPPORTME_UNIDAYS),
                  onPressed: _openUnidays,
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Text(translation(StrKey.SUPPORTME_UNIDAYS_LINK)),
            TextField(
              controller: _unidayTextController,
              maxLines: null,
              onChanged: (_) {
                // Force input to have always same value
                _unidayTextController.text = Url.unidays;
              },
            )
          ],
        ),
      ),
    );
  }
}
