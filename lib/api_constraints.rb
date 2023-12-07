# frozen_string_literal: true

class ApiConstraints
  attr_reader :version, :default

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    @default || request.headers['Accept'].include?("application/localhost:3000.v#{@version}")
  end
end
