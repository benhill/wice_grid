module Wice #:nodoc:
  module BsCalendarHelpers #:nodoc:

    class CalendarData
      attr_accessor :name,
                    :date_string,
                    :dom_id,
                    :datepicker_placeholder_id,
                    :date_div_id,
                    :the_other_datepicker_id_to,
                    :the_other_datepicker_id_from
    end

    def date_calendar_bs(calendar_data)  #:nodoc:

      text_field_tag_options = {
          :id                   => calendar_data.dom_id,
          'data-provide'        => 'datepicker',
          'data-date-language'  => I18n.locale,
          'data-date-autoclose' => true,
          'data-date-format'    => Wice::ConfigurationProvider.value_for(:DATE_FORMAT_BOOTSTRAP),
      }


      text_field_tag_options['class'] = 'form-control input-sm'

      if Rails.env.development?
        text_field_tag_options['class'] += ' check-for-bsdatepicker'
      end

      if calendar_data.the_other_datepicker_id_to
        text_field_tag_options['data-the-other-bsdatepicker-id-to'] = calendar_data.the_other_datepicker_id_to
      end

      if calendar_data.the_other_datepicker_id_from
        text_field_tag_options['data-the-other-bsdatepicker-id-from'] = calendar_data.the_other_datepicker_id_from
      end

      date_picker = text_field_tag(calendar_data.name, calendar_data.date_string, text_field_tag_options)

      "<div id=\"#{calendar_data.datepicker_placeholder_id}\">#{date_picker}</div>"
    end

    def prepare_data_for_bscalendar(options)  #:nodoc:

      date_format = Wice::ConfigurationProvider.value_for(:DATE_FORMAT)

      CalendarData.new.tap do |calendar_data|

        calendar_data.name                      = options[:name]
        calendar_data.date_string               = options[:initial_date].nil? ? '' : options[:initial_date].strftime(date_format)
        calendar_data.dom_id                    = options[:name].gsub(/([\[\(])|(\]\[)/, '_').gsub(/[\]\)]/, '').gsub(/\./, '_').gsub(/_+/, '_')
        calendar_data.datepicker_placeholder_id = calendar_data.dom_id + '_date_placeholder'
        calendar_data.date_div_id              = calendar_data.dom_id + '_date_view'

      end
    end

  end
end
