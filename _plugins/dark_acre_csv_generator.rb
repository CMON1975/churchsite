require 'faraday'
require 'csv'
require 'yaml'

def sanitize_name(name)
  name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
end

module DarkAcreCsvGenerator
  class ContentItem
    attr_reader :title
    attr_reader :url
    attr_reader :decision
    attr_reader :play_time

    def initialize(title, url, decision, play_time)
      @title = title
      @url = url
      @decision = decision
      @play_time = play_time
    end
  end

  class EpisodeEntry
    attr_accessor :converted
    attr_accessor :rendered
    attr_accessor :uploaded
    attr_accessor :url
    attr_accessor :type
    attr_accessor :episode_id
    attr_accessor :title
    attr_accessor :date
    attr_accessor :content_items

    def self.parse(row)
      entry = EpisodeEntry.new
      entry.converted = row[0]
      entry.rendered = row[1]
      entry.uploaded = row[2]
      entry.url = row[3]
      entry.type = row[4].downcase
      entry.episode_id = row[5]
      entry.title = row[6]
      entry.date = row[7]

      pointer = 8

      while pointer <= (row.length - 4)
        break if row[pointer].nil?

        entry.add_content_item ContentItem.new(row[pointer], row[pointer + 1], row[pointer + 2], row[pointer + 3])

        pointer += 4
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

  class EpisodePage < Jekyll::Page
    def initialize(site, base, dir, episode)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.md'

      self.process(sanitize_name(episode.title))
      self.read_yaml(File.join(base, '_layouts'), 'episode.html')
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
      return # uncomment this to generate from csv

      dir = site.config['episodes_dir'] || 'episodes'

      episodes = parse_csv

      episodes.each do |episode|

        file_name = "#{episode.type}-#{episode.episode_id}.md"

        metadata = {
          layout: 'episode',
          id: episode.episode_id,
          date: episode.date,
          show: episode.type,
          title: episode.title,
          url: episode.url,
          games: []
        }

        episode.content_items.each do |content_item|
          metadata[:games].push ({
            title: content_item.title,
            play_time: content_item.play_time,
            decision: content_item.decision
          }.transform_keys(&:to_s))
        end

        metadata[:games].each do |game|
          game_file_name = "#{sanitize_name(game['title'])}.md"
        end

        template = metadata.transform_keys(&:to_s).to_yaml

        template += "---\n"

        File.open(File.join( '_episodes', file_name), 'w') do |file|
          file.write(template)
        end

        # site.pages << EpisodePage.new(site, site.source, File.join(dir, episode.type), episode)
      end
    end
  end
end
