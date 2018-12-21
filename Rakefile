task default: %w[generate]

$LOAD_PATH.unshift('./lib')

task :generate do
  require 'dark_acre/csv_db_parser'

  require 'faraday'
  require 'csv'
  require 'diffy'
  require 'rainbow'

  puts "=" * 38
  puts "= Dark Acre Church Episode Generator ="
  puts "=" * 38

  database_url = 'https://docs.google.com/spreadsheets/d/1YAazmCZao9HAesZ6UPeFr4tR4z_63a2pKNlGE1c4xLI/export?format=csv&id=1YAazmCZao9HAesZ6UPeFr4tR4z_63a2pKNlGE1c4xLI&gid=0'

  response = Faraday.get database_url

  csv_file = CSV.parse(response.body)

  # Remove the header from the CSV file.
  csv_file.shift

  parser = DarkAcre::CsvDbParser.new

  episodes = parser.parse(csv_file)

  total_changes = 0
  total_added = 0

  episodes.each do |episode|
    episode_path = "./_episodes/#{episode.show_name}-#{episode.id}-#{episode.friendly_title}.md"

    episode_md = episode.to_yaml + "---\n"

    if File.zero?(episode_path)
      total_added += 1
    else
      existing_episode = File.read(episode_path)

      Diffy::Diff.default_format = :color

      diff = Diffy::Diff.new(existing_episode, episode_md, context: 1)

      diff_output = diff.to_s

      next if diff_output == "\n"

      puts "\n"
      puts Rainbow("Episode: #{episode_path}").blue
      puts diff_output
      puts "\n"

      total_changes += 1
    end

    File.write(episode_path, episode_md)
  end

  puts Rainbow("Total files added: #{total_changes}").green
  puts Rainbow("Total files changed: #{total_changes}").yellow

  puts "Completed!"
end