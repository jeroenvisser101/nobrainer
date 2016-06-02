module NoBrainer::Document::Core
  extend ActiveSupport::Concern

  included do
    # TODO test these includes
    extend ActiveModel::Naming
    extend ActiveModel::Translation

    unless name =~ /^NoBrainer::/
      NoBrainer::Loader.register(self)
    end
  end

  def self.all(options={})
    (options[:types] || [:user]).map do |type|
      case type
      when :user
        Rails.application.eager_load! if defined?(Rails.application.eager_load!)
        NoBrainer::Loader.registry
      when :nobrainer
        [NoBrainer::Document::Index::MetaStore, NoBrainer::Lock]
      when :system
        NoBrainer::System.constants
          .map { |c| NoBrainer::System.const_get(c) }
          .select { |m| m < NoBrainer::Document }
      end
    end.reduce([], &:+)
  end
end
