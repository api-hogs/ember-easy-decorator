```
  UserDecorator = EmberEasyDecorator.extend
    firstName:  EED.element('input', {section: 'info', priority: 1}, {placeholder: 'First Name'})
    profession: EED.element('select', {section: 'work'}, {prompt: 'Choose one'})
    works:      EED.element('nested_attributes', templateName: 'share/user-works', section: 'info')
    
    professionCollection:(->
      [1,2,3,4,5]
      ### 
        You can implement any logic for select, and you have model in decorator => this.get('model')
        If you want a relation collection add option: => relation: true
      ###
    ).property('model')
    
    actions:
      removeWork: (work) ->
        #create your logic
      createWork: (work) ->
        #create your logic
      
```

user_form.hbs:
```
  {{decorator-input 'firstName'}}
```

If you need to input all fields for section you can:
```
  {{decorator-section 'info'}}
```
For nested attributes: share/user-works.hbs
```
  {{#each work in view.context.model.works}}
    {{input work.name label='Name'}}
    {{input work.role label='Role'}}
    <button class=".btn" {{action 'removeWork' work on='click'}}>Remove</button>
{{/each}}
<button class=".btn" {{action 'createWork' on='click'}}>Add</button>
```
