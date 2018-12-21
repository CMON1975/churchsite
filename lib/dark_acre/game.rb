module DarkAcre
  class Game
    include SlugHelper

    attr_reader :name
    attr_reader :steam_id

    def initialize(name, steam_id)
      @name = name
      @steam_id = steam_id
    end

    def friendly_name
      generate_slug(@name)
    end

    def steam_url
      "https://store.steampowered.com/app/#{@steam_id}"
    end
  end
end