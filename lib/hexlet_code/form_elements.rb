# frozen_string_literal: true

module HexletCode
  # Rendering Form Element such as input, select
  class FormElements
    attr_reader :form_option
    attr_accessor :rendered_elements

    def initialize(data)
      @form_option = data
      @rendered_elements = []
    end

    def input(name, **option)
      default_element_type = :input
      value = form_option[name]

      attributes = option.merge({ name: name, value: value })
      element_type = option.is_a?(Hash) && option.key?(:as) ? attributes.delete(:as) : default_element_type

      case element_type
      when :input
        attributes[:type] = 'text'
        input_render(**attributes)
      when :text
        textarea_render(**attributes)
      when :select
        select_render(**attributes)
      end
    end

    def render(tag, **attributes)
      render = HexletCode::Tag.build(tag, **attributes) { yield if block_given? }
      render = attributes[:push] == false ? render : rendered_elements.push(render)
    end

    def input_render(**attributes)
      render('label', for: attributes[:name]) { attributes[:name] }
      render('input', **attributes)
    end

    def textarea_render(**attributes)
      render('label', for: attributes[:name]) { attributes[:name] }
      render('textarea', **attributes)
    end

    def submit(value = 'Save')
      attributes = { value: value, type: 'submit' }
      render('input', **attributes)
    end

    def select_render(**attributes)
      collection = attributes.delete(:collection)
      selected_value = form_option[attributes[:name]]

      options = collection.map do |value|
        is_selected = value == selected_value
        render('option', value: value, selected: is_selected, push: false) { value }
      end

      attributes.delete(:value)

      render('select', **attributes) { options }
    end
  end
end
