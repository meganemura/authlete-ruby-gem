# :nodoc:
#
# Copyright (C) 2014-2018 Authlete, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'set'


module Authlete
  module Model
    module Request
      # == Authlete::Model::Request::AuthorizationIssueRequest class
      #
      # This class represents a request to Authlete's /api/auth/authorization/issue API.
      class AuthorizationIssueRequest < Authlete::Model::Hashable
        # The ticket issued by Authlete's /api/auth/authorization API. (String)
        attr_accessor :ticket

        # The subject (end-user) managed by the service. (String)
        attr_accessor :subject

        # The time when the end-user was authenticated. (Integer)
        attr_accessor :authTime
        alias_method  :auth_time, :authTime
        alias_method  :auth_time=, :authTime=

        # The authentication context class reference. (String)
        attr_accessor :acr

        # Claims in JSON format. (String)
        attr_accessor :claims

        # Extra properties to associate with an access token and/or an
        # authorization code. (String)
        attr_accessor :properties

        # Scopes to associate with an access token and/or an authorization code.
        # If a non-empty string array is given, it replaces the scopes specified
        # by the original authorization request. (String array)
        attr_accessor :scopes

        # The value of the "sub" claim to embed in an ID token. If this request
        # parameter is "nil" or empty, the value of the subject request parameter
        # is used as the value of the "sub" claim. (String)
        attr_accessor :sub

        private

        # Integer attributes.
        INTEGER_ATTRIBUTES = ::Set.new([ :authTime ])

        # String attributes.
        STRING_ATTRIBUTES = ::Set.new([ :ticket, :subject, :acr, :claims, :sub ])

        # String array attributes.
        STRING_ARRAY_ATTRIBUTES = ::Set.new([ :scopes ])

        # Mapping from snake cases to camel cases.
        SNAKE_TO_CAMEL = {
          :auth_time => :authTime
        }

        # The constructor which takes a hash that represents a JSON request to
        # Authlete's /api/auth/authorization/issue API.
        def initialize(hash = nil)
          # Set default values to integer attributes.
          INTEGER_ATTRIBUTES.each do |attr|
            send("#{attr}=", 0)
          end

          # Set default values to string attributes.
          STRING_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          # Set default values to string array attributes.
          STRING_ARRAY_ATTRIBUTES.each do |attr|
            send("#{attr}=", nil)
          end

          @properties = nil

          # Set attribute values using the given hash.
          authlete_model_update(hash)
        end

        def authlete_model_convert_key(key)
          key = key.to_sym

          # Convert snakecase to camelcase, if necessary.
          if SNAKE_TO_CAMEL.has_key?(key)
            key = SNAKE_TO_CAMEL[key]
          end

          key
        end

        def authlete_model_simple_attribute?(key)
          INTEGER_ATTRIBUTES.include?(key) or
          STRING_ATTRIBUTES.include?(key) or
          STRING_ARRAY_ATTRIBUTES.include?(key)
        end

        def authlete_model_update(hash)
          return if hash.nil?

          hash.each do |key, value|
            key = authlete_model_convert_key(key)

            if authlete_model_simple_attribute?(key)
              send("#{key}=", value)
            elsif key == :properties
              @properties = get_parsed_array(value) do |element|
                Authlete::Model::Property.parse(element)
              end
            end
          end

          self
        end

        public

        # Construct an instance from the given hash.
        #
        # If the given argument is nil or is not a Hash, nil is returned.
        # Otherwise, AuthorizationIssueRequest.new(hash) is returned.
        def self.parse(hash)
          if hash.nil? or (hash.kind_of?(Hash) == false)
            return nil
          end

          return AuthorizationIssueRequest.new(hash)
        end

        # Convert this object into a hash.
        def to_hash
          hash = {}

          instance_variables.each do |var|
            key = var.to_s.delete("@").to_sym
            val = instance_variable_get(var)

            if authlete_model_simple_attribute?(key) or val.nil?
              hash[key] = val
            elsif key == :properties
              hash[key] = val.map { |element| element.to_hash }
            end
          end

          hash
        end
      end
    end
  end
end