import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
   
  "type": "service_account",
  "project_id": "flutter-gsheets-390313",
  "private_key_id": "372b049e033a8304d9e53d23722574751b139104",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCw/gFew6LbcLSJ\nVYhAbgUbgQdDonLkwvmuxNctRGBhioJ6hMWU5UYFKA0OMb7JnF5hJcX8B8y1qhDn\nt0JElZ41xpemEvEFIaPyCGV7dBRMy6fkqkzL0FN/c23V23nuLKeJLF62qu9lg7bJ\nyuAKBVURbIvxkv03u9CGMR1TJDqVY0bgqZmoGn4wVdNWHDKyMVH5XV63sjbdoyEa\nf3lROUKFjs2p/I8ASKEd7p4e7c9K1eOpfd4+XOU9Z5Ngk4czYDE3P7w0oRa916xu\nNJr74/2DSrAKYCJ0AeNsKbgrx4EJr9njvqo8Ri7Clas665lYCkYQvbsgA+RyD50H\nhC1IGILzAgMBAAECggEANoZRqr1vJtYOL/6zBlI+bY4uzDW32mR8YcxPE6lsXbA7\naP4NFkUZcI45k2VcxqRO6POnjfBjLpXRNmkc158WCa//2NAeAvwtkurmRIVqmYvl\n0YprNSCdEHbhX9AIvIhyJk6OcQywyl+syHag1UV2QvNjG00yh+BqqWRpCctv5sQV\n5Esr2QldWIIt1A63JHwvaVH3CvvFgWVhw8iyYDgX7wEtpLvisLvGDnj/CplTd40x\nbQW5DOcCFkimeNgpFndXAjyqTM66n/pwvT6M5X58TRG4vP15jsnPH8boed1RNE5a\nRc9LTC8tA8F3CAS0NL3Elazz7apMy9ck8BQIhkaMEQKBgQDzc/Hrug1ak7s5pIOZ\nbM6yv1J/8fBPfF9H7NrcwKVLXgyGAgrPYv2bqjuKUjcNfZ4yKMYwgDrdDUgDl8OD\nJNA76rtslwmcI/CQ4RWlEQEKLW17npPqBHmUlbu/WxrfwIBTQgDaaeQBfuNZlYRZ\nJNImmhTMEpnJWnq0a6e+TCiCMQKBgQC6HTHpVRdsiQNh59vmnzlmrKuBuNUqKAK0\nG0u2CIejgQo7QZk2XBs6K/Mq4dPZoo3cEPyuef851Q9UBJpOCTF+WsENqwGy7cd5\nls3/eKLbP9OB0pWVE+WVBQCV/17bdALakGahTLgXz5zayQsdt8f4xYpzOcqEgrvL\nUmaSrIxKYwKBgAriWiSB0usDw9EV69RGKw+Owi96L5Y+Jzxd+IL6EenGsKSlHrqa\n4F+/Qp4ygseVoCb577JnaTpMx7VxaYpJcQ3ctrhqIEHc0XqItaEFm5hK46QtOMuz\nm4PrFdO+TPtH7fTK9KLPLSRr+doddydNICAdr2RYSIvaAbZjQcKeQQlhAoGAQaDl\n5sfQuL8f6DhgfNSM4z3kRJwu3uy491XgvtIHMorgVsDtDBQyrbKtzuNPVyFRMNb0\no3n1nCkbfJ8a4oWvZEUQaodw0+2xN5kMDxg1JWc+aDsf8C/R91iKOlqQ0oX4M6ZT\n6nEpQYw+XZAjUVlrNLhD+Bna5htLqYjnDrW1ys0CgYEAg46qKclYbHgHv0Yfq0Bd\nGP7bDzVcQqBOjb40qbSbq9QQ8NbgCWkdCqbBK4UPJag+CsSbQbzTtU+eHzoUkBe6\nCM08QqQbqWfwzezcxg4MH9DYxSObd96t+J72QUFCi2+vjHmkE96Q33wZTwxozaRq\nwUEeJw92LpAd9evxAHsG+58=\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-finance@flutter-gsheets-390313.iam.gserviceaccount.com",
  "client_id": "100662882420588868170",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-finance%40flutter-gsheets-390313.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  
  }
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1TCJeCnNW7rBq_FT2Kbs2UFaACO0gCWJ7lG3iDcsQ240';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
        .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
      await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
      await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
      await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
