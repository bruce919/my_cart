module SimpleForm
  class FormBuilder
    def input2(column_name, placeholder)
      input column_name, label: false, placeholder: placeholder
    end
  end
end

