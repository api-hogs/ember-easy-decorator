Ember EasyDecorator
=========

Ember EasyDecorator is a simple decorator that uses [Ember EasyForm] [1].

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
    
    professionCollection:(->
      return ["doctor", "driver", "economist"]
        # You can implement any logic for select, and you have model in decorator => this.get('model')
        # If you want a relation collection add option: => relation: true
    ).property('model')
    
    actions:
      removeWork: (work) ->
        # create your logic
      createWork: (work) ->
        # create your logic

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
{{decorator-input 'firstName'}}
```
You can display all elements that have the same ```section``` property:
```
{{decorator-section 'work'}}
```

For nested attributes:
```
<script type='text/x-handlebars' data-template-name='works'>
    {{#each work in view.context.model.works}}
      {{input work.name label='Name'}}
      {{input work.role label='Role'}}
    {{/each}}
    <button {{action 'createWork' work on='click'}}>Add</button>
</script>
```

Create a form:
```
{{#form-for controller.decorator.model}}
    <div id="firstNameInput">{{decorator-input 'firstName'}}</div>
    <div id="infoSection">{{decorator-section 'work'}}</div>
  {{/form-for}}
```

License
----

[MIT] [2]

[1]:https://github.com/dockyard/ember-easyForm
[2]:http://opensource.org/licenses/mit-license.php
