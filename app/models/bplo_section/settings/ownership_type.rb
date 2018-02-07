module BploSection
  module Settings
    class OwnershipType < ApplicationRecord
      has_many :businesses
      validates :name, presence: true, uniqueness: true
      def self.single_proprietorship
        select { |a| a.single_proprietorship? }
      end
      def cooperative?
        ["Cooperative", 'cooperative'].include?(name)
      end
      def corporation?
        ["Corporation", 'corporation'].include?(name)
      end
      def single_proprietorship?
        ["Single Proprietorship", "single proprietorship", "Sole proprietorship", "sole proprietorship", "sole proprietor"].include?(name)
      end
    end
  end
end
