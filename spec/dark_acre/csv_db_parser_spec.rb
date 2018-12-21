require 'csv'
require 'json'
require 'dark_acre/csv_db_parser'

RSpec.describe DarkAcre::CsvDbParser do
  describe "#parse" do
    it "can parse a single row of a CSV file" do
      parser = DarkAcre::CsvDbParser.new

      csv = CSV.parse("FALSE,FALSE,FALSE,,Unplayed,65,.hack //G.U. Last Recode,03/11/2018,.hack //G.U. Last Recode,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,")

      expected = [
        DarkAcre::Episode.new(
          "65",
          "unplayed",
          ".hack //G.U. Last Recode",
          "03/11/2018",
          nil,
          [
            DarkAcre::EpisodeGame.new(
              ".hack //G.U. Last Recode",
              nil,
              nil,
              nil
            )
          ]
        )
      ]

      expect(parser.parse(csv)).to eq expected
    end

    it "can parse multiple rows of a CSV file" do
      parser = DarkAcre::CsvDbParser.new

      csv = CSV.parse(
        "FALSE,FALSE,FALSE,,Unplayed,65,.hack //G.U. Last Recode,03/11/2018,.hack //G.U. Last Recode,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,\n" + \
        "FALSE,FALSE,FALSE,,Unbeaten,1,Dragon Age: Origins (1),04/11/2018,Dragon Age: Origins,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"
      )

      expected = [
        DarkAcre::Episode.new(
          "65",
          "unplayed",
          ".hack //G.U. Last Recode",
          "03/11/2018",
          nil,
          [
            DarkAcre::EpisodeGame.new(
              ".hack //G.U. Last Recode",
              nil,
              nil,
              nil
            )
          ]
        ),
        DarkAcre::Episode.new(
          "1",
          "unbeaten",
          "Dragon Age: Origins (1)",
          "04/11/2018",
          nil,
          [
            DarkAcre::EpisodeGame.new(
              "Dragon Age: Origins",
              nil,
              nil,
              nil
            )
          ]
        )
      ]

      expect(parser.parse(csv)).to eq expected
    end
  end
end