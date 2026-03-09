module GenerateCsv
  extend ActiveSupport::Concern

  private

  # rubocop:disable Metrics/ParameterLists, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
  def generate_default_csv(objects, klass = nil, headers: [], include_headers: [], exclude_headers: [], attributes_proc: proc { |_x| [] }, col_sep: ';')
    headers = klass.column_names if headers.blank? && klass.present?
    headers = headers + include_headers - exclude_headers
    objects = klass.select(headers) if objects.nil? && klass.present?
    Enumerator.new do |csv|
      csv << CSV.generate_line(headers, col_sep: col_sep)
      if klass.present?
        count = objects.length
        step = 1000
        (0..count - 1).step(step) do |i|
          objects.limit(step).offset(i).each do |object|
            object_hash = object.as_json
            attributes_proc.call(object).each do |o|
              object_hash[o[:key]] = o[:value]
            end
            result = headers.map do |h|
              object_hash[h]
            end
            csv << CSV.generate_line(result, col_sep: col_sep)
          end
        end
      else
        objects.each do |object|
          object_hash = {}
          attributes_proc.call(object).each do |o|
            object_hash[o[:key]] = o[:value]
          end
          result = headers.map do |h|
            object_hash[h]
          end
          csv << CSV.generate_line(result, col_sep: col_sep)
        end
      end
    end
  end
  # rubocop:enable Metrics/ParameterLists, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
end
