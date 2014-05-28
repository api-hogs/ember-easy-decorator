test( "decorator-input of type input is displayed", function() {
  ok($('#firstNameInput'));
});

test( "decorator-input of type select is displayed", function() {
  ok($('#professionSelect'));
});

test( "decorator-section is displayed", function() {
  ok($('#infoSection'));
});

test( "template of element with nested attributes is displayed", function() {
  ok($('#works'));
});