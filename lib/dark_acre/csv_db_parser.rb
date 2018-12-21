require "dark_acre/episode"
require "dark_acre/episode_game"

module DarkAcre
  class CsvDbParser
    def parse(csv)


      csv.map do |row|
        Episode.new(
          row[5],
          row[4].downcase,
          row[6],
          row[7], #handle parsing date
          row[3],
          parse_games(row)
        )
      end
    end

    def parse_games(row)
      episode_games = []

      pointer = 8

      while pointer < row.length
        break if row[pointer].nil?

        episode_games.push EpisodeGame.new(
          row[pointer],
          row[pointer+1],
          row[pointer+2],
          row[pointer+3]
        )

        pointer += 4
      end

      episode_games
    end
  end
end