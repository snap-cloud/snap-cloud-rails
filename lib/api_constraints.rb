# This is a RailsCasts model for versioning APIs.
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.snapcloud.v#{@version}")
  end
end