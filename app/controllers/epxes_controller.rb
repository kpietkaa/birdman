class EpxesController < ApplicationController

  $JSON = ""

  def index
    @cages = Array.new
    # (2561..2564).map do |i|
    (2561..2561).map do |i|
      url = "http://zpiiotdiscovery.repository-api.epx-platform.org/api/models/"
      cage = Cage.new
      url += i.to_s

      begin
        json = fetch url
        if i == 2561
          $JSON = json
        end
        if json["Message"].nil?
          cage.id = json["Id"]
          cage.name = json["Name"]
          cage.type = json["RootModelElement"]["Children"][1]["Value"]
          cage.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
          cage.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
        else
          cage.error = json["Message"]
        end
      rescue Timeout::Error
        cage.error = "Timeout error"
      end

      @cages.push(cage)
    end

    @sensors = Array.new
    # (2555..2559).map do |i|
    (2555..2555).map do |i|
    url = "http://zpiiotdiscovery.repository-api.epx-platform.org/api/models/"
      sensor = Sensor.new
      url += i.to_s
      begin
      json = fetch(url)
      sensor.id = json["Id"]
      sensor.name = json["Name"]
      sensor.temperature = json["RootModelElement"]["Children"][0]["Value"]
      sensor.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
      sensor.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
    rescue Timeout::Error
      sensor.error = "Timeout error"
    end
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
  attr_accessor :id, :name, :type, :animal_id, :animal_name, :error
end

class Sensor
  attr_accessor :id, :name, :temperature, :animal_id, :animal_name, :error
end
