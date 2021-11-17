module Services
  module BaseService
    attr_reader :errors

    def self.prepended(base)
      base.extend ClassMethods
      base.send :prepend, InstanceMethods
    end

    module ClassMethods
      def call(params)
        new(params).call
      end
    end

    module InstanceMethods
      def initialize(params)
        super(params)
        @errors = []
      end

      def call
        super
        self
      end

      def successful?
        errors.empty?
      end

      private

      def fail!(error)
        @errors << error
        self
      end
    end
  end
end
