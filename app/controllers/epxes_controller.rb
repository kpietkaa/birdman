class EpxesController < ApplicationController
  authorize_resource :class => false
  $JSONCAGE = ""
  $JSONSENSOR = ""
  URL = "http://zpiiotdiscovery.repository-api.epx-platform.org/api/models/"

  def index
    @cages = Array.new
    # (2561..2564).map do |i|
    (2561..2561).map do |i|
      @cage = Cage.new
      url = URL + i.to_s
      get_cages url
      @cages.push(@cage)
    end

    @sensors = Array.new
    # (2555..2559).map do |i|
    (2555..2555).map do |i|
      @sensor = Sensor.new
      url = URL + i.to_s
      get_sensor url
      @sensors.push(@sensor)
    end

  end

  def update_cage
    url = URL + params[:cage][:id].to_s
    json = fetch(url)
    $JSONCAGE = json
    $JSONCAGE["Id"] = params[:cage][:id]
    $JSONCAGE["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"] = params[:cage][:animal_name]

    put $JSONCAGE
    redirect_to "/epxes", notice: 'Cage has been updated'
  end

  def update_sensor
    url = URL + params[:cage][:id].to_s
    json = fetch(url)
    $JSONSENSOR = json
    $JSONSENSOR["Id"] = params[:cage][:id]
    $JSONSENSOR["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"] = params[:cage][:animal_name]

    put $JSONSENSOR
    redirect_to "/epxes", notice: 'Sensor has been updated'
  end

  private

  def fetch(url)
    response = Net::HTTP.get_response(URI.parse(url))
    data = response.body
    JSON.parse(data)
  end

  def put(body)
    uri = URI.parse(URL)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Put.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = body.to_json
    begin
    response = http.request(request)
    rescue Timeout::Error
      render file: "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  def get_cages(url)
    begin
      json = fetch url

      if json["Message"].nil?
        @cage.id = json["Id"]
        @cage.name = json["Name"]
        @cage.type = json["RootModelElement"]["Children"][1]["Value"]
        @cage.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
        @cage.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
      else
        @cage.error = json["Message"]
      end
    rescue Timeout::Error
      @cage.error = "Timeout error"
    end
  end

  def get_sensor(url)
    begin
      json = fetch(url)

      if json["Message"].nil?
        @sensor.id = json["Id"]
        @sensor.name = json["Name"]
        @sensor.temperature = json["RootModelElement"]["Children"][0]["Value"]
        @sensor.animal_id = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][0]["Value"]
        @sensor.animal_name = json["RootModelElement"]["Children"][2]["Children"][0]["Children"][1]["Value"]
      else
        @sensor.error = json("Message")
      end
    rescue Timeout::Error
      @sensor.error = "Timeout error"
    end
  end

end

class Cage
  attr_accessor :id, :name, :type, :animal_id, :animal_name, :error
end

class Sensor
  attr_accessor :id, :name, :temperature, :animal_id, :animal_name, :error
end
