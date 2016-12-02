class EpxesController < ApplicationController

  def index
    @cages = Array.new
    url = "http://zpiiotdiscovery.repository-api.epx-platform.org/api/models/"
    # (2560..2564).map do |i|
    (2560...2562).map do |i|
      cage = Cage.new
      url += i.to_s
      json = fetch url
      cage.id = json["Id"]
      cage.name = json["Name"]
      cage.type = json["RootModelElement"]["Children"][1]["Value"]
      cage.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
      cage.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
      @cages.push(cage)
    end

    @sensors = Array.new
    # (2555..2559).map do |i|
    (2555..2556).map do |i|
      sensor = Sensor.new
      url += i.to_s
      json = fetch(url)
      sensor.id = json["Id"]
      sensor.name = json["Name"]
      sensor.temperature = json["RootModelElement"]["Children"][0]["Value"]
      sensor.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
      sensor.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
      @sensors.push(sensor)
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

class Sensor
  attr_accessor :id, :name, :temperature, :animal_id, :animal_name
end
