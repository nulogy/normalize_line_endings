require "spec_helper"

require "active_model"
require "normalize_line_endings"

module MockAttributes
  extend ActiveSupport::Concern
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include NormalizeLineEndings
  included do
    attr_accessor :foo, :bar, :biz, :baz
  end

  def initialize(attrs = {})
    @foo = attrs[:foo]
    @bar = attrs[:bar]
    @biz = attrs[:biz]
    @baz = attrs[:baz]
  end

  def attributes
    { foo: foo, bar: bar, biz: biz, baz: baz }
  end
end

class NormalizeAllMockRecord
  include MockAttributes
  normalize_line_endings
end

class NormalizeOnlyOneMockRecord
  include MockAttributes
  normalize_line_endings only: :foo
end

class NormalizeOneMockRecord
  include MockAttributes
  normalize_line_endings_for :foo
end

class NormalizeOnlyThreeMockRecord
  include MockAttributes
  normalize_line_endings only: [:foo, :bar, :biz]
end

class NormalizeThreeMockRecord
  include MockAttributes
  normalize_line_endings_for :foo, :bar, :biz
end

class NormalizeExceptOneMockRecord
  include MockAttributes
  normalize_line_endings except: :foo
end

class NormalizeExceptThreeMockRecord
  include MockAttributes
  normalize_line_endings except: [:foo, :bar, :biz]
end

RSpec.describe NormalizeLineEndings do
  let(:init_params) { { foo: "foo\r\n", bar: "\r\nbar", biz: "biz\r\nbiz", baz: nil } }
  let(:normalized) { { foo: "foo\n", bar: "\nbar", biz: "biz\nbiz", baz: nil } }

  it "normalizes all fields" do
    record = NormalizeAllMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :foo, :bar, :baz, :biz
  end

  it "normalizes only one field" do
    record = NormalizeOnlyOneMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :foo
    assert_not_normalized record, :bar, :biz, :baz
  end

  it "normalizes one field" do
    record = NormalizeOneMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :foo
    assert_not_normalized record, :bar, :biz, :baz
  end

  it "normalizes only three fields" do
    record = NormalizeOnlyThreeMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :foo, :bar, :biz
    assert_not_normalized record, :baz
  end

  it "normalizes three fields" do
    record = NormalizeThreeMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :foo, :bar, :biz
    assert_not_normalized record, :baz
  end

  it "normalizes all except for one field" do
    record = NormalizeExceptOneMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :bar, :baz, :biz
    assert_not_normalized record, :foo
  end

  it "normalizes all except for three fields" do
    record = NormalizeExceptThreeMockRecord.new(init_params)
    record.valid?

    assert_normalized record, :baz
    assert_not_normalized record, :foo, :bar, :biz
  end

  private

  def assert_normalized(record, *fields)
    Array(fields).each do |field|
      value = record.send(field)
      expected = normalized[field]

      if expected.nil?
        expect(value).to be_nil
      else
        expect(value).to eq(expected)
      end
    end
  end

  def assert_not_normalized(record, *fields)
    Array(fields).each do |field|
      value = record.send(field)
      expected = normalized[field]

      if expected.nil?
        expect(value).to be_nil
      else
        expect(expected).to_not eq(value)
      end
    end
  end
end
