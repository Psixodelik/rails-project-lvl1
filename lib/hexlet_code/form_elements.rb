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

    def input(name, option = nil)
      default_element_type = :input
      type = 'text'
      value = form_option[name]

      element_type = option.is_a?(Hash) && option.key?(:as) ? option[:as] : default_element_type

      rendered_elements.push case element_type
                             when :input
                               input_render(type, name, value)
                             when :text
                               textarea_render(name, value)
                             when :select
                               selected_value = value
                               options = option[:collection]

                               select_render(name, selected_value, options)
                             end
    end

    def submit
      rendered_elements.push input_render('submit', 'commit', 'Save', false)
    end

    def input_render(type, name, value, label = true)
      result = []
      result.push HexletCode::Tag.build('label', for: name) { name } if label
      result.push HexletCode::Tag.build('input', type: type, name: name, value: value)
    end

    def textarea_render(name, value, cols = 20, rows = 40)
      HexletCode::Tag.build('textarea', name: name, cols: cols, rows: rows) { value }
    end

    def select_render(name, selected, collection)
      options = collection.map do |value|
        selected = value == selected
        HexletCode::Tag.build('option', value: value, selected: selected) { value }
      end

      HexletCode::Tag.build('select', name: name) { options }
    end
  end
end
