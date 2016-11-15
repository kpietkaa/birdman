require "render_anywhere"

class History < ActiveRecord::Base
  belongs_to :event
end

class HistoryPdf
  include RenderAnywhere

  def initialize(history, event, animal_info, owner_info, owner_address)
    @history = history
    @event = event
    @animal_info = animal_info
    @owner_info = owner_info
    @owner_address = owner_address
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/history.pdf")
  end

  def filename
    "History #{history.id}.pdf"
  end

  private

  attr_reader :history

  def as_html
    render template: "histories/pdf", layout: "history_pdf", locals: { history: @history,
      event: @event, animal_info: @animal_info, owner_info: @owner_info, owner_address: @owner_address }
  end
end
