module NoBrainer::Loader
  REGISTRY = Concurrent::Array.new

  class << self
    def clear_registry
      REGISTRY.clear
    end

    def register(klass)
      delete(klass) if include?(klass)
      REGISTRY << klass
    end

    def registry
      REGISTRY
    end

    def delete(klass)
      REGISTRY.delete(klass)
    end

    def include?(klass_name)
      REGISTRY.map(&:name).include?(klass_name)
    end
  end
end
