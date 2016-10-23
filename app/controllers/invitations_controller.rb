class InvitationsController < ApplicationController
  before_action :authenticate_user!
  def create
    @invitation = Invitation.new(invitation_params.merge(inviter: current_user, building: current_user.building))
    if @invitation.save!
      SlackNotifierWorker.perform_async(:new_invitation, invitation_id: @invitation.id)
      redirect_to :back
    end
  end

  private
  def invitation_params
    params.require(:invitation).permit(:invitee_email, :inviter_id, :building_id)
  end
end
