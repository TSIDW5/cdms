# <label class="custom-switch">
#   <input type="checkbox" name="custom-switch-checkbox" class="custom-switch-input">
#   <span class="custom-switch-indicator"></span>
#   <span class="custom-switch-description">I agree with terms and conditions</span>
# </label>
class SwitchSingleInput < SimpleForm::Inputs::Base
  def input(_wrapper_options)
    template.tag.label(class: 'custom-switch pl-0 mt-2') do
      template.concat @builder.check_box(attribute_name, class: 'custom-switch-input')
      template.concat span_indicator
      template.concat span_description
    end
  end

  def span_indicator
    template.tag.span(class: 'custom-switch-indicator')
  end

  def span_description
    field_name = options[:field_name] ||= object.class.human_attribute_name(attribute_name)

    template.tag.span(class: 'custom-switch-description') do
      field_name
    end
  end

  def label(_wrapper_options)
    template.tag.div(class: 'form-label font-weight-normal') do
      'Status'
    end
  end
end
