window.App = Ember.Application.create();

App.ApplicationController = Ember.Controller.extend({});

UserDecorator = EmberEasyDecorator.extend({
  firstName:  EED.element('input', {section: 'info', priority: 1}, {placeholder: 'First Name'}),
  profession: EED.element('select', {section: 'work'}, {prompt: 'Choose one'}),
  works:      EED.element('nested_attributes', {templateName: 'works', section: 'info'}),
  languages:  EED.element('checkboxCollection', {collectionPath:'decorator.languagesCollection', checkActiveMethod: 'languagesIsActive', checkCallback: 'checkLanguage', labelPath: 'labelPath'}, {}),

  professionCollection: function() {
    return ["doctor", "driver", "economist"]
  }.property('model'),

  languagesCollection: function(){
    return ['Ukrainian', 'Spanish', 'German']
  }.property('model'),

  languagesIsActive: function(item){
    return this.get('model.languages').contains(item);
  },


  actions: {
    createWork: function(work){
      this.get('model.works').pushObject({"name": "Anna", "role": 'Admin'});
    },
    checkLanguage: function(item,state){
      if (state)
        this.get('model.languages').pushObject(item);
      else
        this.get('model.languages').removeObject(item);
      console.log(this.get('model.languages'));
    }
  }
});

App.IndexController = Ember.Controller.extend({
  decorator: UserDecorator.create({model: Ember.Object.create({'languages':['Spanish'],'firstName': 'Dina','works': [{"name": "Peter", "role": 'User'}]})})
});

App.Router.map(function() {
  this.route("index", {path: '/'});
});

