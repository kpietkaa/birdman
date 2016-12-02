class EpxesController < ApplicationController

  def index
    @cages = Array.new
    # (2560..2564).map do |i|
    (2560...2562).map do |i|
      cage = Cage.new
      url = "http://zpiiotdiscovery.repository-api.epx-platform.org/api/models/" + i.to_s
      json = fetch url
      cage.id = json["Id"]
      cage.name = json["Name"]
      cage.type = json["RootModelElement"]["Children"][1]["Value"]
      cage.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
      cage.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
      @cages.push(cage)
    end
  end

  private

  def fetch(url)
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    JSON.parse(data)
  end
end

class Cage
  attr_accessor :id, :name, :type, :animal_id, :animal_name
end
