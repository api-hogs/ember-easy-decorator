window.EmberEasyDecorator = Ember.Object.extend Ember.Evented, Ember.ActionHandler,

  init: ->
    this._super()

  ###
    Returns all attributes from decorator
  ###
  attributes: (Ember.computed ->
    Ember.get(this.constructor, 'attributes')
  ).property()

  ###
    delegate all attributes witch include Value as nomaValue to model
  ###
  unknownProperty: (propertyName) ->
    if /Value$/.test(propertyName)
      modelProperty = propertyName.substr(0, propertyName.length - 5)
      return @get('model.%@'.fmt(modelProperty))
    if /SectionFields$/.test(propertyName)
      return @_createSectionComputed(propertyName)

  _createSectionComputed: (propertyName) ->
    section = propertyName.substr(0, propertyName.length - 13)
    fields = @get('attributes').keys.list.filter (key) =>
      @get('attributes').get(key).options.section == section
    fields = fields.map (field) =>
      @get('attributes').get(field)
    fields = @_sort(fields)
    @set(propertyName, fields)
    fields

  _sort: (array, type='asc') ->
    switch type
      when 'asc'
        array.sort (a,b) ->
          a.options.order - b.options.order
      when 'desc'
        array.sort (a,b) ->
          b.options.order - a.options.order

EmberEasyDecorator.reopenClass
  attributes: Ember.computed( ->
    map = Ember.Map.create()
    this.eachComputedProperty( (name, meta) ->
      if meta.isAttribute
        meta.name = name
        map.set(name, meta)
    )
    return map
  )

EmberEasyDecorator.element = (type, options, html) ->

  options = options || {}
  html    = html || {}
  meta = {
    type: type,
    isAttribute: true,
    html:   html
    options: options
  }
  return Ember.computed((key) ->
    @get('attributes').get(key)
  ).property().meta(meta)

window.EED = EmberEasyDecorator

EED.CheckboxItemView = Ember.View.extend

  title: (->
    @get('item.title') || @get('item.name') || @get('item.%@'.fmt(@get('labelPath'))) ||@get('item')
  ).property('element')

  template: Ember.Handlebars.compile("<label>{{view.title}}</label><input type='checkbox' {{bind-attr checked='view.checked'}}>")

  checked: (->
    Ember.defineProperty(this, "isActive", Ember.computed(->
      @get('decorator')["%@".fmt(@get('checkActiveMethod'))](@get('item'))
    ).property("item", "%@.each".fmt(@get('collectionPath'))))
    @get('isActive')
  ).property('isActive')

  click: ->
    @set('checked', !@get('checked'))
    @get('decorator').send @get('checkCallback'), @get('item'),@get('checked')
    return

Ember.Handlebars.helper 'decorator-input', (property, options) ->
  options = $.extend({}, options)
  element = @get('decorator.%@'.fmt(property))
  return if element?.options?.isVisible == false
  $.extend(options.hash, element.html)

  if element.type == 'nested_attributes'
    options.hash.templateName      = element.options.templateName
    options.hash.contextBinding    = 'controller.decorator'
    options.hash.controllerBinding = 'controller.decorator'
    return Ember.Handlebars.helpers.view.call(this, Ember.View, options)

  options.hash.as = element.type
  if element.type == 'select'
    options.hash.collection = options.hash.collection || 'controller.decorator.%@Collection'.fmt(property)
    if element.options.relation
      options.hash.optionValuePath = options.hash.optionValuePath || "content.id"
      options.hash.optionLabelPath = options.hash.optionLabelPath || "content.value"
    else
      options.hash.optionValuePath = options.hash.optionValuePath || "content"
      options.hash.optionLabelPath = options.hash.optionLabelPath || "content"


  if element.type == 'checkboxCollection'
    this.get('decorator.%@Collection'.fmt(property)).forEach (item) =>
      options.hash.as = "checkbox"
      options.hash.name = property
      options.hash.item = item
      options.hash.checkActiveMethod = element.options.checkActiveMethod
      options.hash.collectionPath = element.options.collectionPath
      options.hash.checkCallback = element.options.checkCallback
      options.hash.decorator = this.get('decorator')
      return Ember.Handlebars.helpers.view.call this, EED.CheckboxItemView, options
    return

  return Ember.Handlebars.helpers['input'].call(@, property, options)


Ember.Handlebars.helper 'decorator-section', (section, options) ->
  elements = @get('decorator.%@SectionFields'.fmt(section))
  elements.forEach (element) =>
    options = $.extend({}, options)
    'collection optionValuePath optionLabelPath placeholder value prompt readonly label type'.w().forEach (attr) ->
      delete options.hash[attr]
    Ember.Handlebars.helpers['decorator-input'].call(@, element.name, options)