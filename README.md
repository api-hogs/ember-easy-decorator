```
  UserDecorator = EmberEasyDecorator.extend
    firstName:  EED.element('input', html: {placeholder: 'First Name'}, {section: 'info', priority: 1})
    profession: EED.element('select', html: {prompt: 'Choose one'}, {section: 'work'})
    
    professionCollection:(->
      [1,2,3,4,5]
      ### 
        You can implement any logic for select, and you have model in decorator => this.get('model')
        If you want a relation collection add option: => relation: true
      ###
    ).property('model')
```

user_form.hbs:
```
  {{decorator-input 'firstName'}}
```

If you need to input all fields for section you can:
```
  {{decorator-section 'info'}}
```
