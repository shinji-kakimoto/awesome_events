class TicketsController < ApplicationController
  before_action :authenticate

  # HACK: authenticateメソッドによりログイン画面へ。
  # ログイン時に、URL直接入力時を考慮
  def new
    raise ActionController::RoutingError, 'ログイン状態でTicketsContollerにアクセス'
  end

  def create
    ticket = current_user.tickets.build do |t|
      t.event_id = params[:event_id]
      t.comment = params[:ticket][:comment]
    end
    if ticket.save
      flash[:notice] = 'このイベントに参加表明しました'
      head 201
    else
      # HACK: js側で、「data.responseJSON.messages」の形で取得可能
      render json: { messages: ticket.errors.full_messages }, status: 422
    end
  end

  def destroy
    ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: 'このイベントの参加をキャンセルしました'
  end

end
