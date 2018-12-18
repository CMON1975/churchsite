require 'faraday'
require 'csv'

module DarkAcreCsvGenerator
  class ContentItem
    attr_reader :title
    attr_reader :play_time
    
    def initialize(title, play_time)
      @title = title
      @play_time = play_time
    end
  end
	
  class EpisodeEntry
    attr_accessor :c, :r, :u
    attr_accessor :url
    attr_accessor :type
    attr_accessor :episode_id
    attr_accessor :title
    attr_accessor :date
    attr_accessor :content_items

    def self.parse(row)
      entry = EpisodeEntry.new
      entry.c = row[0]
      entry.r = row[1]
      entry.u = row[2]
      entry.url = row[3]
      entry.type = row[4]
      entry.episode_id = row[5]
      entry.title = row[6]
      entry.date = row[7]

      1.upto((row.length - 8) / 3) do |position|
	next if row[position+7].nil?
	entry.add_content_item ContentItem.new(row[position+7], row[position+7+2])
      end

      entry
    end

    def initialize
      @content_items = []
    end

    def add_content_item(content_item)
      @content_items.push content_item
    end
  end	  
  
  class GamePage < Jekyll::Page
    def initialize(site, base, dir, episode)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(episode.title)
      self.read_yaml(File.join(base, '_layouts'), 'game_index.md')
      self.data['episode'] = episode

      game_title_prefix = site.config['game_title_prefix'] || 'Game: '
      self.data['title'] = "#{game_title_prefix}#{episode.title}"
    end
  end

  class Generator < Jekyll::Generator
    def parse_csv
      csv_link = 'https://docs.google.com/spreadsheets/d/1YAazmCZao9HAesZ6UPeFr4tR4z_63a2pKNlGE1c4xLI/export?format=csv&id=1YAazmCZao9HAesZ6UPeFr4tR4z_63a2pKNlGE1c4xLI&gid=0'

      csv_export_response = Faraday.get csv_link

      lines = CSV.parse(csv_export_response.body)

      lines.shift # remove header

      episodes = lines.map do |line|
	EpisodeEntry.parse(line)
      end

      episodes
    end

    def generate(site)
      dir = site.config['game_dir'] || 'games'
      parse_csv.each do |episode|
        site.pages << GamePage.new(site, site.source, File.join(dir, episode.type), episode)
      end
    end
  end
end
