import 'dart:math';

final _emailMaskRegExp = RegExp('^(.)(.*?)([^@]?)(?=@[^@]+\$)');

void testMaskEmail() {
  final emails = [
    'a@example.com',
    // output: a****a@example.com
    'ab@example.com',
    // output: a****b@example.com
    'abc@example.com',
    // output: a****c@example.com
    'abcd@example.com',
    // output: a****d@example.com
    'abcde@example.com',
    // output: a****e@example.com
    'abcdef@example.com',
    // output: a****f@example.com
    'abcdefg@example.com',
    // output: a*****g@example.com  <- 5-asterisk-fill
    'Ф@example.com',
    // output: Ф****Ф@example.com
    'ФѰ@example.com',
    // output: Ф****Ѱ@example.com
    'ФѰД@example.com',
    // output: Ф****Д@example.com
    'ФѰДӐӘӔӺ@example.com',
    // output: Ф*****Ӻ@example.com  <- 5-asterisk-fill
    '"a@tricky@one"@example.com',
    // output: "************"@example.com <- multiple @ in a valid email: no problem
  ];

  emails.forEach((email) {
    print("Email: $email - mask: " + maskEmail(email, 4, '*'));
  });
}

String maskEmail(String input, [int minFill = 4, String fillChar = '*']) {
  return input.replaceFirstMapped(_emailMaskRegExp, (m) {
    var start = m.group(1);
    var middle = fillChar * max(minFill, m.group(2)!.length);
    var end = m.groupCount >= 3 ? m.group(3) : start;
    print("START $start");
    print("Middle $middle");
    print("End $end");
    return start! + middle + end!;
  });
}
