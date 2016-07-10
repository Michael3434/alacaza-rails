class LeadsController < ApplicationController
  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      redirect_to sent_leads_path
      SlackNotifierWorker.perform_async(:new_lead, lead_id: @lead.id)
    else
      render 'new'
    end
  end

  def new
    @lead = Lead.new
  end

  def sent
    @building = current_user.building if current_user
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :phone, :floor, :address, :code, :command)
  end

end
