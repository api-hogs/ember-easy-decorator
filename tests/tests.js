test( "decorator-input of type input is displayed", function() {
  equal($('#firstNameInput').length, 1);
});

test( "decorator-input of type select is displayed", function() {
  equal($('#professionSelect').length, 1);
});

test( "decorator-section is displayed", function() {
  equal($('#infoSection').length, 1);
});

test( "template of element with nested attributes is displayed", function() {
  equal($('#works').length, 1);
});