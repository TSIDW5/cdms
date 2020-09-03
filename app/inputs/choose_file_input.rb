#  <div class="form-group">
#    <div class="form-label">Bootstrap's Custom File Input</div>
#    <div class="custom-file">
#      <input type="file" class="custom-file-input" name="example-file-input-custom">
#      <label class="custom-file-label">Choose file</label>
#    </div>
#  </div>
class ChooseFileInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] = 'custom-file-input'

    template.tag.div(class: 'custom-file') do
      template.concat @builder.file_field(attribute_name, merged_input_options)
      template.concat label_choose
    end
  end

  def label_choose
    template.tag.label(class: 'custom-file-label') do
      t('views.file.choose')
    end
  end
end
