# frozen_string_literal: true

require 'json/jwt'
require "libauth/jwt/version"
require "libauth/jwt/error"

module Libauth
  module Jwt
    def get_id_token!(headers)
      token = authentication_token(headers)
      id_token = authentication_token_decode(token)
      jwk = authentication_jwk(id_token)

      authentication_verify!(token, jwk)
    rescue JSON::JWK::Set::KidNotFound => e
      log_exception(e)
      raise NoAuthoization, e
    rescue JSON::JWT::InvalidFormat => e
      log_exception(e)
      raise NoAuthoization, e
    rescue JSON::JWT::VerificationFailed => e
      log_exception(e)
      raise NoAuthoization, e
    rescue JSON::JWT::UnexpectedAlgorithm => e
      log_exception(e)
      raise NoAuthoization, e
    end

    private

    def authentication_token(headers)
      header = headers["Authorization"]
      token = header.split(" ").last if header
      raise NoAuthoization, "require bearer token" if token.nil?

      token
    end

    def authentication_token_decode(token)
      JSON::JWT.decode(token, :skip_verification)
    end

    def authentication_jwk(id_token)
      kid = id_token.header[:kid]
      uri = jwks_uri(id_token[:tid])

      JSON::JWK::Set::Fetcher.fetch(uri, kid: kid)
    end

    def authentication_verify!(token, jwk)
      JSON::JWT.decode(token, jwk)
    end

    def jwks_uri(tenant_id)
      @jwks_uri ||= File.join(ENV["JWKS_URL1"], tenant_id, ENV["JWKS_URL2"])
    end
  end
end
