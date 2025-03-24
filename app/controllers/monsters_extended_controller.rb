# frozen_string_literal: true

class MonstersExtendedController < MonstersController
  def index
    @monsters = Monster.all.order(speed: :desc)
    render json: { data: @monsters }, status: :ok
  end
end
