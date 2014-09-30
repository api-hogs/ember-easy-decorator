Ember EasyDecorator
=========

Ember EasyDecorator is a simple decorator that uses [Ember-Forms] [1].

Version
----

0.0.10

Decorator Setup
--------------

To create your decorator, extend from ```EmberEasyDecorator``` and setup elements using **EED.element (*type, options, html*)** function.

```
UserDecorator = EmberEasyDecorator.extend
    firstName:  EED.element('input', {section: 'info', priority: 1}, {placeholder: 'First Name'}),
    lastName:  EED.element('input', {section: 'info'}, {placeholder: 'First Name'}),
    profession: EED.element('select', {section: 'work'}, {prompt: 'Choose one'}),
    company: EED.element('input', {section: 'work'}, {placeholder: 'Company'}),
    works:      EED.element('nested_attributes', {templateName: 'works', section: 'info'}),
    languages:  EED.element('checkboxCollection', {collectionPath:'decorator.languagesCollection', 
                                                   #path to collection of elements to select from
                                                   checkActiveMethod: 'languagesIsActive',
                                                   #name of method that checks if checkbox is active
                                                   checkCallback: 'checkLanguage', labelPath: 'labelPath'}, {}),
                                                   #name of action to be called when checkbox is clicked
            
    professionCollection:(->
      return [{id: "doctor", name: "doctor"}, {id: "driver", name: "driver"}, {id: "economist", name: "economist"}]
    ).property('model')
    
    languagesCollection: (->
      return ['Ukrainian', 'Spanish', 'German']
    }.property('model'),
    
    languagesIsActive: (item) ->
      return this.get('model.languages').contains(item)
    },
    
    actions:
      removeWork: (work) ->
        # create your logic
      createWork: (work) ->
        # create your logic
      checkLanguage: (item,state) ->
        if (state)
          this.get('model.languages').pushObject(item)
        else
          this.get('model.languages').removeObject(item)

```
In your controller:
```
App.UsersController = Ember.Controller.extend({
  decorator: UserDecorator.create({model: Ember.Object.create({'works': [{"name": "testing", "role": 'Manager'}]})})
});
```
Use in template
-------------
There are 2 helpers available: ```{{decorator-input}}``` and ```{{decorator-section}}```.
Pass the property name:
```
{{decorator-input property='firstName'}}
```
You can display all elements that have the same ```section``` property:
```
{{decorator-section property='work'}}
```

For checkbox collection:
```
{{decorator-input property='languages'}}
```

For nested attributes:
```
<script type='text/x-handlebars' data-template-name='works'>
    {{#each work in view.context.model.works}}
        <br>{{work.name}} {{work.role}}
    {{/each}}
</script>
```

Create a form:
```
{{#em-form model=controller.decorator.model}}
    <div id="firstNameInput">{{decorator-input property='firstName'}}</div>
    <div id="infoSection">{{decorator-section property='work'}}</div>
{{/em-form}}
```

License
----

[MIT] [2]

[1]:https://github.com/indexiatech/ember-forms
[2]:http://opensource.org/licenses/mit-license.php
