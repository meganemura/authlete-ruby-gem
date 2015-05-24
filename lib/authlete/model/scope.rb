# :nodoc:
#
# Copyright (C) 2015 Authlete, Inc.
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
    class Scope
      # The description about this scope. (String)
      attr_accessor :description

      # The name of this scope. (String)
      attr_accessor :name

      # The flag to indicate whether this scope is included in the
      # default scope set. (boolean)
      attr_accessor :defaultEntry

      private

      # Boolean attributes.
      BOOLEAN_ATTRIBUTES = ::Set.new([:defaultEntry])

      # String attributes.
      STRING_ATTRIBUTES = ::Set.new([:description, :name])

      # The constructor
      def initialize(hash = new)
        # Set default values to boolean attributes.
        BOOLEAN_ATTRIBUTES.each do |attr|
          send("#{attr}=", false)
        end

        # Set default values to string attributes.
        STRING_ATTRIBUTES.each do |attr|
          send("#{attr}=", nil)
        end

        # Set attribute values using the given hash.
        authlete_model_scope_update(hash)
      end

      def authlete_model_scope_simple_attribute?(key)
        BOOLEAN_ATTRIBUTES.include?(key) or
        STRING_ATTRIBUTES.include?(key)
      end

      def authlete_model_scope_update(hash)
        if hash.nil?
          return
        end

        hash.each do |key, value|
          key = key.to_sym

          # If the attribute is a simple one.
          if authlete_model_scope_simple_attribute?(key)
            send("#{key}=", value)
            next
          end
        end

        return self
      end

      public

      # Construct an instance from the given hash.
      #
      # If the given argument is nil or is not a Hash, nil is returned.
      # Otherwise, Scope.new(hash) is returned.
      def self.parse(hash)
        if hash.nil? or (hash.kind_of?(Hash) == false)
          return nil
        end

        return Authlete::Model::Scope.new(hash)
      end

      # Set attribute values using the given hash.
      def update(hash)
        authlete_model_scope_update(hash)
      end

      # Convert this object into a hash.
      def to_hash
        hash = {}

        instance_variables.each do |var|
          key = var.to_s.delete("@").to_sym
          val = instance_variable_get(var)

          hash[key] = val
        end

        return hash
      end
    end
  end
end
