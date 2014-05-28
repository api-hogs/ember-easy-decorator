window.App = Ember.Application.create();

App.ApplicationController = Ember.Controller.extend({});

UserDecorator = EmberEasyDecorator.extend({
  firstName:  EED.element('input', {section: 'info', priority: 1}, {placeholder: 'First Name'}),
  profession: EED.element('select', {section: 'work'}, {prompt: 'Choose one'}),
  works:      EED.element('nested_attributes', {templateName: 'works', section: 'info'}),

  professionCollection: function() {
    return ["doctor", "driver", "economist"]
  }.property('model'),

  actions: {
    createWork: function(work){
      this.get('model.works').pushObject({"name": "Anna", "role": 'Admin'});
    }
  }
});

App.IndexController = Ember.Controller.extend({
  decorator: UserDecorator.create({model: Ember.Object.create({'firstName': 'Dina','works': [{"name": "Peter", "role": 'User'}]})})
});

App.Router.map(function() {
  this.route("index", {path: '/'});
});

