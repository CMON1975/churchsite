require "yaml"
require "dark_acre/slug_helper"
require "dark_acre/episode_game"

module DarkAcre
  class Episode
    include SlugHelper

    attr_reader :id
    attr_reader :show_name
    attr_reader :title
    attr_reader :date
    attr_reader :source_url
    attr_reader :games

    def initialize(id, show_name, title, date, source_url, games)
      @id = id
      @show_name = show_name
      @title = title
      @date = date
      @source_url = source_url
      @games = []

      games.each(&method(:add_game))
    end

    def friendly_title
      generate_slug(@title)
    end

    def add_game(game)
      raise "Game must be an instance of DarkAcre::EpisodeGame" unless game.instance_of?(EpisodeGame)
      @games.push game
    end

    def to_hash
      serialized_games = @games.map(&:to_hash)

      tags = [@show_name]

      serialized_games.each do |game|
        tags.push(game[:friendly_name])
      end

      {
        layout: "episode",
        id: @id,
        show_name: @show_name,
        title: @title,
        friendly_title: friendly_title,
        date: @date,
        source_url: @source_url,
        games: serialized_games,
        category: @show_name,
        tags: tags
      }
    end

    def to_yaml
      hash = to_hash
      hash[:games] = hash[:games].map { |h| h.transform_keys(&:to_s) }
      hash.transform_keys(&:to_s).to_yaml
    end

    def ==(other_object)
      return false unless other_object.instance_of?(DarkAcre::Episode)

      [
        @id == other_object.id,
        @show_name == other_object.show_name,
        @title == other_object.title,
        @date == other_object.date,
        @source_url == other_object.source_url,
        games.each_with_index.map do |game, index|
          game == other_object.games[index]
        end
      ].flatten.all?
    end
  end
end