module StreamDownload
  extend ActiveSupport::Concern
  require 'csv'

  private

  def render_streaming_csv(csv_enumerator, csv_name)
    # Delete this header so that Rack knows to stream the content.
    headers.delete('Content-Length')
    # Do not cache results from this action.
    headers['Cache-Control'] = 'no-cache'
    # Let the browser know that this file is a CSV.
    headers['Content-Type'] = 'text/csv'
    # Do not buffer the result when using proxy servers.
    headers['X-Accel-Buffering'] = 'no'
    # Set the filename
    headers['Content-Disposition'] = "attachment; filename=#{csv_name}"
    # Set the response body as the enumerator
    self.response_body = csv_enumerator
  end
end
