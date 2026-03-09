# Every Service should extend BaseService. This is a pattern to provide better error handling.
class BaseService

  # Default call method
  #
  # @param args You can pass any parameter that you want
  # @return [OpenStruct] It should return an OpenStruct with a boolean called success?,
  #   an object called payload and a string called message if the method failed
  def self.call(**args)
    new(**args).call
  end

  # Same as call but for raising errors
  #
  # @param (see .call)
  # @return (see .call)
  def self.call!(**args)
    new(**args).call!
  end

  def initialize(*); end

  # This method is used when you everything went ok
  #
  # @param payload Service response
  # @return [OpenStruct] OpenStruct with a boolean called success? and an object called payload
  def success(payload: nil)
    OpenStruct.new({ success?: true, payload: payload })
  end

  # This method is used when you want to return an error
  #
  # @param payload Service response
  # @param message [String, nil] Service error message
  # @return [OpenStruct] OpenStruct with a boolean called success?,
  #   an object called payload and a string called message if the method failed
  def error(payload: nil, message: nil)
    OpenStruct.new({ success?: false, payload: payload, message: message })
  end

end
