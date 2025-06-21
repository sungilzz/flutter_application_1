import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  final String initialCountry;
  final void Function(String countryCode, Locale locale)? onChanged;

  const CountryDropdown({Key? key, this.initialCountry = 'US', this.onChanged})
    : super(key: key);

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  late String _selectedCountry;
  final Map<String, String> _countryLocales = {
    'US': 'en',
    'KR': 'ko',
    'FR': 'fr',
    'DE': 'de',
    'JP': 'ja',
  };

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.language, size: 20),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: _selectedCountry,
          items: _countryLocales.keys.map((country) {
            return DropdownMenuItem<String>(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (value) async {
            if (value != null) {
              setState(() {
                _selectedCountry = value;
              });
              Locale newLocale = Locale(_countryLocales[value]!);
              if (widget.onChanged != null) {
                widget.onChanged!(value, newLocale);
              }
            }
          },
        ),
      ],
    );
  }
}
