require "yaml"
require "dark_acre/slug_helper"

module DarkAcre
  class EpisodeGame
    include SlugHelper

    attr_reader :name
    attr_reader :source_url
    attr_reader :decision
    attr_reader :play_time

    def initialize(name, source_url, decision, play_time)
      @name = name
      @source_url = source_url
      @decision = decision
      @play_time = play_time
    end

    def friendly_name
      generate_slug(@name)
    end

    def to_hash
      {
        name: @name,
        friendly_name: friendly_name,
        source_url: @source_url,
        decision: @decision,
        play_time: @play_time
      }
    end

    def to_yaml
      self.to_hash.transform_keys(&:to_s).to_yaml
    end

    def ==(other_object)
      return false unless other_object.instance_of?(DarkAcre::EpisodeGame)

      [
        @name == other_object.name,
        @source_url == other_object.source_url,
        @decision == other_object.decision,
        @play_time == other_object.play_time
      ].all?
    end
  end
end