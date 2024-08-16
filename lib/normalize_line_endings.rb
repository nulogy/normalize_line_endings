require "normalize_line_endings/version"

require "active_support"

module NormalizeLineEndings
  extend ActiveSupport::Concern

  class_methods do
    def normalize_line_endings(*opts)
      @normalize_line_endings_options = opts.first.is_a?(Hash) ? opts.first : { only: opts } unless opts.empty?

      class << self; attr_reader :normalize_line_endings_options; end

      before_validation { |record| record.normalize_line_endings } # rubocop:disable Style/SymbolProc
    end

    alias_method :normalize_line_endings_for, :normalize_line_endings
  end

  def normalize_line_endings
    attrs_for_normalized_line_endings.each do |attr, value|
      send(:"#{attr}=", value.gsub("\r\n", "\n")) if value.respond_to?(:gsub)
    end
  end

  def attrs_for_normalized_line_endings
    options = self.class.normalize_line_endings_options

    return attributes if options.blank?

    if options[:except]
      except = Array(options[:except]).flatten.map(&:to_s)

      attributes.stringify_keys.except(*except)
    elsif options[:only]
      only = Array(options[:only]).flatten.map(&:to_s)

      attributes.stringify_keys.slice(*only)
    end
  end
end
