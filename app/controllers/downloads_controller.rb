class DownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_history_pdf }
    end
  end

  private

  def history_pdf
    find_data
    HistoryPdf.new(@history, @event, @animal_info, @owner_info, @owner_address)
  end

  def find_data
    @event ||= Event.find(params[:event_id])
    @animal_info ||= Animal.find(@event.animal_id)
    @owner_info ||= User.find(@event.user_id)
    @owner_address ||= Address.find(@owner_info.address_id)
    create_event
    @history ||= History.find(params[:history_id])
  end

  def send_history_pdf
    send_file history_pdf.to_pdf,
      filename: history_pdf.filename,
      type: "application/pdf",
      disposition: "inline"
  end

  def create_event
    visit_hash = Hash[VisitType.all.map{ |v| [v.title, v.color] }]
    animals_hash = Hash[Animal.all.map{ |a| [[a.name, a.id], a.id ] }]
    animal_owner = Hash[User.all.map{ |u| [ u.full_name, u.id ] }]
    @event.event_type = visit_hash.key(@event.event_type)
    @event.animal_name = animals_hash.key(@event.animal_id)[0]
    @event.owner_name = animal_owner.key(@event.user_id)
  end
end
