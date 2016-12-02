class EpxesController < ApplicationController

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
