module ExpectHelpers
  def expect_to_be_present_in_page(object: {})
    object.each_value do |value|
      if value.is_a?(Hash)
        expect_to_be_present_in_page(object: value)
      elsif value.present?
        expect(page).to have_text value
      end
    end
  end

  def expect_to_be_in_toast(text)
    expect(find('div', class: 'toastify')).to have_text text
  end

  def expect_to_be_present_in_model(object: {}, attributes: {})
    attributes.each do |key, value|
      if value.instance_of?(Float)
        expect(object[key]).to eq(value.to_d(object[key].precision))
      else
        expect(object[key]).to eq(value)
      end
    end
  end

  def case_insensitive(string)
    /#{string}/i
  end
end
