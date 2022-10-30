# frozen_string_literal: true

module Libauth
  module Jwt
    class Error < StandardError; end
    class NoAuthoization < StandardError; end
  end
end
