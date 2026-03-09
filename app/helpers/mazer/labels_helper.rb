module Mazer
  module LabelsHelper
    def mazer_yes_or_no?(value)
      if value
        I18n.t('views.mazer.yes')
      else
        I18n.t('views.mazer.no')
      end
    end

    def mazer_label_yes_or_no?(value)
      if value
        content_tag(:span, I18n.t('views.mazer.yes'), class: 'badge bg-success')
      else
        content_tag(:span, I18n.t('views.mazer.no'), class: 'badge bg-danger')
      end
    end

    def mazer_get_color_class(value = 0)
      array = [
        '',
        'box-primary',
        'box-info',
        'box-success',
        'box-warning',
        'box-danger'
      ]
      array[value]
    end
  end
end
