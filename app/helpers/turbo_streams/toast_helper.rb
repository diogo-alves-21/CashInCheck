module TurboStreams::ToastHelper
  def toast(message, position: 'right', type: 'notice')
    turbo_stream_action_tag :toast, message: message, position: position, type: type
  end
end
Turbo::Streams::TagBuilder.prepend(TurboStreams::ToastHelper)
