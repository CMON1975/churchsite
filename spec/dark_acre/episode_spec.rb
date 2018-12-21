require 'yaml'

RSpec.describe DarkAcre::Episode do
  describe "#to_yaml" do
    it "returns a valid YAML representation" do
      episode = DarkAcre::Episode.new(
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

      expected = <<-HEREDOC
---
id: '65'
show_name: unplayed
title: ".hack //G.U. Last Recode"
air_date: 03/11/2018
source_url: 
games:
- name: ".hack //G.U. Last Recode"
  source_url: 
  decision: 
  play_time: 
      HEREDOC

      expect(episode.to_yaml).to eql expected
    end
  end
end